; ������������ ������� VH-DOS
; Copyright(C) ����� Ը�����, 2019.

; ������ ���� �������� ������ ���� VH-DOS!
; ���� ���� �������� ������� "������� �� ����� ������� ����� �� EDX".
; � EDX ������ ���� ������� �����!

PDWFEDX:
	push ax
	mov cx,4
PDWFEDX_001:
	mov ah,0Eh
	mov al,dl
	int 10h
	shr edx,8
	loop PDWFEDX_001
	pop ax
	ret