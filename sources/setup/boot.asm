; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.
; Многочисленные редакции © Артём Котов. 2021.

; 133 строка (если это 4 строка) - обнаружить, какая программа предполагалась под сектором №7

; Данный файл служит для установки ОС.
; Загружается по адресу 0000:7E00

	org 07C00h

include "..\standards.inc"

macro PrintOut string_offset {
	mov bp,string_offset
	call TxtPrint
}

macro ClearGetch {
	mov ah,10h
    int 16h
}

start:
;--------------;
; СЕКТОР №3
	mov ax,Standard_video_mode
	int 10h

	PrintOut fail_ldr
	SetCursorPosition 0x01 0x00
	PrintOut ctrlaltdel_msg
	
	ClearExtSeg
	TryRead 2, 0, 0x0BD0, 4
	jmp Step2
	
	call ClearScreen
	mov ah,2
	mov bh,0
	mov dh,2
	mov dl,0
	int 10h

	zerobytes 512
;---------------------;
; СЕКТОР №4

Step2:
; "Этот шаг  считывается в память  по адресу 0x0BD0 (ранее
;  там  он  же  и был указан,  но  из-за  правонарушения в
;  работе  системы,  я   исправил  эту возникшую ситуацию."
; - Diicorp95
	mov ax,2
	int 10h
	
	SetCursorPosition 0x00 0x00
	PrintOut setup_welcome
	
	SetCursorPosition 0x02 0x00
	PrintOut setup_welcome_2
	
	SetCursorPosition 0x03 0x00
	PrintOut ctrlaltdel_msg
	
	SetCursorPosition 0x05 0x00
	
	ClearGetch
	
	cmp al,0x0D
   ; jnz start
    jz install
	jmp start
	
install:
	; Запись <boot\boot.bin>, 6 -> 3
	TryRead 6, FDD1, 0x0900, 4 ; пытаться считать СЕКТОР №6 -> 0x0AD0, 4 раза
	FormatSector 3, HDD1 ; подготовка 3-го сектора жёсткого диска
	ClearExtSeg ; чистка ES
	WriteSector 3, HDD1, 0x0900 ; запись из 0x0900 на СЕКТОР №4 жёсткого диска

	; Запись <boot\DOSLDR.bin>, 7 -> 4
	TryRead 7, FDD1, 0x0AD0, 4 ; пытаться считать СЕКТОР №7 -> 0x0AD0, 4 раза
	FormatSector 4, HDD1 ; подготовка 4-го сектора жёсткого диска
	ClearExtSeg ; чистка ES
	WriteSector 4, HDD1, 0x0AD0 ; запись из 0x0AD0 на СЕКТОР №4 жёсткого диска

	; Запись <utils\command.bin>, 8 -> 4
	TryRead 7, FDD1, 0x0AD0, 4 ; пытаться считать СЕКТОР №7 -> 0x0AD0, 4 раза
	FormatSector 4, HDD1 ; подготовка 4-го сектора жёсткого диска
	ClearExtSeg ; чистка ES
	WriteSector 4, HDD1, 0x0AD0 ; запись из 0x0AD0 на СЕКТОР №4 жёсткого диска

	mov ax,Standard_video_mode
    int 10h

	SetCursorPosition 0x00 0x00
	PrintOut setup_complete
	
	ClearGetch

Restart:
; Тёплая перезагрузка компьютера
	mov ax,40h
	push ax
	pop ds
	mov word ptr ds:72h,1234h
	mov ax,0FFFFh
	push ax
	mov ax,0
	push ax
	retf

	zerobytes 512
;---------------------;
; СЕКТОР №5

; У нас ещё нет ОС - модули будут здесь:
include "..\kernel\TxtPrint.inc"
include "..\kernel\Global.inc"

;----
fail_ldr db 'DOSLDR is missing, can',27h,'t continue boot process.',0
ctrlaltdel_msg db 'Press <Ctrl>-<Alt>-<Del> to restart...',0
setup_welcome: db 'VH-DOS '
	file "..\version.txt"
	db ': Setup',0
setup_welcome_2 db 'Press Enter to start the installation.',0
setup_progress db 'Setup is copying files...',0
setup_error db 'Disk I/O error, can',27h,'t continue.',0
setup_complete db 'Setup completed. Eject the floppy disk and press any key to reboot computer.',0