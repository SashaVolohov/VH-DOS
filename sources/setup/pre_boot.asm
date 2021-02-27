; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.

; Данный файл служит для установки ОС.
; Этот файл находится в загрузочном секторе дискеты. Загружается по адресу 0000:7C00

	org 07C00h

FAT12_LABEL equ 'SASHA',0,0,0

start:
; Часть FAT12
	db 0EBh,058h,090h,FAT12_LABEL,000h,002h,001h,001h,000h,002h
	db 0E0h,000h,040h,00Bh,0F0h,009h,000h,012h,000h,002h,000h,000h,000h,000h,000h,000h,000h
	db 000h,000h,000h,000h,029h,0E2h,046h,04Eh,029h,020h,020h,020h,020h,020h,020h,020h,020h
	db 020h,020h,020h,046h,041h,054h,031h,032h,020h,020h,020h,000h,000h,000h,000h,000h,000h
	db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	db 000h,000h,000h,000h,000h
;-----------------------------------------
	cli
	xor ax,ax
	mov ds,ax
	mov es,ax
	mov ss,ax
	mov sp,07C00h
	sti

	mov ah,2
	mov al,1
	mov ch,0
	mov cl,3
	mov dh,0
	mov dl,0
	mov bx,07E00h
	int 13h

	push word 0 ; Переход на 0000:7E000,
	push 07E00h ; где и начинается полезный
	retf        ; загрузчик

times (512 - 2 - (07C00h - $)) db 0
db 055h,0AAh