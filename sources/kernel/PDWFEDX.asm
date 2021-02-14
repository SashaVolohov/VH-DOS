; Операционная система VH-DOS
; © Антон Фёдоров, 2019-2021.

; Данный файл является частью ядра VH-DOS!
; Этот файл содержит команду "Вывести на экран двойное слово из EDX".
; В EDX должно быть двойное слово!

PDWFEDX:
	push ax
	mov cx,4
PDWFEDX_001:
	mov ah,0Eh
	mov al,dl
	int 10h
	shr edx,8
	loop PDWFEDX_001
	pop ax
	ret
