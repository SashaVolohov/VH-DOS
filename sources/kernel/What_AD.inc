; Video adapter detection
; Original code (c) Sergijj @ 16/02/2007
; Processed by Larry Holst

WHAT_AD:
; Procedure WHAT_AD

	PUSH DX
	PUSH BX
	PUSH CX
	; checking whether the 10H interrupt has the 1AH function - does the VGA have it
	XOR AL,AL
	MOV AH,0x1A
	INT 0x10
	CMP AL,0x1A
	JNZ WHAT_AD@NO_VGA
	XOR AL,AL
	JMP SHORT WHAT_AD@EXIT
WHAT_AD@NO_VGA:
	; checking whether the 10H interrupt has the function 12H - EGA has it
	MOV AH,0x12
	MOV BL,0x10
	JZ WHAT_AD@NO_EGA
	MOV AL,1
	JMP SHORT WHAT_AD@EXIT
WHAT_AD@NO_EGA:
	; checking for CGA availability
	MOV DX,0x03D4
	CALL SEARCH_6845
	;JC WHAT_AD@NO_CGA
		JC WHAT_AD@NO_MDA
	MOV AL,3
	JMP SHORT WHAT_AD@EXIT
WHAT_AD@NO_MDA:
	MOV AL,4
WHAT_AD@EXIT:
	POP CX
	POP BX
	POP DX
	RET

SEARCH_6845:
; Procedure SEARCH_6845
; Searches for 6845 controller
; Comments from original author:
; * checking the presence of the controller 6845
; * the check is performed by writing to a register and then reading from it
; * if the values match then the controller is present
; * the register number is 0FH, but the port address of the CGA and MDA is different
; Output:
; CF is
;       set > CRT
;     clear > MDA
	MOV AL,0x0F
	OUT DX,AL
	INC DX
	IN AL,DX
	MOV AH,AL
	MOV AL,0x66
	OUT DX,AL
	MOV CX,0x0100
SEARCH_6845@DELAY:
	LOOP SEARCH_6845@DELAY
	IN AL,DX
	XCHG AH,AL
	OUT DX,AL
	CMP AH,0x66
	JZ SEARCH_6845@QUIT
	STC
SEARCH_6845@QUIT:
	RET
