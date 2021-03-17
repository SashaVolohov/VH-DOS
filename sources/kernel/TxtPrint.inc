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

MultiTxtPrint_proc:
	mov si,bp
	xor bx,bx
	mov ah,3
	mov bh,0
	int 10h
	mov [MultiTxtPrint_oldpos],dx
MultiTxtPrint@01:
	cmp bx,0FFFFh
	jz MultiTxtPrint@02
	mov al,byte [si+bx]
	cmp al,0
	jz MultiTxtPrint@02
	cmp al,00Dh
	push bx ax
	jz MultiTxtPrint@01_a
	pop ax bx
	jmp MultiTxtPrint@01_b
MultiTxtPrint@01_a:
	mov ah,3
	mov bh,0
	int 10h
	inc dh
	mov cx,[MultiTxtPrint_oldpos]
	mov dl,cl
	mov ah,2
	mov bh,0
	int 10h
	pop ax bx
MultiTxtPrint@01_b:
	push bx ax
	pop ax
	mov ah,9
	mov bh,0
	mov bl,7
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
	jmp MultiTxtPrint@01
MultiTxtPrint_Data01 db ?
MultiTxtPrint_oldpos dw ?
MultiTxtPrint@02:
	xor bx,bx
	xor bp,bp
	xor si,si
	xor ax,ax
	ret