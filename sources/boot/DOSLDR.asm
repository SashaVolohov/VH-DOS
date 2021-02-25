; Операционная система VH-DOS
; © Саша Волохов, Артём Котов, 2020-2021.

; Данный файл служит для запуска ОС, и загружает основные программы в память.

	org 00500h
	
message:
	mov ax,2
	int 10h
        
	mov bp,start_dos
	call TxtPrint
		
	mov ah,2
	mov bh,0
	mov dh,2
	mov dl,0
	int 10h

	xor ax,ax
	push word 0
	pop es

	mov bx,00800h
	mov ch,0
	mov cl,4
	mov dh,0
	mov dl,080h
	mov al,1
	mov ah,2
	int 13h

	xor ax,ax
	mov es,ax
	mov bx,00600h
	mov ch,0
	mov cl,3
	mov dh,0
	mov dl,80h
	mov al,1
	mov ah,2
	int 13h
	
	mov ax,2
	int 10h

	mov ah,2
	mov bh,0
	mov dh,0
	mov dl,0
	int 10h

	jmp 0000:0600h	
	jmp $ ; Возможно, никогда досюда процесс не дойдёт

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

start_dos db 'Starting VH-DOS...',0
error_start db 'Cannot find COMMAND.SYS',0
