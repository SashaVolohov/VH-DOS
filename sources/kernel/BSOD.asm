	org 07C00h

command_reboot equ 00000h:

BSOD:
	mov ax,2
	int 10h

	mov ax,00900h
	mov bx,0001Fh
	mov cx,2000d
	int 10h

	mov ah,2
	mov bh,0
	mov dx,00202h
	int 10h

	mov bp,BSOD_part01
	call MultiTxtPrint

	mov ah,0
	int 16h
	
	jmp command_reboot