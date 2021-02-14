ReserveByte:
; Побайтовый переворотчик задом наперёд

; AX - шестнадцетиричный код.
; Выход: AX
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
	ret
