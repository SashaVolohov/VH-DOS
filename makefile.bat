@echo off
set fasm=tools\fasm.exe
set srcs=sources
set src_boot=sources\boot
set src_krn=sources\kernel
set src_cmds=sources\utils
set src_stp=sources\setup

rem Compiling OS
%fasm% %src_boot%\*.asm
%fasm% %src_krn%\*.asm
%fasm% %src_cmds%\*.asm
%fasm% %src_stp%\*.asm

rem Making floppy disk image
%fasm% %srcs%\compile.asm
copy %srcs%\compile.bin %cd%\setup.img
del %srcs%\*.bin
del %src_boot%\*.bin
del %src_krn%\*.bin
del %src_cmds%\*.bin
del %src_stp%\*.bin

pause> nul
