; Операционная система VH-DOS
; Copyright(C) Саша Волохов, 2019.

; Данный файл служит для запуска ОС, и представляет собой оболочку ОС.

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
		
		add dh,2
        call SetCursorPos
		
		mov bp, text_disk
		mov cx, 4
		
		call print_mes
		
		add dl,4
		call SetCursorPos
		
		;push word 0x0
		;pop ds
		;mov bx, 0x0800
		;mov eax, "test"
		;mov [ds:bx], eax
		
Command: 
	mov ah,10h
        int 16h
        cmp ah, 0Eh
        jz Delete_symbol
        cmp al, 0Dh
        jz Input_Command
        mov [string+si],al
        inc si
        mov ah,09h
        mov bx,0007h
        mov cx,1
        int 10h
		add dl,1
        mov ah,02h
		int 10h

 	jmp Command
	jmp BSOD

Input_Command:
	add dh,1
	mov dl,0
    call SetCursorPos
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov di,string
	push si
	mov si,name_command_ver
	mov cx,3
	rep cmpsb
	je command_ver
	jmp bad_command

Delete_symbol:
	cmp dl,4
	jz Command
	sub dl,1
	call SetCursorPos
	mov al,20h
	mov [string + si],al
	mov ah,09h
	mov bx,0007h
        mov cx,1
        int 10h
        dec si
	jmp Command
	
	SetCursorPos:
		cmp dh,26
		jz PageUp
		cmp dh,27
		jz PageUp
		cmp dh,28
		jz PageUp
		cmp dh,29
		jz PageUp
        mov ah,2h
        xor bh,bh
        int 10h 
        ret

start_dos db 'Starting VH-DOS...',0
text_disk db 'C:\>',0
bad db 'Bad command.',0
name_command_ver db 'ver',0
verinfo db 'VH-DOS 1.0. Copyright(C) VH-DOS Team',0

print_mes:
mov bl,07h					
xor bh,bh
mov ax,1301h
int 10h
mov si,0
ret

string db 50 dup(?)

bad_command:

mov bp,bad
mov cx, 12
call print_mes

add dh,2
mov dl,0
call SetCursorPos

mov bp, text_disk
mov cx, 4

call print_mes

add dl,4
call SetCursorPos

jmp Command
ret

ret

PageUp:

mov ax, 0002h
int 10h
mov dl,0
mov dh,0
call SetCursorPos
mov bp, text_disk
		mov cx, 4
		
		call print_mes
		mov dl,4
mov dh,0
call SetCursorPos
jmp Command
ret

command_ver:

mov bp,verinfo
mov cx, 36
call print_mes

add dh,2
mov dl,0
call SetCursorPos

mov bp, text_disk
mov cx, 4

call print_mes

add dl,4
call SetCursorPos

jmp Command
ret
BSOD:

mov bp,verinfo
mov cx,36
call print_mes
ret