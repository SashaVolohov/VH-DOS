; ������������ ������� VH-DOS
; � ���� �������, ����� Ը�����. 2019-2021.

; ������ ���� ������ ��� ���������� ���� ��.
; �� ���������, � ����� ������� ������ ���� �������� BIN ����

; ������ ��� ���������� ������ �����*:
; ` file "���� � �����" ; *������� �������� ����� � ��� ��������*
; ` align 512
; *���� ����� �������� 1 ������, ����������� ������ ���� >= 512 ����!

macro align value { db value - 1 - ($ + value - 1) mod (value) dup 0 }
HEADS = 1
SPT = 7
begin:
	; file "boot\boot.bin",512 ; ������ ��������� (MBR)
	; file "boot\DOSLDR.bin" ; ������ ��������� (DOSLDR)
	; align 512
	; file "kernel\FHTA.bin" ; �������:  ��������� HEX � ASCII
	; align 512
	; file "kernel\PDWFEDX.bin" ; �������: �������� ������� ����� �� EDX
	; align 512
	; file "kernel\BytR.bin" ; �������: ����������� ����� � A� ����� ������
	; align 512
	; file "kernel\RASR.bin" ; �������:  ����� ���� ��������� ���������
	; align 512
	; align HEADS*SPT*512
	
	file "setup\boot.bin",512 ; ������ ��������� (MBR) ����������
	;file "setup\DOSLDR.bin" ; ������ ��������� (DOSLDR) ����������
	;align 512
	file "boot\boot.bin",512 ; ���������
	file "boot\DOSLDR.bin" ; DOSLDR
	align 512
	;file "setup\install.bin" ; ���� ���� ����������� ����� ���������
	align 512
	file "utils\command.bin" ; COMMAND.SYS
	align 512
	file "utils\cls.bin" ; ������� "help"
	align 512
	align HEADS*SPT*512
