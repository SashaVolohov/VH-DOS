; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.

; Данный файл служит для установки ОС.
; Этот файл находится в загрузочном секторе дискеты. Загружается по адресу 0000:7C00

	org 07C00h

start:
	mov ah,02h
	mov al,1
	xor ch,ch
	mov cl,2
	xor dx,dx
	mov bx,07E00h
	int 13h
	mov ax,word ptr [07E00h]
	cmp ax,OurSignature
	push word 0 ; Переход на 0000:7E000,
	push 07E00h ; где и начинается полезный
	retf        ; загрузчик

file 'oursignature.dat':0,2
times (512 - 2 - (07C00h - $)) db 0
db 055h,0AAh
