UpperCase:
; "Поместить все буквы в верхний регистр"
; BP - указатель на смещение в памяти, начало строки.
; В конце строки должен стоять 0x00.

; если ASCII-код символа < 65, это не буква.
; если ASCII-код символа < 91, это буква в верхнем регистре.
; если ASCII-код символа < 97, это не буква.
; если ASCII-код символа < 123, это буква в нижнем регистре.
	mov si,bp
	xor bx,bx
UpperCase@01:
	cmp bx,0FFFFh
	jz UpperCase@exit
	push bp
	mov bp,bx
	mov al,[si+bp]
	pop bp
	cmp al,0
	jz UpperCase@exit
	inc bx
	cmp al,97
	jl UpperCase@02 ; doesn't matters
	cmp al,122
	jl UpperCase@03 ; our letter - low register
	jge UpperCase@02 ; doesn't matters
	jmp UpperCase@01
UpperCase@02: ; just add
	push bp
	mov bp,bx
	dec bp
	mov [si+bp],al
	pop bp
	jmp UpperCase@01
UpperCase@03: ; process, add
	sub al,32
	push bp
	mov bp,bx
	dec bp
	mov [si+bp],al
	pop bp
	jmp UpperCase@01
UpperCase@exit:
	push bp
	mov bp,bx
	dec bp
	mov [si+bp],0
	pop bp
	ret
