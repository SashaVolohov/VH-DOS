; Глобальные макросы, константы

; "Поскольку я посчитал нерациональным каждый раз
;  указывать    адрес   того же   BSOD,   я решил
;  разместить   всё  в   одном   месте,  чтобы не
;  искать адреса каждый раз.  А исправлять ошибки
;  стало проще."
; - Diicorp95

FDD1 equ 0x00 ; Floppy Disk Drive 1/80
HDD1 equ 0x80 ; Hard Disk Drive 1/(80+x)

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
	db 0xEB,0x58,0x90
	db 'VH-DOS',3 dup (0)
	db 0x02,2 dup (0x01),0,0x02
	db 0xE0,0x00,0x40,0x0B,0xF0
	db 0x09,0x00,0x12,0x00,0x02
	db 11 dup (0)
	db 0x29,0xE2,0x46,0x4E,0x29
	db 11 dup (0x20)
	db 046h,041h,054h,031h,032h,3 dup (0x20)
	db 28 dup (0)
}

macro FAT12_MBR_end {
	db (512 - 2 - (07C00h - $)) dup (0)
	dw 0AA55h
}

macro FormatSector sector, drvindex {
	mov ax,0x0501
	mov cx,sector
	xor dh,dh
	mov dl,drvindex
	int 13h
}

macro ClearExtSeg {
	xor ax,ax
	mov es,ax
}

macro ReadSector index, drvindex, memaddr {
	mov ax,0x0201
	mov bx,memaddr
	if drvindex >= 1
		mov cl,drvindex
		xor ch,ch; HEAD = 1
	else
		xor cx,cx
	end if
	xor dx,dx
	int 13h
}

macro WriteSector index, drvindex, memaddr {
	mov ax,0x0301
	mov bx,memaddr
	mov cx,index
	if drvindex >= 1
		mov dl,drvindex
		xor dh,dh; HEAD = 1
	else
		xor dx,dx
	end if
	int 13h
}

macro TryRead index, drvindex, memaddr, reptimes {
	mov cx,reptimes
	push cx
@@:
	mov ah,0
	mov dl,drvindex
	int 13h
	
	ClearExtSeg

	mov ax,00201h
	mov bx,memaddr
	mov cx,index
	if drvindex >= 1
		mov dl,drvindex
		xor dh,dh; HEAD = 1
	else
		xor dx,dx
	end if
	int 13h
	jc @b
@@:
}

macro SetCursorPosition rgDH, rgDL {
	mov ah,2
	mov bh,0
	mov dx,rgDH rgDL
	int 10h
}