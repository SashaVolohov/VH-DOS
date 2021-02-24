        org 800h
        
message:
        mov ah,6
        mov bh,7
        mov al,0
        mov cx,0
        mov dx,2000d
        int 10h
        
        mov ah,2
        mov bh,0
        mov dh,0
        mov dl,0
        int 10h
        
        jmp 0000h:0600h
