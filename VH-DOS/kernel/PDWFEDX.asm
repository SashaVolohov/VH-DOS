; Операционная система VH-DOS
; Copyright(C) Антон Фёдоров, 2019.

; Данный файл является частью ядра VH-DOS!
; Этот файл содержит команду "Вывести на экран двойное слово из EDX".
; В EDX должно быть двойное слово!

PDWFEDX:
  push ax
  mov cx, 0x4
  PDWFEDXONE:
  mov ah, 0eh
  mov al, dl
  int 10h
  shr edx, 8
  loop PDWFEDXONE
  pop ax
  ret