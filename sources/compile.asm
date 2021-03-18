; Операционная система VH-DOS
; © Саша Волохов, Антон Фёдоров. 2019-2021.
; Многочисленные редакции © Артём Котов. 2021.

; Данный файл служит для компиляции всей ОС.
; Он указывает, в каком формате должен быть выходной BIN файл

; Шаблон для добавления своего файла*:
; ` file "путь к файлу" ; *краткое описание файла и Ваш копирайт*
; ` align 512
; *Файл будет занимать 1 сектор, следственно должен быть >= 512 байт!

	org 0

macro zerobytes length {
	db length - 1 - ($ + length - 1) mod (length) dup 0
}

HEADS = 1
SPT = 7
Diskette_Size equ 1474560;bytes

begin:	; ДИСКЕТА С УСТАНОВЩИКОМ
	; СЕКТОР №1
	file "setup\pre_boot.bin",512 ; Для следующего загрузчика

	; СЕКТОР №2
	db 0F0h, 0FFh, 0FFh ; 3,5" HD floppy disk
	zerobytes 512
	
	; СЕКТОРЫ №3, 4, 5
	file "setup\boot.bin",512 ; Первый загрузчик (MBR) установщик > 512 байт
	
	; СЕКТОР №6
	file "boot\boot.bin",512 ; Загрузчик системы [1]

	; СЕКТОР №7
	file "boot\DOSLDR.bin" ; Загрузчик системы [2]
	zerobytes 512
	
	; СЕКТОР №8
	file "utils\command.bin" ; COMMAND.SYS
	zerobytes 512

	; СЕКТОР №9
	file "kernel\BSOD.inc" ; BSOD
	zerobytes 512

	zerobytes HEADS*SPT*512 ; Лично я не могу предположить, что здесь имелось ввиду

db (Diskette_Size - ($ - 0)) dup (0)