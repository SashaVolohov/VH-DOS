; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.
; Многочисленные редакции © Артём Котов. 2021.

; Данный файл служит для запуска ОС.
; Этот файл находится в MBR дискеты/жёсткого диска. Загружается по адресу 0000:7C00

	org 07C00h

include "..\standards.inc"

macro PrintOut string_offset {
	mov bp,string_offset
	call TxtPrint
}

start:
	Initial_Bootcode

	mov ax,Standard_video_mode
	int 10h

	SetCursorPosition 0x00 0x00
	PrintOut fail_ldr
	SetCursorPosition 0x01 0x00
	PrintOut fail_ldr_two
	ClearExtSeg
	ReadSector 2, HDD1, DOSLDR
	jmp DOSLDR
	ClearScreen
	SetCursorPosition 0x02 0x00
	jmp DOSLDR

include "..\kernel\TxtPrint.inc"

fail_ldr db 'DOSLDR is missing.',0
fail_ldr_two db 'Press <Ctrl>-<Alt>-<Del> to restart.',0

	FAT12_MBR_end ; жёсткий диск