VersionInfo:
	mov bp, verinfo_text
	call Global_TxtPrint
	; ~ add dh, 2		; debug
	; ~ mov dl, 0		; debug
	call SetCursorPos	; debug
	mov bp, cmd_prompt
	call Global_TxtPrint
	; ~ add dl, 4		; debug
	; ~ call SetCursorPos	; debug
	jmp ClearBuffer
	ret

verinfo_text:
	file "..\version.txt"
	db 0

cmd_prompt db 'C:\>', 0
Length_cmd_prompt db $ - cmd
cmd_limit db 80 - Length_cmd_prompt ; temporary solution

ClearScreen_ca:
	ClearScreen
	ret

ClearScreen_cl:
	ClearScreen

	mov ah,2
	mov bh,0
	mov dx,0
	int 10h
	ret

SetCursorPos:
	cmp dh,26 ; ???
	jz @f ; ???
	cmp dh,27 ; ???
	jz @f ; ???
	cmp dh,28 ; ???
	jz @f ; ???
	cmp dh,29 ; ???
	jz @f ; ???

	mov ah, 2
	xor bh, bh
	int 10h
	ret
@@:
	call ClearScreen_ca

stringd equ 0x2000
stringd_len equ 0x33
CommandQ equ 0x0600 ; ?

ClearBuffer:
	mov cx, 50d ; limit

ClearBuffer@Loop1:
	mov bx, cx
	add bx, stringd
	mov byte [ds:bx], 0
	loop ClearBuffer@Loop1
	jmp CommandQ
	
Global_TxtPrint:
	mov si, bp
	xor bx, bx

Global_TxtPrint@01:
	cmp bx, 0xFFFF
	jz Global_TxtPrint@02
	mov al, byte [si + bx]
	cmp al, 0
	jz Global_TxtPrint@02
	push bx ax
	pop ax
	mov ah, 9
	mov bx, 7
	mov cx, 1
	int 0x10
	mov ah, 3
	xor bx, bx
	int 0x10
	mov ah, 2
	xor bx, bx
	inc dl
	int 0x10
	pop bx
	inc bx
	jmp Global_TxtPrint@01
Global_TxtPrint_Data01 db 0
Global_TxtPrint@02:
	xor bx, bx
	xor bp, bp
	xor si, si
	xor ax, ax
	ret
