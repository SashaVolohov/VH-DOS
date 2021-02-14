BytR:
; Побайтовый ревёрсер

; AX должен содержать шестнадцетиричный код,
; над которым будет производится работа!

	push bx cx dx
	xchg al,ah
	mov bh,ah
	mov bl,al
	mov ah,al
	shl ah,4
	shr al,4
	or ah,al
	mov dh,ah
	mov ah,bh
	mov al,ah
	shl ah,4
	shr al,4
	or ah,al
	mov dl,ah
	mov ax,dx
	xchg ah,al
	pop dx cx bx
	ret
