"""Runs stcgal 1.10 with the restart pulse the TSI board needs, then stcgal's normal command line.

python tools/flash_stcgal.py -a -P stc89 -p COM13 file.hex

stcgal's own -a (and -a -A rts) switches the line on for 250 ms and then off. On the TSI STC89C52RC board the
chip only restarts into its bootloader when RTS goes OFF for a moment and then back ON (tools/probe_stc.py,
7 Nov 2026: rts-inv answered 4 times out of 4, dtr, rts and dtr-inv never did). This file replaces stcgal's
restart function with that pulse and changes nothing else.

stcgal: MIT licence, copyright Grigori Goronzy and others, https://github.com/grigorig/stcgal
"""
import sys
import time

import stcgal.protocols as protocols
from stcgal.frontend import cli


def reset_rts_off_on(self, resetcmd=False, resetpin=False):
    print("Cycling power (RTS off 500 ms, then on): ", end="")
    sys.stdout.flush()
    self.ser.setRTS(False)
    time.sleep(0.5)
    self.ser.setRTS(True)
    print("done")
    print("Waiting for MCU: ", end="")
    sys.stdout.flush()


protocols.StcBaseProtocol.reset_device = reset_rts_off_on

if __name__ == "__main__":
    sys.exit(cli())
