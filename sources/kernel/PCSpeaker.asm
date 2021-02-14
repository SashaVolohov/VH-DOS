Beep:
; Воспроизводит звук через PC Speaker
; AX - частота
	mov dx,12h
	cmp ax,dx
	jbe Beep@exit
	;xchg cx,ax
	push cx ax
	pop ax cx
	mov al,0B6h
	out 43h,al
	mov ax,034DDh
	div cx
	out 42h,al
	mov al,ah
	out 42h,al
	in al,61h
	or al,11b
	out 61h,al
Beep@exit:
	ret

NoBeep:
	in al,61h
	and al,not 11b
	out 61h,al
	ret
