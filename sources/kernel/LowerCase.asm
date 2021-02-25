LowerCase:
; "Поместить все буквы в нижний регистр"
; BP - указатель на смещение в памяти, начало строки.
; В конце строки должен стоять 0x00.

; если ASCII-код символа < 65, это не буква.
; если ASCII-код символа < 91, это буква в верхнем регистре.
; если ASCII-код символа < 97, это не буква.
; если ASCII-код символа < 123, это буква в нижнем регистре.
	mov si,bp
	xor bx,bx
LowerCase@01:
	cmp bx,0FFFFh
	jz LowerCase@exit
	push bp
	mov bp,bx
	mov al,[si+bp]
	pop bp
	cmp al,0
	jz LowerCase@exit
	inc bx
	cmp al,65
	jl LowerCase@02 ; doesn't matters
	cmp al,91
	jl LowerCase@03 ; our letter - high register
	jge LowerCase@02 ; doesn't matters
	jmp LowerCase@01
LowerCase@02: ; just add
	push bp
	mov bp,bx
	dec bp
	add bp,si
	mov [bp],al
	pop bp
	jmp LowerCase@01
LowerCase@03: ; process, add
	add al,32
	push bp
	mov bp,bx
	dec bp
	add bp,si
	mov [bp],al
	pop bp
	jmp LowerCase@01
LowerCase@exit:
	push bp
	mov bp,bx
	dec bp
	add bp,si
	mov byte [bp],0
	pop bp
	ret
