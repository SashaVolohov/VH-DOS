; ������������ ������� VH-DOS
; Copyright(C) ����� Ը�����, 2019.

; ������ ���� �������� ������ ���� VH-DOS!
; ���� ���� �������� ������� "������� �� ����� ������� ����� �� EDX".
; � EDX ������ ���� ������� �����!

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