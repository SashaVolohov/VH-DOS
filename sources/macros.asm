; include "../macros.asm"

MACRO zero_segment {
	push qword 0
	push qword 0
	pop cs
	pop ds
	pop es
	pop ss
}
