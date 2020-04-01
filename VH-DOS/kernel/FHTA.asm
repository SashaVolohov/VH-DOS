; Операционная система VH-DOS
; Copyright(C) Антон Фёдоров, 2019.

; Данный файл является частью ядра VH-DOS!
; Этот файл содержит команду "Перевод HEX в ASCII".
; В AX должен быть HEX! После завершение команды в AX будет присутствовать ASCII-код.

FHTA:
  push cx
  push ax
  push dx
  mov cl, 16
  div cl
  mov cx, 0x0
  mov dx, 0x0
  mov dl, al
  mov cl, ah
  add cx, 48
  add dx, 48
  cmp cx, 57
  jg FHTAone
  jmp FHTAthree
  FHTAone: add cx, 7
  FHTAthree:
  cmp dx, 57
  jg FHTAtwo
  jmp FHTAE
  FHTAtwo: add dx, 7
  FHTAE:
  mov ah, dl
  mov al, cl
  pop dx
  pop ax
  pop cx
  ret
  ret