; ������������ ������� VH-DOS
; Copyright(C) ���� �������, 2020.

; ������ ���� ������ ��� ������� ��, � ��������� �������� ��������� � ������.

org 500h

message:
	mov ax, 0002h
        int 10h
        
	mov dx,0h
        mov bp, start_dos
        mov cx, 18
        mov bl,07h					
        xor bh,bh
        mov ax,1301h
        int 10h
        mov si,0
		
		mov ah,02h
		mov bh,0
		mov dh, 2
		mov dl, 0
		int 10h
		
		mov ax,0000h
		mov es,ax
		mov bx,800h
		mov ch,0
		mov cl,04h
		mov dh,0
		mov	dl,80h
		mov al,01h
		mov ah,02h
		int 13h ; ������ boot �����
		
		mov ax,0000h
		mov es,ax
		mov bx,600h
		mov ch,0
		mov cl,03h
		mov dh,0
		mov	dl,80h
		mov al,01h
		mov ah,02h
		int 13h
		
		mov ax, 0002h
        int 10h
		
		mov ah,02h
		mov bh,0
		mov dh,0
		mov dl,0
		int 10h
		
		jmp 0000:0600h
		
		
jmp $

start_dos db 'Starting VH-DOS...',0
error_start db 'Cannot find COMMAND.SYS'

print_mes:
mov bl,07h					
xor bh,bh
mov ax,1301h
int 10h
mov si,0
ret