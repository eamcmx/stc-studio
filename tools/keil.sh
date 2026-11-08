#!/bin/bash
# Assembles one file with Keil C51 9.61 (A51 -> BL51 -> OH51), the steps uVision runs on F7.
#   tools/keil.sh <file.a51|file.asm> <outdir>
# Writes <outdir>/<name>.hex, .lst, .m51 and errors.txt (the *** ERROR / *** WARNING lines of the listing and
# the linker). Exit 0 = a hex file was made, 1 = A51 or BL51 reported an error.
K="C:/Keil_v5/C51/BIN"
src="$1"; out="$2"
name=$(basename "$src"); name="${name%.*}"
# A51 wants 8.3-friendly names: build as t.a51 in the out dir, then rename the results
mkdir -p "$out"
rm -f "$out"/t.* "$out/$name".* "$out/errors.txt"
cp "$src" "$out/t.a51"
cd "$out" || exit 2
"$K/A51.EXE" t.a51 > a51.log 2>&1
grep -E '^\*\*\* (ERROR|WARNING)' t.lst > errors.txt 2>/dev/null
ok=1
if grep -q 'ERROR' errors.txt || [ ! -f t.obj ]; then ok=0; fi
if [ $ok = 1 ]; then
  "$K/BL51.EXE" t.obj TO t > bl51.log 2>&1
  grep -E 'ERROR|WARNING' bl51.log | grep -v 'COMPLETE' >> errors.txt
  if grep -q 'ERROR' bl51.log | grep -v '0 ERROR' ; then ok=0; fi
  grep -qE '[1-9][0-9]* ERROR' bl51.log && ok=0
  if [ $ok = 1 ]; then "$K/OH51.EXE" t > oh51.log 2>&1; fi
fi
for f in t.*; do mv "$f" "$name.${f#t.}"; done
[ -f "$name.hex" ] && [ $ok = 1 ] && exit 0
rm -f "$name.hex"
exit 1
