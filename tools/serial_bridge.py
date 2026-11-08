"""Relays a serial port to stdin/stdout so node can drive it (test/board_node.js), without a native node module.

python tools/serial_bridge.py COM13 19200
stdin, one command per line:  W <hex bytes>  |  RTS 0|1  |  DTR 0|1  |  BAUD <n>  |  QUIT
stdout: R <hex bytes> for every chunk received, OK after each command, ERR <text> on failure.
The port opens with DTR and RTS on, as pyserial and Chrome do.
"""
import sys
import threading

import serial


def main():
    port, baud = sys.argv[1], int(sys.argv[2])
    ser = serial.Serial(port=port, baudrate=baud, parity=serial.PARITY_NONE, timeout=0.01)
    ser.dtr = True
    ser.rts = True
    lock = threading.Lock()

    def out(s):
        with lock:
            sys.stdout.write(s + '\n')
            sys.stdout.flush()

    stop = threading.Event()

    def reader():
        while not stop.is_set():
            try:
                b = ser.read(256)
            except serial.SerialException as e:
                out('ERR ' + str(e))
                return
            if b:
                out('R ' + b.hex())

    threading.Thread(target=reader, daemon=True).start()
    out('READY')
    for line in sys.stdin:
        parts = line.strip().split(' ', 1)
        cmd = parts[0]
        try:
            if cmd == 'W':
                ser.write(bytes.fromhex(parts[1]))
                ser.flush()
            elif cmd == 'RTS':
                ser.rts = parts[1] == '1'
            elif cmd == 'DTR':
                ser.dtr = parts[1] == '1'
            elif cmd == 'BAUD':
                ser.baudrate = int(parts[1])
            elif cmd == 'QUIT':
                break
            out('OK')
        except Exception as e:  # report and keep going; node decides
            out('ERR ' + str(e))
    stop.set()
    ser.close()


if __name__ == '__main__':
    main()
