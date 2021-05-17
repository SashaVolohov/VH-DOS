; Операционная система VH-DOS
; © Саша Волохов, Артём Котов, 2020-2021.

; Данный файл служит для запуска ОС, и загружает следующие программы в память:
; 	/utils/command.asm

	org 0x7C00

include "..\standards.inc"

macro load_in_mem sector, address {
	mov bx,address
	mov cx,sector
	call HDDLIM
}

DOSLDR:
	mov ax,2
	int 10h

	mov bp,start_dos
	call TxtPrint

	mov ah,2
	mov bh,0
	mov dx,0x0200
	int 10h
	
	xor ax,ax
	push ax
	pop es

	;>2;load_in_mem 3,	00600h ; /utils/command.asm
	;>2;load_in_mem 4,	007D0h ; ↑
	;>2;load_in_mem 5,	009D0h ; ↑
	;>2;load_in_mem 6,	00BD0h ; ↑
	;>2;load_in_mem 7,	00DD0h ; ↑
	;>2;load_in_mem 8,	
	load_in_mem 5,	addr_Command ; /utils/command.bin
	load_in_mem 6,	addr_BSOD ; /kernel/BSOD.inc
	
	jmp 0x0600
	; jmp $ ; Возможно, никогда досюда процесс не дойдёт

include "..\kernel\TxtPrint.inc"

HDDLIM:
	xor ax,ax
	mov es,ax

	mov dx,0x80
	mov al,1
	mov ah,2
	int 13h	
;----
start_dos db 'Starting VH-DOS...',0
error_start db 'Cannot find COMMAND.SYS',0
