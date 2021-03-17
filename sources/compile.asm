; Операционная система VH-DOS
; © Саша Волохов, Антон Фёдоров. 2019-2021.

; Данный файл служит для компиляции всей ОС.
; Он указывает, в каком формате должен быть выходной BIN файл

; Шаблон для добавления своего файла*:
; ` file "путь к файлу" ; *краткое описание файла и Ваш копирайт*
; ` align 512
; *Файл будет занимать 1 сектор, следственно должен быть >= 512 байт!

	org 07C00h

MACRO zerobytes length {
	db length - 1 - ($ + length - 1) mod (length) dup 0
}
HEADS = 1
SPT = 7
Diskette_Size equ 1474560;bytes

begin:	; ДИСКЕТА С УСТАНОВЩИКОМ
	; СЕКТОР №0
	file "setup\pre_boot.bin",512 ; Для следующего загрузчика

	; СЕКТОР №1
	db 0F0h, 0FFh, 0FFh ; 3,5" HD floppy disk
	zerobytes 512
	
	; СЕКТОР №2
	file "setup\boot.bin",512 ; Первый загрузчик (MBR) установщик > 512 байт
	
	; СЕКТОР №3
	file "setup\boot.bin":512,(512*2)
	
	; СЕКТОР №4
	file "boot\boot.bin",512 ; Загрузчик

	; СЕКТОР №5
	file "boot\DOSLDR.bin" ; DOSLDR
	zerobytes 512
	
	; СЕКТОР №6
	file "utils\command.bin" ; COMMAND.SYS
	zerobytes 512
	
	zerobytes HEADS*SPT*512 ; idk what is this..
times (Diskette_Size - ($ - 07C00h)) db 0
