; Операционная система VH-DOS
; © Саша Волохов, Антон Фёдоров. 2019-2021.

; Данный файл служит для компиляции всей ОС.
; Он указывает, в каком формате должен быть выходной BIN файл

; Шаблон для добавления своего файла*:
; ` file "путь к файлу" ; *краткое описание файла и Ваш копирайт*
; ` align 512
; *Файл будет занимать 1 сектор, следственно должен быть >= 512 байт!

	org 7C00h
	
MACRO zerobytes length {
	db length - 1 - ($ + length - 1) mod (length) dup 0
}
HEADS = 1
SPT = 7
Diskette_Size equ 1474560;bytes

begin:	
	file "setup\boot.bin",512 ; Первый загрузчик (MBR) установщик
	;>1>; file "setup\DOSLDR.bin" ; Второй загрузчик (DOSLDR) установщик
	;>1>; zerobytes 512
	file "setup\strings.asm"
	file "boot\boot.bin",512 ; Загрузчик
	file "boot\DOSLDR.bin" ; DOSLDR
	zerobytes 512
	;>2>; file "setup\install.bin" ; Этот файл запускается после установки
	zerobytes 512
	file "utils\command.bin" ; COMMAND.SYS
	zerobytes 512
	file "utils\cls.bin" ; команда "help"
	zerobytes 512
	zerobytes HEADS*SPT*512
	
times (Diskette_Size - ($ - 07C00h)) db 0
