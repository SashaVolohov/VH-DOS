	org 07C00h

Restart:
; Тёплая перезагрузка компьютера
	mov ax,40h
	push ax
	pop ds
	mov word ptr ds:72h,1234h
	mov ax,0FFFFh
	push ax
	mov ax,0
	push ax
	retf

ACPI_Shutdown:
; Выключение компьютера через ACPI интерфейс
	mov ax,5300h
	xor bx,bx
	int 15h
	jc ACPI_Shutdown@ThrowError
	mov ax,5308h
	mov bx,00001h
	mov cx,1
	int 15h
	jc ACPI_Shutdown@ThrowError
	mov ax,5308h
	mov bx,0FFFFh
	mov cx,1
	int 15h
	jc ACPI_Shutdown@ThrowError
	mov ax,5301h
	xor bx,bx
	int 15h
	jc ACPI_Shutdown@ThrowError
	mov ax,530Eh
	mov bx,0
	pop cx
	int 15h
	jc ACPI_Shutdown@ThrowError
	mov ax,530Dh
	mov bx,1
	mov cx,1
	int 15h
	jc ACPI_Shutdown@ThrowError
	mov ax,530Fh
	mov bx,1
	mov cx,1
	int 15h
	jc ACPI_Shutdown@ThrowError
	mov ax,5307h
	mov bx,1
	mov cx,3
	int 15h
	jc ACPI_Shutdown@ThrowError
	ret
ACPI_Shutdown@ThrowError:
	jmp BSOD