TxtPrint:
; Input SI: Address to string for printing
	xor bx, bx
@@:
	mov al, byte [si + bx]
	cmp al, 0
	jz @f
	mov ah, $0E
	mov cx, bx
	mov bx, 7
	int $10
	mov bx, cx
	inc bx
	jmp @b
@@:
	ret

