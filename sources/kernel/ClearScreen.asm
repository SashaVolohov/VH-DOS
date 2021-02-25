	org 07C00h

ClearScreen:
	mov ah,6
	xor cx,cx
	mov dx,0184Fh
	mov al,0
	mov bh,7
	int 10h
	ret