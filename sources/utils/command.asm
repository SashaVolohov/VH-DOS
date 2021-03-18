	org 0

include "..\standards.inc"

MACRO ccmps nstr, nlength, jumpto {
	mov si,[Command_Integer_Parse@stringd]
	push si
	mov si,nstr
	mov cx,nlength
	rep cmpsb
	jz jumpto
}

Task_command:
	mov ax,2
	int 10h
	mov ah,2
	mov bh,0
	xor dx,dx
	int 10h

	mov bp,cmd_prompt
	call TxtPrint
	mov dx,4 ;x,y = 4,0
	call SetCursorPos
	jmp Pre_Command

; Functions (/kernel/*.asm)
include "..\kernel\Global.inc" ; VersionInfo
                               ; ClearScreen
							   ; ClearScreen_cl
include "..\kernel\BSOD.inc" ; BSOD
include "..\kernel\GHNRandom.inc" ; GHNRandom
include "..\kernel\StringReg.inc" ; UpperCase(BP = offset, !stops with 0);
                                  ; LowerCase(BP = offset, !stops with 0)
include "..\kernel\PCSpeaker.inc" ; Beep(AX = Hz);
                                  ; NoBeep
include "..\kernel\PwrMgmt.inc" ; Restart;
                                ; ACPI_Shutdown
include "..\kernel\ReverseByte.inc" ; ReverseByte
include "..\kernel\TxtPrint.inc" ; TxtPrint
                                 ; MultiTxtPrint

stringd equ 0x2000
stringd_len equ 0x33

Pre_Command:
	mov cx,50d
ClearBuf:
	mov bx,cx
	add bx,stringd
	mov byte [ds:bx],0
	loop ClearBuf
	jmp Command

Command:
	mov ah,10h
	int 16h

	cmp ah,00Eh ; [Backspace]
	jz Delete_symbol

	cmp ah,01Ch ; [Return]
	jz Parse_Command

	cmp al,32d
	jae CheckForPrintableRange
	jmp Command

CheckForPrintableRange:
	cmp al,126d
	jle AddToBuffer
	jmp Command

AddToBuffer:
	mov ah,3
	mov bh,0
	int 10h

	cmp dl,53d ; Is cursor at end?
	jz Command

	mov [ds:stringd+si],al
	inc si

	mov ah,00Ah
	mov bx,7
	mov cx,1
	int 10h

	mov ah,3
	mov bh,0
	int 10h

	inc dl

	mov ah,2
	mov bh,0
	int 10h

 	jmp Command

Parse_Command:
	mov ah,3
	mov bh,0
	int 10h

	cmp dh,24d
	jz ScrollDown
AfterScroll:

	inc dh
	xor dl,dl
	call SetCursorPos

	mov ax,cs ; ?
	mov ds,ax ; ?
	mov es,ax ; ?
	mov ax,cs ; ?
	mov ds,ax ; ?
	mov es,ax ; ?

	mov bp,stringd
	call UpperCase

	mov di,stringd
	jmp Command_Integer_Parse
AfterIntegerParse:
	cmp ax,0 ; bad command
	jz Bad_Command
	cmp ax,1 ; cls
	jz ClearScreen_cl
	cmp ax,2 ; ver
	jz VersionInfo
	cmp ax,3 ; restart
	jz Restart
	jmp BSOD
Command_Integer_Parse:
; What it returns: 
;_____________________.
; AX     | Meaning    ;
;--------+------------;
; 0x0000 | <Bad cmd.> ;
; 0x0001 | CLS        ;
; 0x0002 | VER        ;
; 0x0003 | RESTART    ;
;---------------------;
	mov [Command_Integer_Parse@stringd],si
	xor ax,ax
	ccmps cmd_cls,		3, CC_cls		; AX = 0x0001
	ccmps cmd_ver,		3, CC_version	; AX = 0x0002
	ccmps cmd_restart,	7, CC_restart	; AX = 0x0003
	jmp AfterIntegerParse
CC_restart:
	inc ax
CC_version:
	inc ax
CC_cls:
	inc ax
	jmp AfterIntegerParse
;----
Command_Integer_Parse@stringd dw ?
;----
ScrollDown:
	mov ah,7
	mov al,3
	mov bh,7
	mov cx,dx
	mov dx,0184Fh ; x,y = 80,25
	jmp AfterScroll
;----
Delete_symbol:
	cmp dl,4
	jz Command
	dec dl
	call SetCursorPos
	mov al,20h
	mov [stringd+si],al
	mov ah,9
	mov bx,7
	mov cx,1
	int 10h
	dec si
	jmp Command
;----
bad db 'Bad command or file name',0
cmd_ver db 'VER',0
cmd_cls db 'CLS',0
cmd_restart db 'RESTART',0

;----
Bad_Command:
	mov bp,bad
	call TxtPrint
	;add dh,2
	;mov dl,0
	;call SetCursorPos
	mov bp,cmd_prompt
	call TxtPrint
	;add dl,4
	;call SetCursorPos
	jmp ClearBuffer
	; ret ; Смысла в RET здесь нет

PageUp:
	mov ax,2			; debug
	int 10h				; debug
	mov dl,0			; debug
	mov dh,0			; debug
	call SetCursorPos	; debug

	mov ax,00600h
	mov bx,00007h
	xor cx,cx
	mov dx,0184Fh ; x,y = 80,25
	int 10h

	mov ah,2
	mov bh,0
	xor dx,dx
	int 10h

	mov bp,cmd_prompt
	call TxtPrint

	mov dl,4			; debug
	mov dh,0			; debug
	call SetCursorPos	; debug
	jmp Command
	ret

;stringd db (50 + 1) dup (0)
	; (%d + 1) для /kernel/UpperCase