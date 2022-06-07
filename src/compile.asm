; VH-DOS Operating System
; by Sasha Volohov, Anton Fedorov. 2019-2021.
; by VH-DOS Development Team. 2021-present.

; This file serves to compile the entire OS.
; It specifies in what format the output BIN file should be

; Template for adding your own file*:
; ` file "path to file" ; *a short description of the file and your copyright*
; ` align 512
; *The file will occupy whole sector, therefore the file must be >= 512 bytes!

	org 0

macro zerobytes length {
	db length - 1 - ($ + length - 1) mod (length) dup 0
}

HEADS = 1
SPT = 7
Diskette_Size equ 1474560

begin:	; INSTALLATION FLOPPY DISK
	; SECTOR #1
	file "setup\pre_boot.bin", 512 ; for the next loader

	; SECTOR #2
	db 0xF0, 0xFF, 0xFF            ; 3,5" HD floppy disk
	zerobytes 512

	; SECTOR #3, 4, 5
	file "setup\boot.bin", 512     ; First loader (MBR) installer is > 512 bytes

	; SECTOR #6
	file "boot\boot.bin", 512      ; Loader [1]

	; SECTOR #7
	file "boot\DOSLDR.bin"         ; Loader [2]
	zerobytes 512

	; SECTOR #8
	file "utils\command.bin"       ; COMMAND.SYS prototype
	zerobytes 512

	; SECTOR #9
	file "kernel\BSOD.inc"         ; BSOD
	zerobytes 512

	zerobytes HEADS * SPT * 512

db (Diskette_Size - ($ - 0)) dup (0)
