; Операционная система VH-DOS
; © Антон Фёдоров, 2019-2021.

; Данный файл является частью ядра VH-DOS.
; Этот файл содержит процедуру "Перевод HEX в ASCII".

FHTA:
; Перевод HEX в ASCII

; AX должен содержать шестнадцетиричный код,
; над которым будет производится работа!

	push cx
	push ax
	push dx
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
	pop dx
	pop ax
	pop cx
	ret