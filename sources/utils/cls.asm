org 800h

message:

mov ax, 0002h
int 10h

mov ah,02h
mov bh,0
mov dh,0
mov dl,0
int 10h

jmp 0000:0600h

print_mes:
mov bl,07h					
xor bh,bh
mov ax,1301h
int 10h
mov si,0
ret