	org 0

include "..\standards.inc"

Task_cls: ; �������� 26 ����.
          ; �� ����� - ��� 4 �����.
		  ; 30d = 1Eh
		  ; 0000:(07D0+001E)
		  ; ����� �������������
		  ; ��������� �������.
	mov ah,6
	mov bx,7
	mov al,0
	mov cx,0
	mov dx,0184Fh
	int 10h

	mov ah,2
	mov bh,0
	mov dh,0
	mov dl,0
	int 10h

	jmp addr_Command