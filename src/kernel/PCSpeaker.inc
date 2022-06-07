Beep:
; Tells PC Speaker to play a note
; Input AX - the note frequency

	mov dx, 0x12
	cmp ax, dx
	jbe Beep@exit
	; ~ xchg cx,ax
	xor ax, cx
	xor cx, ax
	xor ax, cx
	mov al, 0xB6
	out 0x43, al
	mov ax, 0x34DD
	div cx
	out 0x42, al
	mov al, ah
	out 0x42, al
	in al, 0x61
	or al, 11b
	out 0x61, al
Beep@exit:
	ret

NoBeep:
	in al, 0x61
	and al, not 11b
	out 0x61, al
	ret
