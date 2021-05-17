	org 0x7D00

include "..\standards.inc"

Task_cls: ; çàíèìàåò 26 áàéò.
          ; íà çàïàñ - åù¸ 4 áàéòà.
		  ; 30d = 1Eh
		  ; 0000:(07D0+001E)
		  ; áóäåò ðàñïîëàãàòüñÿ
		  ; ñëåäóþùàÿ ôóíêöèÿ.
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

	jmp addr_Command
