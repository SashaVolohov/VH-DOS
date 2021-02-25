; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.

; Данный файл служит для установки ОС.
; Загружается по адресу 0000:7E00

	org 07C00h

start:
	mov ax,2
	int 10h

	mov bp,fail_ldr
	call TxtPrint

	mov ah,2
	mov bh,0
	mov dx,00100h
	int 10h
	
	mov bp,ctrlaltdel_msg
	call TxtPrint

	; xor ax,ax
	; mov es,ax ; заменено
	
	mov bx,Step2 ; was 00500h
	mov ch,0
	mov cl,2
	mov dh,0
	mov dl,0
	mov al,1
	mov ah,2
	int 13h
	jmp Step2

	call ClearScreen

	mov ah,2
	mov bh,0
	mov dh,2
	mov dl,0
	int 10h

include "..\kernel\TxtPrint.asm" ; because no kernel modules, - no OS
include "..\kernel\ClearScreen.asm"
	
Step2:	
	mov ax,2
	int 10h
	
	mov ah,2
	mov bh,0
	mov dh,0
	mov dl,0
	int 10h
	
	;>S>;mov bp,setup_welcome
	;>S>;call TxtPrint
	
	mov ah,2
	mov bh,0
	mov dh,2
	mov dl,0
	int 10h
	
	;>S>;mov bp,setup_welcome_2
	;>S>;call TxtPrint
	
	mov ah,2
	mov bh,0
	mov dh,3
	mov dl,0
	int 10h
	
	;>S>;mov bp,ctrlaltdel_msg
	;>S>;call TxtPrint
	
	mov ah,2
	mov bh,0
	mov dh,5
	mov dl,0
	int 10h
	
	mov ah,10h
    int 16h
	cmp al,0Dh
    jz install
	jmp start
	
install:
	mov ax,0000h
	mov es,ax
	mov bx,900h
	mov ch,0
	mov cl,06h
	mov dh,0
	mov	dl,0h
	mov al,01h
	mov ah,02h
	int 13h ; чтение boot файла
	
	mov ah,05h
	mov al,01h
	mov ch,0
	mov cl,03h
	mov dh,0h
	mov dl,80h
	int 13h
	
	mov ax,0000h
	mov es,ax
	mov bx,900h
	mov ch,0
	mov cl,03h
	mov dh,0
	mov	dl,80h
	mov al,01h
	mov ah,03h
	int 13h
	
	mov ax,0000h
	mov es,ax
	mov bx,0AD0h
	mov ch,0
	mov cl,07h
	mov dh,0
	mov dl,0h
	mov al,01h
	mov ah,02h
	int 13h ; чтение boot файла

	mov ah,05h
	mov al,01h
	mov ch,0
	mov cl,04h
	mov dh,0h
	mov dl,80h
	int 13h

	mov ax,0
	mov es,ax
	mov bx,0AD0h
	mov ch,0
	mov cl,4
	mov dh,0
	mov	dl,80h
	mov al,1
	mov ah,3
	int 13h

	mov ax,2
    int 10h

	mov ah,2
	mov bh,0
	mov dh,0
	mov dl,0
	int 10h

	;>S>;mov bp,setup_complete
	;>S>;call TxtPrint

	mov ah,10h
    int 16h

	mov ax,40h
	push ax
	pop ds
	mov word ptr ds:72h, 1234h
	mov ax,0FFFFh
	push ax
	push 0
	retf
	jmp $
;----
fail_ldr db 'DOSLDR is missing, can',27h,'t continue boot process.',0
ctrlaltdel_msg db 'Press <Ctrl>-<Alt>-<Del> to restart...',0
setup_welcome: db 'VH-DOS '
	file "..\version.txt"
	db ': Setup',0
setup_welcome_2 db 'Press Enter to start the installation.',0
setup_progress db 'Setup is copying files...',0
setup_error db 'Disk I/O error, can',27h,'t continue.',0
setup_complete db 'Setup completed. Eject the floppy disk and press any key to reboot computer.',0