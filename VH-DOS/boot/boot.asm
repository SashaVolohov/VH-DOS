; Операционная система VH-DOS
; Copyright(C) Саша Волохов, 2019.

; Данный файл служит для запуска ОС.
; Этот файл находится в MBR дискеты/жёсткого диска. Загружается по адресу 0x7c00

org 7c00h

start:

cli
xor ax,ax
mov ds,ax
mov es,ax
mov ss,ax
mov sp,07C00h
sti
   
mov ax, 0002h
int 10h

mov bp,fail_ldr
mov cx, 18

call PrintMes

mov ah,02h
mov bh,0
mov dh,1
mov dl,0
int 10h

mov bp,fail_ldr_two
mov cx, 29

call PrintMes

mov ax,0000h
mov es,ax
mov bx,500h
mov ch,0
mov cl,02h
mov dh,0
mov	dl,0h
mov al,01h
mov ah,02h
int 13h
jmp 0000:0500h

call ClearMes

mov ah,02h
mov bh,0
mov dh,2
mov dl,0
int 10h

PrintMes:                   ;в регистре  bp - строка, в регистре cx - длина этой строки
        mov bl,07h
        mov ax,1301h
        int 10h
        ret
        ;----------------------------------
		
ClearMes:
	mov bp,null
	mov cx,0
ret
		
fail_ldr db 'DOSLDR is missing.',0
fail_ldr_two db 'Press Ctrl+Alt+Del to restart',0
null db '',0

times(512-2-($-07C00h)) db 0
db 055h,0AAh