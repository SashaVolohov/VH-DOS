; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.

; Данный файл служит для запуска установщика ОС.
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

	mov ax,0002h
	int 10h
	
	mov bp,fail_ldr
	mov cx,18
	
	call PrintMes
	
	mov ah,02h
	mov bh,0
	mov dh,1
	mov dl,0
	int 10h
	
	mov bp,fail_ldr_two
	mov cx,29
	
	call PrintMes
	
	xor ax,ax
	; mov es,ax ; заменено
	xor es,es
	
	mov bx,00500h
	mov ch,0
	mov cl,2
	mov dh,0
	mov dl,0
	mov al,1
	mov ah,2
	int 13h
	jmp 0000:0500h
	
	call ClearMes
	
	mov ah,2
	mov bh,0
	mov dh,2
	mov dl,0
	int 10h
	
PrintMes:
; Вывести сообщение

; BP - указатель на строку в памяти;
; CX - длина этой строки.

	mov bl,07h
	mov ax,1301h
	int 10h
	ret

ClearMes:
; Очистить сообщение

	mov bp,0
	mov cx,0
	ret
;----
fail_ldr db 'DOSLDR is missing.',0
fail_ldr_two db 'Press Ctrl+Alt+Del to restart',0
times(512-2-($-07C00h)) db 0
db 055h,0AAh
