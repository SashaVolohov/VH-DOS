; Операционная система VH-DOS
; Copyright(C) Саша Волохов, 2019.
; Copyright(C) Антон Фёдоров, 2019.

; Данный файл служит для компиляции ОС.
; Здесь собраны все файлы ОС.
; Шаблон для добавления своего файла(будет занимать 1 сектор, файл должен быть менее 512 байт, или равен этому количеству!):

;file "путь к файлу" ; *краткое описание файла и Ваш копирайт*
;align 512

macro align value { db value-1 - ($ + value-1) mod (value) dup 0 }
HEADS = 1
; SPT = 6	;6 сектора по 512 байт
SPT = 5
Begin:
	; file "boot\boot.bin",512 ; Первый загрузчик(MBR)
	; file "boot\DOSLDR.bin"; Второй загрузчик - DOSLDR
	; align 512
	; file "kernel\FHTA.bin"; Перевод HEX в ASCII. Copyright (C) Антон Фёдоров, 2019
	; align 512
	; file "kernel\PDWFEDX.bin" ; Печатать двойное слово из EDX. Copyright(C) Антон Фёдоров, 2019
	; align 512
	; file "kernel\BytR.bin" ; Переворачивает байты в AХ. Copyright (C) Антон Фёдоров, 2019
	; align 512
	; file "kernel\RASR.bin" ; Сбрасывает все регистры. Copyright (C) Антон Фёдоров, 2019
	; align 512
	; align HEADS*SPT*512
	
	file "setup\boot.bin",512 ; Первый загрузчик(MBR) установщик
	file "setup\DOSLDR.bin"; Второй загрузчик - DOSLDR установщик
	align 512
	file "boot\boot.bin",512 ; Загрузчик(MBR)
	file "boot\DOSLDR.bin"; DOSLDR
	align 512
	file "setup\finish.bin"; Файл, который запускается, когда установка завершена
	align 512
	align HEADS*SPT*512