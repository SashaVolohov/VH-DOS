RASR:
; "Сбросить все сегментные регистры"

; Помещает 6 байт 0x00 в стек,
; перекладывает в сегментные регистры

	push word 0 ; byte 0x00, byte 0x00}-1st group
	push word 0 ; byte 0x00, byte 0x00}-2nd group
	push word 0 ; byte 0x00, byte 0x00}-3rd group
	pop cs ; byte 0x00}\
	pop ds ; byte 0x00}/1st group
	pop ss ; byte 0x00}\
	pop es ; byte 0x00}/2nd group
	pop fs ; byte 0x00}\
	pop gs ; byte 0x00}/3rd group
	ret
