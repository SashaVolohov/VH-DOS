; "Video adapters information"
; Original concept from /sources/kernel/What_AD.inc
; (c) Larry Holst, 2021.

VAInfo:
; Output:
; AL:
;   bits 0 0 0 0 x x x x
;        8 7 6 5 4 3 2 1

; 	4th bit is set - VGA present
;	3rd bit is set - EGA present
;	2nd bit is set - CGA present
;	1st bit is set - MDA present

; So, if AL > 10, then there's encounted more than 1 video adapter (stranger things)

	push dx
	push bx
	push cx
	xor ax,ax
	push ax
VAInfo@VGA:	
	mov ah,0x1A
	int 0x10
	cmp al,0x1A
	jz VAInfo@VGA_Final
	jmp VAInfo@EGA
VAInfo@VGA_Final:
	pop ax
	or al,1000b
	push ax
VAInfo@EGA:
	mov ah,0x12
	mov bl,0x10
	jz VAInfo@CGA
VAInfo@EGA_Final:
	pop ax
	or al,0100b
	push ax
VAInfo@CGA:
	mov dx,0x03D4
	mov al,0x0F
	out dx,al
	inc dx
	in al,dx
	mov ah,al
	mov al,0x66
	out dx,al
	mov cx,0x0100
@@:
	loop @b
	in al,dx
	xor ah,al
	xor al,ah
	xor ah,al
	out dx,al
	cmp ah,0x66
	jz VAInfo@CGA_Final
VAInfo@MDA:
	int 0x11
	; "If (w AND 30H) is 30H", exactly as https://dos4gw.org/Monochrome_Display_Adapter_MDA says.
	; The method wasn't tested yet.
	and ax,30h
	cmp ax,30h
	jz VAInfo@MDA_Final
	ret
VAInfo@CGA_Final:
	pop ax
	or al,0010b
	push ax
	jmp VAInfo@MDA
VAInfo@MDA_Final:
	pop ax
	or al,0001b
	push ax
	ret
