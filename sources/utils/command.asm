	org 00600h

MACRO ccmps nstr, nlength, jumpto {
	mov si,[Command_Integer_Parse@String]
	push si
	mov si,nstr
	mov cx,nlength
	rep cmpsb
	jz jumpto
}

; Knowledge base
command_cls			equ 000000800h
;command_ver			equ 0000007E3h
command_restart		equ 0000007EEh
f_UpperCase			equ 000000A00h
TxtPrint			equ 000000A20h
MultiTxtPrint		equ 000000A30h
BSOD				equ 000001000h
;--------------------

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
Pre_Command:
	mov cx,50d
ClearBuf:
	mov bx,cx
	mov [string+bx],0
	loop ClearBuf
	jmp Command

Command:
	mov ah,10h
	;>1>;mov ah,0
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

	mov [string+si],al
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

	mov bp,string
	call f_UpperCase

	mov di,string
	jmp Command_Integer_Parse
AfterIntegerParse:
	cmp ax,0 ; bad command
	jz Bad_Command
	cmp ax,1 ; cls
	jz command_cls
	cmp ax,2 ; ver
	jz command_ver
	cmp ax,3 ; restart
	jz command_restart
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
	mov [Command_Integer_Parse@String],si
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
Command_Integer_Parse@String dw ?

ScrollDown:
	mov ah,7
	mov al,3
	mov bh,7
	mov cx,dx
	mov dx,0184Fh ; x,y = 80,25
	jmp AfterScroll

Delete_symbol:
	cmp dl,4
	jz Command
	dec dl
	call SetCursorPos
	mov al,20h
	mov [string+si],al
	mov ah,9
	mov bx,7
	mov cx,1
	int 10h
	dec si
	jmp Command
	
SetCursorPos:
	cmp dh,26
	jz PageUp
	cmp dh,27
	jz PageUp
	cmp dh,28
	jz PageUp
	cmp dh,29
	jz PageUp
	mov ah,2
	xor bh,bh
	int 10h
	ret

cmd_prompt db 'C:\>',0
bad db 'Bad command or file name',0
cmd_ver db 'VER',0
cmd_cls db 'CLS',0
cmd_restart db 'RESTART',0
verinfo db 'VH-DOS '
	file "..\version.txt"
	db '. (c) VH-DOS development team. Licensed under GNU GPLv3 license.',0

string db (50 + 1) dup (0)
	; (%d + 1) для /kernel/UpperCase

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
	;mov ax,2
	;int 10h
	;mov dl,0
	;mov dh,0
	;call SetCursorPos
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
	
	;mov dl,4
	;mov dh,0
	;call SetCursorPos
	jmp Command
	ret

command_ver:
	mov bp,verinfo
	call TxtPrint
	;add dh,2
	;mov dl,0
	;call SetCursorPos
	mov bp,cmd_prompt
	call TxtPrint
	;add dl,4
	;call SetCursorPos
	jmp ClearBuffer
	ret

ClearBuffer:
	mov cx,50d
ClearBuffer@Loop1:
	mov bx,cx
	mov [string+bx],0
	loop ClearBuffer@Loop1
	jmp Command