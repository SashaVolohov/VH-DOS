; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.

; Данный файл служит для установки ОС.
; Этот файл находится в загрузочном секторе дискеты. Загружается по адресу 0000:7C00

	org 7C00h

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
	
	mov bp,fail_ldr
	call TxtPrint
	
	mov ah,02h
	mov bh,0
	mov dh,1
	mov dl,0
	int 10h
	
	mov bp,ctrlaltdel_msg
	call TxtPrint
	
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
	
	call ClearScreen
	
	mov ah,2
	mov bh,0
	mov dh,2
	mov dl,0
	int 10h
	
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

ClearScreen:
	mov ah,06h
	xor cx,cx
	mov dx,0184Fh
	mov al,0
	mov bh,7
	int 10h
	ret
	
Step2:	
	mov ax,2
	int 10h
	
	mov ah,2
	mov bh,0
	mov dh,0
	mov dl,0
	int 10h
	
	mov bp,setup_welcome
	call TxtPrint
	
	mov ah,2
	mov bh,0
	mov dh,2
	mov dl,0
	int 10h
	
	mov bp,setup_welcome_2
	call TxtPrint
	
	mov ah,2
	mov bh,0
	mov dh,3
	mov dl,0
	int 10h
	
	mov bp,ctrlaltdel_msg
	call TxtPrint
	
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
	
	mov ah,02h
	mov bh,0
	mov dh,0
	mov dl,0
	int 10h
	
	mov bp,setup_complete
	call TxtPrint
	
	mov ah,10h
    int 16h
	
	mov ax, 40h
	push ax
	pop ds
	mov word ptr ds:72h, 1234h
	mov ax, 0FFFFh
	push ax
	mov ax, 0
	push ax
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
times ((512*3)-2-($-07C00h)) db 0
db 055h,0AAh