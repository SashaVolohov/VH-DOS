TxtPrint:
; Input SI: Address to string for printing
@@:
	mov al, byte [si + bx]
	cmp al, 0
	jz @f
	mov ah, $0E
	mov bx, 7
	int $10
	inc si
	jmp @b
@@:
	ret

