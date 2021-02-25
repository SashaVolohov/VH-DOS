	org 07C00h

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