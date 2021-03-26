; Глобальные макросы, константы

; "Поскольку я посчитал нерациональным каждый раз
;  указывать    адрес   того же   BSOD,   я решил
;  разместить   всё  в   одном   месте,  чтобы не
;  искать адреса каждый раз.  А исправлять ошибки
;  стало проще."
; - Diicorp95

addr_Command		equ 0x1000
addr_DOSLDR			equ 0x0500
addr_BSOD			equ 0x1000
addr_command_reboot	equ 0x07EE
addr_MultiTxtPrint	equ 0x0A30
addr_ClearScreen	equ 0x0BAD

FDD1 equ 0x00 ; Floppy Disk Drive 0x01/0x80
HDD1 equ 0x80 ; Hard Disk Drive 0x01

Standard_video_mode equ 2

macro zerobytes length {
	db length - 1 - ($ + length - 1) mod (length) dup 0
}

macro Initial_Bootcode {
	cli
	xor ax,ax
	mov ds,ax
	mov es,ax
	mov ss,ax
	mov sp,07C00h
	sti
}

macro FAT12_MBR {
	include "..\FAT12_BPB_generator.asm"
}

macro FAT12_MBR_end {
	db (512 - 2 - (0 - $)) dup (0)
	dw 0AA55h
}

macro FormatSector sector, drvindex {
	mov ax,0x0501
	xor ch,ch
	mov cl,sector
	xor dh,dh
	mov dl,drvindex
	int 13h
	sti
}

macro ClearExtSeg {
	xor ax,ax
	mov es,ax
}

macro ReadSector index, drvindex, memaddr {
	mov ax,0x0201
	mov bx,memaddr
	;;>?1>if drvindex >= 1
		mov cl,drvindex
		xor ch,ch; HEAD = 1
	;>?1>else
	;;>?1>	xor cx,cx
	;;>?1>end if
	xor dx,dx
	int 13h
	sti
}

macro WriteSector index, drvindex, memaddr {
	mov ax,0x0301
	mov bx,memaddr
	mov cx,index
	;>?1>if drvindex >= 1
		mov dl,drvindex
		xor dh,dh; HEAD = 1
	;>?1>else
	;>?1>	xor dx,dx
	;>?1>end if
	int 13h
	sti
}

macro TryRead index, drvindex, memaddr, reptimes {
	mov cx,reptimes
	push cx
@@:
	pop cx
	cmp cx,cx
	jz @f
	dec cx
	push cx
	mov ah,0
	mov dl,drvindex
	int 13h
	sti
	
	ClearExtSeg

	mov ax,00201h
	mov bx,memaddr
	mov cx,index
	;>?1>if drvindex >= 1
		mov dl,drvindex
		xor dh,dh; HEAD = 1
	;>?1>else
	;>?1>	xor dx,dx
	;>?1>end if
	int 13h
	sti
	jc @b
@@:
}

macro ClearScreen {
	mov ah,6
	mov al,0
	mov bh,7
	mov cx,0
	mov dx,0184Fh
	int 10h
	ret
}

macro SetCursorPosition rgDH, rgDL {
	mov ah,2
	mov bh,0
	mov dh,rgDH
	mov dl,rgDL
	int 10h
}