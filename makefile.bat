@echo off
set fasm=tools\fasm.exe
set srcs=sources
set src_boot=sources\boot
set src_krn=sources\kernel
set src_cmds=sources\utils
set src_stp=sources\setup

rem Compiling OS
for %%a in (%src_boot%\*.asm) do %fasm% %%~a
for %%a in (%src_krn%\*.asm) do %fasm% %%~a
for %%a in (%src_cmds%\*.asm) do %fasm% %%~a
for %%a in (%src_stp%\*.asm) do %fasm% %%~a

rem Making floppy disk image
%fasm% %srcs%\compile.asm
copy %srcs%\compile.bin %cd%\setup.img> nul
del %srcs%\*.bin> nul
del %src_boot%\*.bin> nul
del %src_krn%\*.bin> nul
del %src_cmds%\*.bin> nul
del %src_stp%\*.bin> nul

pause> nul