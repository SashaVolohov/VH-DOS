; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.

; Данный файл служит для установки ОС.
; Загружается по адресу 0000:7E00

	org 07C00h; для BIN

start:
	;;RC;;mov ax,3
	;;RC;;int 10h
	
	mov bp,fail_ldr
	call TxtPrint
	
	;;RC;;mov ah,02h
	;;RC;;mov bh,0
	;;RC;;mov dh,1
	;;RC;;mov dl,0
	;;RC;;int 10h
	
	;;RC;;mov bp,ctrlaltdel_msg
	;;RC;;call TxtPrint
	
	xor ax,ax
	; mov es,ax ; заменено
	
	;mov bx,00500h
	mov bx,Step2
	mov ch,0
	mov cl,2
	mov dh,0
	mov dl,0
	mov al,1
	mov ah,2
	int 13h
	jmp Step2
	
	;;RC;;call ClearScreen
	
	;;RC;;mov ah,2
	;;RC;;mov bh,0
	;;RC;;mov dh,2
	;;RC;;mov dl,0
	;;RC;;int 10h
	
TxtPrint:
	mov si,bp
	xor bx,bx
	mov [TxtPrint_counter],bx
TxtPrint@01:
	mov bx,TxtPrint_counter
	cmp bx,0FFFFh
	jz TxtPrint@02
	mov al,byte [si+bx]
	cmp al,0
	jz TxtPrint@02
	mov [TxtPrint_counter],bx
	mov ah,09h
	mov al,[TxtPrint_Data01]
	mov bh,0
	mov bl,07h
	mov cx,1
	int 10h
	mov ah,03h
	xor bx,bx
	int 10h
	mov ah,02h
	xor bx,bx
	inc dl
	int 10h
	mov bx,TxtPrint_counter
	inc bx
	jmp TxtPrint@01
TxtPrint_Data01 db 0
TxtPrint_counter dw 0
TxtPrint@02:
	xor bx,bx
	xor bp,bp
	xor si,si
	xor ax,ax
	ret


ClearScreen:
	mov ah,06h
	xor cx,cx
	mov dx,0184Fh
	mov al,0
	mov bh,7
	int 10h
	ret
	
Step2:	
	;;RC;;mov ax,2
	;;RC;;int 10h
	
	;;RC;;mov ah,2
	;;RC;;mov bh,0
	;;RC;;mov dh,0
	;;RC;;mov dl,0
	;;RC;;int 10h
	
	;;RC;;mov bp,setup_welcome
	;;RC;;call TxtPrint
	
	;;RC;;mov ah,2
	;;RC;;mov bh,0
	;;RC;;mov dh,2
	;;RC;;mov dl,0
	;;RC;;int 10h
	
	;;RC;;mov bp,setup_welcome_2
	;;RC;;call TxtPrint
	
	;;RC;;mov ah,2
	;;RC;;mov bh,0
	;;RC;;mov dh,3
	;;RC;;mov dl,0
	;;RC;;int 10h
	
	;;RC;;mov bp,ctrlaltdel_msg
	;;RC;;call TxtPrint
	
	;;RC;;mov ah,2
	;;RC;;mov bh,0
	;;RC;;mov dh,5
	;;RC;;mov dl,0
	;;RC;;int 10h
	
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
	
	;;RC;;mov ax,2
    ;;RC;;int 10h
	
	;;RC;;mov ah,02h
	;;RC;;mov bh,0
	;;RC;;mov dh,0
	;;RC;;mov dl,0
	;;RC;;int 10h
	
	;;RC;;mov bp,setup_complete
	;;RC;;call TxtPrint
	
	;;RC;;mov ah,10h
    ;;RC;;int 16h
	
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
setup_welcome db 'VH-DOS 1.0: Setup',0
setup_welcome_2 db 'Press Enter to start the installation.',0
setup_progress db 'Setup is copying files...',0
setup_error db 'Disk I/O error, can',27h,'t continue.',0
setup_complete db 'Setup completed. Eject the floppy disk and press any key to reboot computer.',0
;----
