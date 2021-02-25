	org 00600h

message:
	mov bp,text_disk
	call TxtPrint	
	;add dl,4
	;call SetCursorPos

Command:
	;mov ah,10h;?
	mov ah,0
	int 16h
	cmp ah,0Eh
	jz Delete_symbol
	cmp al,0Dh
	jz Parse_Command
	cmp al,32d
	jae CheckForPrintableRange
	jmp Command
CheckForPrintableRange:	
	cmp al,126d
	jle AddToBuffer
	jmp Command
AddToBuffer:
	mov ah,3
	mov bh,0
	int 10h
	cmp dl,79d
	jz Command
	mov [string+si],al
	inc si
	mov ah,9
	mov bx,7
	mov cx,1
	int 10h
	add dl,1
	mov ah,2
	int 10h
 	jmp Command
	; jmp BSOD <
	;  > Сюда мы никогда не попадём, если только где-нибудь не указан шестнадцетиричный адрес на эту инструкцию,
	;  > потому   что   "слишком   далеко    находится    начало     процедуры BSOD,    дабы   прыгнуть    туда"

Parse_Command:
	mov ah,3
	mov bh,0
	int 10h
	cmp dl,79d
	jz Command
	cmp dh,24d
	jz ScrollDown
AfterScroll:
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
	mov si,cmd_ver
	mov cx,3
	rep cmpsb
	je command_ver
	mov di,string
	push si
	mov si,cmd_cls
	mov cx,3
	rep cmpsb
	je command_cls
	mov cx,50d
ClearBuf:
	mov bx,cx
	mov [string+bx],0
	loop ClearBuf
	jmp bad_command
ScrollDown:
	mov ah,7
	mov al,3
	mov bh,7
	mov cx,dx
	mov dx,2000d
	jmp AfterScroll
Delete_symbol:
	cmp dl,4
	jz Command
	sub dl,1
	call SetCursorPos
	mov al,20h
	mov [string+si],al
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
cmd_ver db 'ver',0
cmd_cls db 'cls',0
cmd_update db 'update',0
verinfo db 'VH-DOS 1.0. (c) VH-DOS development team. Licensed under GNU GPLv3 license.',0

TxtPrint:
	mov si,bp
	xor bx,bx
TxtPrint@01:
	cmp bx,0FFFFh
	jz TxtPrint@02
	mov al,byte [si+bx]
	cmp al,0
	jz TxtPrint@02
	push bx ax
	pop ax
	mov ah,09h
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

string db 50 dup(?)

bad_command:
	mov bp,bad
	call TxtPrint
	;add dh,2
	;mov dl,0
	;call SetCursorPos
	mov bp,text_disk
	call TxtPrint
	;add dl,4
	;call SetCursorPos
	jmp ClearBuffer
	; ret ; Смысла в RET здесь нет

PageUp:
	mov ax,2
	int 10h
	mov dl,0
	mov dh,0
	call SetCursorPos
	mov bp,text_disk
	call TxtPrint
	mov dl,4
	mov dh,0
	call SetCursorPos
	jmp Command
	ret

command_ver:
	mov bp,verinfo
	call TxtPrint
	;add dh,2
	;mov dl,0
	;call SetCursorPos
	mov bp,text_disk
	call TxtPrint
	;add dl,4
	;call SetCursorPos
	jmp ClearBuffer
	ret

ClearBuffer:
	mov cx,50d
ClearBuffer@Loop1:
	mov bx,cx
	mov [string+bx],0
	loop ClearBuffer@Loop1
	jmp Command

BSOD:
	mov bp,verinfo
	call TxtPrint
	ret

command_cls:
	jmp 0000:0800h