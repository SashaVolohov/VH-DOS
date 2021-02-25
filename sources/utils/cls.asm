	org 007D0h

Task_command	equ 00000:00600h

Task_cls: ; занимает 26 байт.
          ; на запас - ещё 4 байта.
		  ; 30d = 1Eh
		  ; 0000:(07D0+001E)
		  ; будет располагаться
		  ; следующая функция.
	mov ah,6
	mov bx,7
	mov al,0
	mov cx,0
	mov dx,0184Fh
	int 10h

	mov ah,2
	mov bh,0
	mov dh,0
	mov dl,0
	int 10h

	jmp Task_command