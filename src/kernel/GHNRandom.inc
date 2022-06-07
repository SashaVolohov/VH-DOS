GHNRandom:
; Output:
; AL - a random integer

	mov ax, 0x079D ; prime number
	xor cx, cx ; will be on the output
	;>1>;push word 0 ; for ax
	;>1>;push word 0 ; for dx
	push cx
	push cx
GHNRandom@01:
	pop bx
	cmp bx, 7
	jz GHNRandom@02
	inc bx
	push bx
	pop dx ; loop limit
	cmp dx, 8
	jz GHNRandom@02
	inc dx
	push dx
	push cx
	mov ah, 0x02
	int 0x1A
	jc GHNRandom@01 ; in case if it was resolved at the time of update
	xor ch, dl
	xor cl, dh
	cmp cl, dh
	jae GHNRandom@01_01
	jg GHNRandom@01_02
	jz GHNRandom@01_03
GHNRandom@01_03:
	not cl
GHNRandom@01_01:
	mov ch, dh
GHNRandom@01_02:
	shr dh, 3
	xor cx, 0x079D ; prime number
	; (!) jc CF_set
	; (!) jb CF_clear
	mov bx, 0
	xor bx, ax
	; Auxiliary Carry Flag from XOR is that random bit

	shl cx, 1
	lahf ; qweXtyui -> <AH>
	shr ah, 4 ; qweXtyui -> 0000qweX
	shl ah, 7 ; 0000qweX -> X0000000
	shr ah, 7 ; X0000000 -> 0000000X
	pop cx
	add cl,ah
	jmp GHNRandom@01
GHNRandom@02:
	ret
