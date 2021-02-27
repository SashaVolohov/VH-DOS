	org 07C00h

VersionInfo:
	mov bp,verinfo_text
	call TxtPrint
	add dh,2			; debug
	mov dl,0			; debug
	call SetCursorPos	; debug
	mov bp,cmd_prompt
	call TxtPrint
	add dl,4			; debug
	call SetCursorPos	; debug
	jmp ClearBuffer
	ret
verinfo_text db 'VH-DOS '
	file "..\version.txt"
	db '. (c) VH-DOS development team. Licensed under GNU GPLv3 license.',0

ClearScreen:
	mov ah,6
	xor cx,cx
	mov dx,0184Fh
	mov al,0
	mov bh,7
	int 10h
	ret

ClearScreen_cl:
	mov ah,6
	mov bx,7
	mov al,0
	mov cx,0
	mov dx,0184Fh
	int 10h

	mov ah,2
	mov bh,0
	mov dx,0
	int 10h
	ret