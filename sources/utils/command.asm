	org 600h

message:
	mov bp,text_disk
	mov cx,4
	call print_mes	
	add dl,4
	call SetCursorPos

Command:
	mov ah,10h
        int 16h
        cmp ah,0Eh
        jz Delete_symbol
        cmp al,0Dh
        jz Input_Command
        mov [string+si],al
        inc si
        mov ah,09h
        mov bx,0007h
        mov cx,1
        int 10h
	add dl,1
        mov ah,02h
	int 10h
 	jmp Command
	; jmp BSOD
	;   Сюда мы никогда не попадём, если только где-нибудь не указан шестнадцетиричный адрес на эту инструкцию,
	;   потому   что   "слишком   далеко    находится    начало     процедуры BSOD,    дабы   прыгнуть    туда"

Input_Command:
	add dh,1
	mov dl,0
	call SetCursorPos
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov di,string
	push si
	mov si,name_command_ver
	mov cx,3
	rep cmpsb
	je command_ver
	mov di,string
	push si
	mov si,name_command_cls
	mov cx,3
	rep cmpsb
	je command_cls
	jmp bad_command
	
Delete_symbol:
	cmp dl,4
	jz Command
	sub dl,1
	call SetCursorPos
	mov al,20h
	mov [string + si],al
	mov ah,09h
	mov bx,0007h
        mov cx,1
        int 10h
        dec si
	jmp Command
	
SetCursorPos:
	cmp dh,26
	jz PageUp
	cmp dh,27
	jz PageUp
	cmp dh,28
	jz PageUp
	cmp dh,29
	jz PageUp
	mov ah,2
	xor bh,bh
	int 10h 
        ret

text_disk db 'C:\>',0
bad db 'Bad command',0
name_command_ver db 'ver',0
name_command_cls db 'cls',0
verinfo db 'VH-DOS 1.0. (c) VH-DOS development team. Licensed under GNU GPLv3 license.',0

print_mes:
	mov bl,07h
	xor bh,bh
	mov ax,1301h
	int 10h
	mov si,0
	ret

string db 50 dup(?)

bad_command:
	mov bp,bad
	mov cx,12
	call print_mes
	add dh,2
	mov dl,0
	call SetCursorPos
	mov bp, text_disk
	mov cx, 4
	call print_mes
	add dl,4
	call SetCursorPos
	jmp Command
	; ret ; Смысла в RET здесь нет

PageUp:
	mov ax,2
	int 10h
	mov dl,0
	mov dh,0
	call SetCursorPos
	mov bp,text_disk
	mov cx,4
	
	call print_mes
	mov dl,4
	mov dh,0
	call SetCursorPos
	jmp Command
	ret

command_ver:
	mov bp,verinfo
	mov cx,36
	call print_mes
	add dh,2
	mov dl,0
	call SetCursorPos
	mov bp,text_disk
	mov cx,4
	call print_mes
	add dl,4
	call SetCursorPos
	jmp Command
	ret

BSOD:
	mov bp,verinfo
	mov cx,36
	call print_mes
	ret

command_cls:
	jmp 0000:0800h
	ret
