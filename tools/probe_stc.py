"""Finds out how the STC89C52RC bootloader on the TSI board answers, without writing anything to the chip.

python tools/probe_stc.py COM12 dtr|dtr-inv|rts|rts-inv|manual [seconds]

Opens the port at 2400 baud 8N1, restarts the chip the chosen way (or waits for a manual power cycle), sends
0x7F every 30 ms like stcgal and AiCube do, and prints the first status packet it gets back: raw bytes, the
protocol it belongs to (stc89 starts the payload with 00H, stc89a with 50H), the model magic, the bootloader
version, the clock it measured and the option byte. After the status packet it sends the stc89 "reset" packet
(82H), which starts the program already in flash. Nothing is erased or written.

The restart methods copy stcgal 1.10 (MIT licence, Grigori Goronzy and others, github.com/grigorig/stcgal):
dtr = DTR on 250 ms then off (stcgal -a), rts = the same on RTS (stcgal -a -A rts); the -inv variants do it the
other way round (off 500 ms, then on), as stcgal's stc89a code does.
"""
import struct
import sys
import time

import serial

MAGIC = {0xF002: 'STC89C52RC/LE52RC', 0xF051: 'STC89C52', 0xF102: 'STC89C52RD+/LE52RD+'}


def restart(ser, how):
    if how in ('dtr', 'rts'):
        setp = ser.setDTR if how == 'dtr' else ser.setRTS
        setp(True); time.sleep(0.25); setp(False); time.sleep(0.03)
    elif how in ('dtr-inv', 'rts-inv'):
        setp = ser.setDTR if how == 'dtr-inv' else ser.setRTS
        setp(False); time.sleep(0.5); setp(True)
    else:
        print('Switch the board OFF and ON now.', flush=True)


def find_packet(buf):
    """Returns (start, end) of the first whole 46 B9 68 .. 16 packet in buf, or None. Some bootloaders drop the
    46 B9 before the status packet, so a packet may also start at a bare 68H."""
    for i in range(len(buf)):
        if buf[i:i + 3] == b'\x46\xb9\x68':
            hdr = i + 3
        elif buf[i] == 0x68 and (i == 0 or buf[i - 1] != 0xB9):
            hdr = i + 1
        else:
            continue
        if len(buf) < hdr + 2:
            return None
        n, = struct.unpack('>H', buf[hdr:hdr + 2])   # length counts from the 68H byte to the end byte
        end = hdr - 1 + n
        if len(buf) >= end and buf[end - 1] == 0x16:
            return i, end
    return None


def main():
    port, how = sys.argv[1], sys.argv[2]
    secs = float(sys.argv[3]) if len(sys.argv) > 3 else 15
    ser = serial.Serial(port=port, baudrate=2400, parity=serial.PARITY_NONE, timeout=0)
    print(f'{port} open, DTR={ser.dtr} RTS={ser.rts} before the restart', flush=True)
    ser.reset_input_buffer()
    restart(ser, how)
    t0, buf, found = time.time(), b'', None
    while time.time() - t0 < secs and not found:
        ser.write(b'\x7f'); ser.flush()
        time.sleep(0.03)
        buf += ser.read(4096)
        found = find_packet(buf)
    if not found:
        print(f'NO ANSWER after {secs:.0f} s ({how}); stray bytes: {buf[:64].hex(" ")}')
        ser.close()
        return 1
    # let the rest of the packet arrive, then decode it
    a, b = found
    pkt = buf[a:b]
    print(f'answer after {time.time() - t0:.2f} s ({how})')
    print('raw:', pkt.hex(' '))
    payload = pkt[pkt.index(0x68) + 3:]
    kind = {0x00: 'stc89', 0x50: 'stc89a'}.get(payload[0], f'unknown ({payload[0]:02X}H)')
    print('protocol:', kind)
    if kind == 'stc89':
        csum_ok = (sum(pkt[pkt.index(0x68):-2]) & 0xFF) == pkt[-2]
        body = payload[:-2]
        freq = sum(struct.unpack('>H', body[1 + 2 * i:3 + 2 * i])[0] for i in range(8)) / 8
        msr = body[19]
        t6 = not (msr & 1)
        clock = 2400 * freq * (6 if t6 else 12) / 7
        ver, step = body[17], body[18]
        magic, = struct.unpack('>H', body[20:22])
        print(f'checksum ok: {csum_ok}')
        print(f'model magic {magic:04X}H = {MAGIC.get(magic, "not in the short list")}')
        print(f'bootloader {ver >> 4}.{ver & 15}{chr(step)}, option byte {msr:02X}H ({"6T" if t6 else "12T"}), '
              f'clock measured {clock / 1e6:.4f} MHz')
        # 82H = leave the bootloader and run the program in flash (stcgal Stc89Protocol.disconnect)
        out = b'\x46\xb9\x6a' + struct.pack('>H', 6) + b'\x82'
        out += bytes([sum(out[2:]) & 0xFF]) + b'\x16'
        ser.write(out); ser.flush(); time.sleep(0.2)
        print('sent 82H (run the program in flash)')
    elif kind == 'stc89a':
        body = payload[:-3]
        magic, = struct.unpack('>H', body[20:22])
        freq, = struct.unpack('>H', body[13:15])
        print(f'model magic {magic:04X}H = {MAGIC.get(magic, "?")}, option byte {body[1]:02X}H, '
              f'bootloader {body[17] >> 4}.{body[17] & 15}.{body[22] & 15}{chr(body[18])}, '
              f'clock measured {12 * freq * 2400 / 1e6:.4f} MHz')
        print('stc89a: not sending anything else (its run command needs even parity)')
    ser.close()
    return 0


if __name__ == '__main__':
    sys.exit(main())
