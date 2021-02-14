; Операционная система VH-DOS
; © Саша Волохов, Антон Фёдоров. 2019-2021.

; Данный файл служит для компиляции всей ОС.
; Он указывает, в каком формате должен быть выходной BIN файл

; Шаблон для добавления своего файла*:
; ` file "путь к файлу" ; *краткое описание файла и Ваш копирайт*
; ` align 512
; *Файл будет занимать 1 сектор, следственно должен быть >= 512 байт!

macro align value { db value - 1 - ($ + value - 1) mod (value) dup 0 }
HEADS = 1
SPT = 7
begin:
	; file "boot\boot.bin",512 ; Первый загрузчик (MBR)
	; file "boot\DOSLDR.bin" ; Второй загрузчик (DOSLDR)
	; align 512
	; file "kernel\FHTA.bin" ; Функция:  Перевести HEX в ASCII
	; align 512
	; file "kernel\PDWFEDX.bin" ; Функция: Печатать двойное слово из EDX
	; align 512
	; file "kernel\BytR.bin" ; Функция: Перевернуть байты в AХ задом наперёд
	; align 512
	; file "kernel\RASR.bin" ; Функция:  Сброс всех сегметных регистров
	; align 512
	; align HEADS*SPT*512
	
	file "setup\boot.bin",512 ; Первый загрузчик (MBR) установщик
	;file "setup\DOSLDR.bin" ; Второй загрузчик (DOSLDR) установщик
	;align 512
	file "boot\boot.bin",512 ; Загрузчик
	file "boot\DOSLDR.bin" ; DOSLDR
	align 512
	;file "setup\install.bin" ; Этот файл запускается после установки
	align 512
	file "utils\command.bin" ; COMMAND.SYS
	align 512
	file "utils\cls.bin" ; команда "help"
	align 512
	align HEADS*SPT*512
