@echo off
set fasm=tools\fasm.exe
set p2dd=tools\dd.exe
set srcs=sources
set src_boot=sources\boot
set src_krn=sources\kernel
set src_cmds=sources\utils
set src_stp=sources\setup
set src_tmp=sources\tmp

rem Compiling OS
echo Compiling: %cd%\%src_boot%\boot.asm
%fasm% %src_boot%\boot.asm
echo:

echo Compiling: %cd%\%src_boot%\DOSLDR.asm
%fasm% %src_boot%\DOSLDR.asm
echo:

echo Compiling: %cd%\%src_krn%\FHTA.ASM
%fasm% %src_krn%\FHTA.ASM
echo:

echo Compiling: %cd%\%src_krn%\PDWFEDX.asm
%fasm% %src_krn%\PDWFEDX.asm
echo:

echo Compiling: %cd%\%src_krn%\BytR.asm
%fasm% %src_krn%\BytR.asm
echo:

echo Compiling: %cd%\%src_krn%\RASR.asm
%fasm% %src_krn%\RASR.asm
echo:

echo Compiling: %cd%\%src_cmds%\command.asm
%fasm% %src_cmds%\command.asm
echo:

echo Compiling: %cd%\%src_cmds%\cls.asm
%fasm% %src_cmds%\cls.asm
echo:

echo Compiling: %cd%\%src_stp%\boot.asm
%fasm% %src_stp%\boot.asm
echo:

rem Making floppy disk image
%fasm% %srcs%\compile.asm
del disk.img
copy %srcs%\1440.ima %cd%\disk.img
%p2dd% if=VH-DOS/compile.bin of=disk.img conv=notrunc
del %srcs%\*.bin
del %src_boot%\*.bin
del %src_krn%\*.bin
del %src_cmds%\*.bin
del %src_stp%\*.bin

pause> nul
