@echo off
set fasm=tools\fasm.exe
set srcs=sources
set src_boot=sources\boot
set src_krn=sources\kernel
set src_cmds=sources\utils
set src_stp=sources\setup
set src_tmp=sources\tmp
rem Compiling OS
%fasm% %src_boot%\boot.asm
%fasm% %src_boot%\DOSLDR.asm
%fasm% %src_krn%\FHTA.ASM
%fasm% %src_krn%\PDWFEDX.asm
%fasm% %src_krn%\BytR.asm
%fasm% %src_krn%\RASR.asm
%fasm% %src_cmds%\command.asm
%fasm% %src_cmds%\cls.asm
%fasm% %src_stp%\boot.asm
%fasm% %src_stp%\DOSLDR.asm
%fasm% %src_stp%\finish.asm

rem Creation of floppy disk image

%fasm% %srcs%\compile.asm
del disk.img
copy %src_tmp%\zero.ima %cd%\disk.img
dd if=VH-DOS/compile.bin of=disk.img conv=notrunc
pause> nul
