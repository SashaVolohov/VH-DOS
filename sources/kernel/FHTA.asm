FHTA:
; Перевод HEX в ASCII

; AX должен содержать шестнадцетиричный код,
; над которым будет производится работа!

	push cx ax dx
	mov cl,16
	div cl
	mov cx,0
	mov dx,0
	mov dl,al
	mov cl,ah
	add cx,48
	add dx,48
	cmp cx,57
	jg FHTA_001
	jmp FHTA_003
FHTA_001:
	add cx,7
FHTA_003:
	cmp dx,57
	jg FHTA_002
	jmp FHTA_end
FHTA_002:
	add dx,7
FHTA_end:
	mov ah,dl
	mov al,cl
	pop dx ax cx
	ret
