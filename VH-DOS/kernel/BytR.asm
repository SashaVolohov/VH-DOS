; ������������ ������� VH-DOS
; Copyright(C) ����� Ը�����, 2019.

; ������ ���� �������� ������ ���� VH-DOS!
; ���� ���� �������� ������� "���������� �������".
; � AX ������ ���� HEX!

BytR:
  push bx
  push cx
  push dx
  xchg al, ah
  mov bh, ah
  mov bl, al
  mov ah, al
  shl ah, 4
  shr al, 4
  or ah, al
  mov dh, ah
  mov ah, bh
  mov al, ah
  shl ah, 4
  shr al, 4
  or ah, al
  mov dl, ah
  mov ax, dx
  xchg ah, al
  pop dx
  pop cx
  pop bx
  ret