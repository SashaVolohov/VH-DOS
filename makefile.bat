@echo off
title VH-DOS
set fasm=tools\fasm.exe
set srcs=sources
set src_boot=sources\boot
set src_krn=sources\kernel
set src_cmds=sources\utils
set src_stp=sources\setup

rem Compiling OS
echo:VH-DOS is compiling...
echo:VH-DOS build at %date%, %time:~0,8%> build.log
echo:>> build.log
for %%a in (%src_boot%\*.asm %src_krn%\*.asm %src_krn%\*.inc %src_cmds%\*.asm %src_stp%\*.asm) do (
	echo:...%cd:~-11%\%%~a>> build.log
	%fasm% %%~a >> build.log
	echo:>> build.log
	if "%errorlevel%" gtr "0" (goto endofcompl)
)

rem Making floppy disk image
echo:Building floppy disk image...
%fasm% %srcs%\compile.asm
copy %srcs%\compile.bin %cd%\setup.img> nul
del %srcs%\*.bin> nul
del %src_boot%\*.bin> nul
del %src_krn%\*.bin> nul
del %src_cmds%\*.bin> nul
del %src_stp%\*.bin> nul

:endofcompl
pause> nul