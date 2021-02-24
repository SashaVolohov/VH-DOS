; include "../macros.asm"

MACRO ClearStack {
	push qword 0 ; qword - 8 bytes!
	push qword 0 ; dword - 4 bytes!
	pop cs ; cs,ds,es,ss - all of them are 4 bytes long!
	pop ds ; cs+ds+es+ss = 4*4 = 16 bytes
	pop es
	pop ss
}
