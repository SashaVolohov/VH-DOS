; VH-DOS the operating system
; (c) Sasha Volohov, 2020-present.
; Numerous revisions (c) VH-DOS Development Team. 2021-present.

; Данный файл служит для запуска ОС.
; Этот файл находится в MBR дискеты/жёсткого диска.
; Загружается по адресу 0000:7C00

	org 0x0600

include "..\standards.inc"

macro PrintOut string_offset {
	mov bp, string_offset
	call TxtPrint
}

start:
	cli
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7C00
	sti

	mov ax, Standard_video_mode
	int 0x10

	ClearExtSeg
	ReadSector 2, HDD1, addr_DOSLDR
	jc DiskError
	jmp addr_DOSLDR

DiskError:
	ClearScreen ; ?
	SetCursorPosition 0x02, 0x00 ; ?
	jmp addr_BSOD ; ?

include "..\kernel\TxtPrint.inc"
include "..\kernel\PCSpeaker.inc"

fail_ldr_str1 db 'DOSLDR is missing.', 36 + 1 dup (0)
fail_ldr_str2 db 'Press <Ctrl>-<Alt>-<Del> to restart.',0

	FAT12_MBR_end ; hard drive (0x80)
