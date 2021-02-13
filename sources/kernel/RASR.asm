; Операционная система VH-DOS
; Copyright(C) Антон Фёдоров, 2019.

; Данный файл является частью ядра VH-DOS!
; Этот файл содержит команду "Сбросить все сегментные регистры".

RASR:
; Сбросить все сегментные регистры

	push word 0
	push word 0
	push word 0
	pop cs
	pop ds
	pop ss
	pop es
	pop fs
	pop gs
	ret