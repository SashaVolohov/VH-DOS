org 700h

finish:
	mov ax, 0002h
    int 10h
	
	mov ah,02h
	mov bh,0
	mov dh, 0
	mov dl, 0
	int 10h
	
	mov bp,setup_complete
	mov cx, 76

	call print_mes
	
	mov ah,10h
    int 16h
	
	mov ax, 40h
	push ax
	pop ds
	mov word ptr ds:72h, 1234h
	mov ax, 0FFFFh
	push ax
	mov ax, 0
	push ax
	retf
jmp $

setup_complete db 'Setup completed. Eject the floppy disk and press any key to reboot computer.'

print_mes:
mov bl,07h					
xor bh,bh
mov ax,1301h
int 10h
mov si,0
ret