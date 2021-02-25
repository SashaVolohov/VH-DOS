; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.

; Данный файл служит для запуска ОС.
; Этот файл находится в MBR дискеты/жёсткого диска. Загружается по адресу 0000:7C00

	org 07C00h

DOSLDR		equ 000000500h

start:
	cli
	xor ax,ax
	mov ds,ax
	mov es,ax
	mov ss,ax
	mov sp,07C00h
	sti

	mov ax,2
	int 10h
	mov ah,2
	mov bh,0
	xor dx,dx
	int 10h

	mov bp,fail_ldr
	call TxtPrint

	mov ah,2
	mov bh,0
	mov dx,00100h
	int 10h

	mov bp,fail_ldr_two
	call TxtPrint

	mov ax,0
	mov es,ax
	mov bx,00500h
	mov ch,0
	mov cl,2
	mov dh,0
	mov dl,80d
	mov al,1
	mov ah,2
	int 13h
	jmp DOSLDR
	call ClearMes

	mov ah,2
	mov bh,0
	mov dh,2
	mov dl,0
	int 10h

	jmp $ ; переход на DOSLDR

include "..\kernel\TxtPrint.asm" ; because TxtPrint isn't loaded yet

ClearMes:
	mov ah,6
	mov al,0
	mov bh,7
	mov cx,0
	mov dx,0184Fh
	int 10h
	ret
;----
fail_ldr db 'DOSLDR is missing.',0
fail_ldr_two db 'Press <Ctrl>-<Alt>-<Del> to restart.',0
;----
times(512-2-($-07C00h)) db 0 ; OLD
db 055h,0AAh; FAT12 bootable medium