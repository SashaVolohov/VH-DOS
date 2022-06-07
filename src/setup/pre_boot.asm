; VH-DOS the operating system
; by Sasha Volohov, 2020-2021.
; Reorganization by VH-DOS Development Team, 2021-present.

; This file is used to install the OS.
; It's placed in the boot sector of the installation image, and is loaded at
; address 0000:7C00.

	org 0x7C00

include "..\standards.inc"

start:
	; ~ FAT12_MBR ; FAT12 part
	cli
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7C00
	sti

	TryRead 3, FDD1, 0x8E95, 4
	jmp 0x8E95

	FAT12_MBR_end
