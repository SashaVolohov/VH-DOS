; Операционная система VH-DOS
; © Саша Волохов, Артём Котов, 2020-2021.

; Данный файл служит для запуска ОС, и загружает следующие программы в память:
; 	/utils/command.asm

	org 0

MACRO load_in_mem sector, address {
	xor ax,ax
	mov es,ax
	mov bx,address
	mov ch,0
	mov cl,sector
	mov dh,0
	mov dl,80h
	mov al,1
	mov ah,2
	int 13h
}

; Knowledge base
Task_command		equ 000000600h
;--------------------

Task_DOSLDR:
	mov ax,2
	int 10h

	mov bp,start_dos
	call TxtPrint

	mov ah,2
	mov bh,0
	mov dx,00200h
	int 10h
	
	;>1>;xor ax,ax
	push word 0
	pop es

	;>2;load_in_mem 3,	00600h ; /utils/command.asm
	;>2;load_in_mem 4,	007D0h ; ↑
	;>2;load_in_mem 5,	009D0h ; ↑
	;>2;load_in_mem 6,	00BD0h ; ↑
	;>2;load_in_mem 7,	00DD0h ; ↑
	;>2;load_in_mem 8,	
	;load_in_mem 2, 
	load_in_mem 4,	0x0600 ; /utils/command.bin
	load_in_mem 5,	0x1000 ; /kernel/BSOD.inc
	
	jmp Task_command
	; jmp $ ; Возможно, никогда досюда процесс не дойдёт

TxtPrint:
	mov si,bp
	xor bx,bx
TxtPrint@01:
	cmp bx,0FFFFh
	jz TxtPrint@02
	push bx
	mov bp,bx
	mov al,[si+bp]
	pop bx
	cmp al,0
	jz TxtPrint@02
	mov [TxtPrint_Data01],al
	push ax bx si bp
	mov ah,0Ah
	xor bx,bx
	mov cx,1
	mov al,[TxtPrint_Data01]
	int 10h
	pop bp si bx ax
	mov ah,03h
	xor bx,bx
	int 10h
	mov ah,02h
	xor bx,bx
	inc dl
	int 10h
	pop bx
	inc bx
	jmp TxtPrint@01
TxtPrint_Data01 db 0
TxtPrint@02:
	xor bx,bx
	xor bp,bp
	xor si,si
	xor ax,ax
	ret
;----
start_dos db 'Starting VH-DOS...',0
error_start db 'Cannot find COMMAND.SYS',0