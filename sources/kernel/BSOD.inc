include "..\standards.inc"

BSOD:
	mov ax,2
	int 10h

	mov ax,0x0900
	mov bx,0x001F
	mov cx,2000
	int 10h

	mov ah,2
	mov bh,0
	mov dx,0x0202
	int 10h

	mov bp,BSOD_part01
	call addr_MultiTxtPrint

	mov ah,10h
	int 16h
	
	jmp addr_command_reboot

BSOD_part01 db 'VH-DOS: Fatal error',0Dh,0Dh,'Error has been occured during system operation.',0
