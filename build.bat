@echo off
echo Compile source...

@fasm VH-DOS\boot\boot.asm
@fasm VH-DOS\boot\DOSLDR.asm
@fasm VH-DOS\kernel\FHTA.ASM
@fasm VH-DOS\kernel\PDWFEDX.asm
@fasm VH-DOS\kernel\BytR.asm
@fasm VH-DOS\kernel\RASR.asm

@fasm VH-DOS\setup\boot.asm
@fasm VH-DOS\setup\DOSLDR.asm
@fasm VH-DOS\setup\finish.asm

@fasm VH-DOS\compile.asm

echo Creating image...

@del disk.img
@copy VH-DOS\tmp\zero.ima disk.img
@dd if=VH-DOS/compile.bin of=disk.img conv=notrunc

@pause