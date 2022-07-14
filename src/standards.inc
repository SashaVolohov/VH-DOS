; Global macros, constants

addr_Command		equ 0x1000
addr_DOSLDR		equ 0x0500
addr_BSOD		equ 0x1000
addr_command_reboot	equ 0x07EE
addr_MultiTxtPrint	equ 0x0A30
addr_ClearScreen	equ 0x0BAD

FDD1 equ 0x00 ; Floppy Disk Drive 0x01/0x80
HDD1 equ 0x80 ; Hard Disk Drive #1 (Primary Master)

Standard_video_mode equ 2

macro zerobytes length {
	db length - 1 - ($ + length - 1) mod (length) dup 0
}

macro FAT12_MBR {
	include "..\FAT12_BPB_generator.asm"
}

macro FAT12_MBR_end {
	db (512 - 2 - (0 - $)) dup (0)
	dw 0xAA55
}

macro FormatSector sector, drvindex {
	mov ax, 0x0501
	mov cx, 0 + sector
	mov dx, 0 + drvindex
	int 0x13
	sti
}

macro ClearExtSeg {
	xor ax, ax
	mov es, ax
}

macro ReadSector index, drvindex, memaddr {
	mov ax, 0x0201
	mov bx, memaddr
	; ~ if drvindex >= 1
		mov cl, drvindex
		xor ch, ch; HEAD = 1
	; ~ else
	; ~	xor cx,cx
	; ~ end if
	xor dx, dx
	int 0x13
	; ~ sti
}

macro WriteSector index, drvindex, memaddr {
	mov ax, 0x0301
	mov bx, memaddr
	mov cx, index
	; ~ if drvindex >= 1
		mov dl, drvindex
		xor dh, dh; HEAD = 1
	; ~ else
	; ~ 	xor dx,dx
	; ~ end if
	int 0x13
	; ~ sti
}

macro TryRead index, drvindex, memaddr, reptimes {
	mov cx, reptimes
	push cx
@@:
	pop cx
	cmp cx,cx
	jz @f
	dec cx
	push cx
	mov ah, 0
	mov dl, drvindex
	int 0x13
	; ~ sti
	
	ClearExtSeg

	mov ax, 0x0201
	mov bx, memaddr
	mov cx, index
	; ~ if drvindex >= 1
		mov dl, drvindex
		xor dh, dh; HEAD = 1
	; ~ else
	; ~ 	xor dx,dx
	; ~ end if
	int 0x13
	; ~ sti
	jc @b
@@:
}

macro ClearScreen {
	mov ax, 0x0600
	mov bh, 7
	mov cx, 0
	mov dx, 0x184F
	int 0x10
}

macro SetCursorPosition rgDH, rgDL {
	mov ah, 2
	mov bh, 0
	mov dh, rgDH
	mov dl, rgDL
	int 0x10
}
