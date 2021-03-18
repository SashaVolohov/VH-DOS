; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.
; Многочисленные редакции © Артём Котов. 2021.

; Данный файл служит для запуска ОС.
; Этот файл находится в MBR дискеты/жёсткого диска. Загружается по адресу 0000:7C00

	org 0

include "..\standards.inc"

macro PrintOut string_offset {
	mov bp,string_offset
	call TxtPrint
}

start:
	Initial_Bootcode

	mov ax,Standard_video_mode
	int 10h

	SetCursorPosition 0x00, 0x00
	PrintOut fail_ldr_str1
	SetCursorPosition 0x01, 0x00
	PrintOut fail_ldr_str2
	
	ClearExtSeg
	ReadSector 2, HDD1, addr_DOSLDR
	jmp addr_DOSLDR
	
	ClearScreen ; ?
	SetCursorPosition 0x02, 0x00 ; ?
	jmp addr_DOSLDR ; ?

include "..\kernel\TxtPrint.inc"

fail_ldr_str1 db 'DOSLDR is missing.',36+1 dup (0)
fail_ldr_str2 db 'Press <Ctrl>-<Alt>-<Del> to restart.',0

	FAT12_MBR_end ; жёсткий диск