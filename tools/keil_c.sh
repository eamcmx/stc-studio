#!/bin/bash
# Compiles one C file with Keil C51 9.61 (compiler C51 V9.60.7.0, assembler A51 V8.2.7.0) (C51 -> BL51 -> OH51), the steps uVision runs on F7.
#   tools/keil_c.sh <file.c> <outdir> [extra C51 options, e.g. "DEFINE(LONGMUL)" "OPTIMIZE(9,SIZE)"]
# Headers next to the .c file are copied along. Writes <outdir>/<name>.hex, .lst, .m51 and errors.txt.
# Exit 0 = a hex file was made.
K="C:/Keil_v5/C51"
src="$1"; out="$2"; shift 2
name=$(basename "$src"); name="${name%.*}"
mkdir -p "$out"
rm -f "$out"/t.* "$out/$name".* "$out/errors.txt"
cp "$src" "$out/t.c"
cp "$(dirname "$src")"/*.h "$out/" 2>/dev/null
cd "$out" || exit 2
export C51INC="$K/INC" C51LIB="$K/LIB"
"$K/BIN/C51.exe" t.c "$@" > c51.log 2>&1
grep -E '(ERROR|WARNING) C[0-9]+' c51.log > errors.txt
ok=1
[ -f t.obj ] || ok=0
grep -qE '[1-9][0-9]* ERROR' c51.log && ok=0
if [ $ok = 1 ]; then
  "$K/BIN/BL51.EXE" t.obj TO t "RAMSIZE(256)" > bl51.log 2>&1   # the STC89C52RC has 256 bytes of internal RAM
  grep -E 'ERROR|WARNING' bl51.log | grep -v 'COMPLETE' >> errors.txt
  grep -qE '[1-9][0-9]* ERROR' bl51.log && ok=0
  if [ $ok = 1 ]; then "$K/BIN/OH51.EXE" t > oh51.log 2>&1; fi
fi
for f in t.*; do mv "$f" "$name.${f#t.}"; done
[ -f "$name.hex" ] && [ $ok = 1 ] && exit 0
rm -f "$name.hex"
exit 1
