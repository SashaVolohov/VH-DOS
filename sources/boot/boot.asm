; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.

; Данный файл служит для запуска ОС.
; Этот файл находится в MBR дискеты/жёсткого диска. Загружается по адресу 0000:7C00

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
	jmp 00000:00500h
	call ClearMes
	
	mov ah,2
	mov bh,0
	mov dh,2
	mov dl,0
	int 10h
	
	jmp $
	
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
		
ClearMes:
	mov ah,6
	mov al,0
	mov bh,7
	mov cx,0
	mov dx,2000d
	int 10h
	ret
;----
fail_ldr db 'DOSLDR is missing.',0
fail_ldr_two db 'Press <Ctrl>-<Alt>-<Del> to restart.',0
times(512-2-($-07C00h)) db 0 ; OLD
db 055h,0AAh; FAT12 bootable medium
