; FAT12 floppy disk MBR generator. Fully customizable.
; Licensed under Unlicense
; Written by Diicorp95.

; Code constants:
const_FAT12_8iS equ 0xE5 ; 8" SS/??
const_FAT12_5iD equ 0xED ; 5.25" DS/??
const_FAT12_ns1 equ 0xEE ; Non-standard custom partitions
const_FAT12_ns2 equ 0xEF ; Non-standard custom formats of Superfloppy
const_FAT12_3iD equ 0xF0 ; 3.5" DS/DD (1440K or 2880K)
const_FAT12_80st9 equ 0xF8 ; 80 tracks/side, 9 sectors/track:
                        ; 3.5" SS/??-SD (360K)
				        ; 5.25" DS/??-SD (720K)
const_FAT12_xF9 equ 0xF9 ; 80 tracks/side, Y sectors/track:
                        ; where Y is:
				        ; 9 - 3.5" DS/SD (720K)
				        ; 18 - 3.5" DS/DD (1440K)
				        ; 15 - 5.25" DS/ (1200K)
const_FAT12_xFA equ 0xFA ; 80 tracks/side, 8 sectors/track:
                        ; - 3.5" SS/?? (320K)
				        ; - 5.25" SS/?? (320K)
				        ; - RAM/ROM
				        ; Tandy MS-DOS detectable hard disk
const_FAT12_xFB equ 0xFB ; 80 tracks/side, 8 sectors/track:
                        ; - 3.5" DS (640K)
				        ; - 5.25" DS (640K)
const_FAT12_xFD equ 0xFD ; Can be:
                        ; - 5.25" DS (360K)
				        ; - 8" DS (500.5K)
				        ; - 8" DS/any density
const_FAT12_xFE equ 0xFE ; Can be:
                        ; - 5.25" SS (160K0
				        ; - 8" SS (250.3K)
				        ; - 8" DS (1232K)
				        ; - 8" SS/any density
const_FAT12_xFF equ 0xFF ; Can be:
                        ; - 5.25" DS (320K)
				        ; Sanyo 55x DS-DOS v2.11 detectable hard disk

; User constants:
text_FAT12_jumploc	equ Bootcode
text_FAT12_label	equ 'YOURNAME'	; [string]	OEM Label
text_FAT12_bs		equ 0,0x02		; [word]	Bytes/sector
text_FAT12_sc		equ 0x02		; [byte]	Sectors/cluster
text_FAT12_rs		equ	0x01,0		; [word]	Number of reserve sectors
text_FAT12_fatcount	equ 2			; [byte]	Number of FAT copies on disk
text_FAT12_dirent	equ	0			; [word]	Number of directory entires
text_FAT12_totalsec	equ	0,0x0D		; [word]	Total number of sectors
text_FAT12_meddesc	equ const_FAT12_3iD ; [byte] Media description
text_FAT12_sf		equ	512			; [word]	Number of sectors/1 FAT copy
text_FAT12_st		equ	2304		; [word]	Sectors/track
text_FAT12_heads	equ 0x02,0		; [word]	Number of heads
text_FAT12_hscount	equ	4 dup (0)	; [dword]	Number of hidden sectors
text_FAT12_lscount	equ	4 dup (0)	; [dword]	Large sector count
									; (if not equal to total sectors,
									; and more than 65535 sectors/volume)
text_FAT12_drvindex	equ 0			; [byte]	Index of the disk drive (USELESS!)
text_FAT12_NTflags	equ 0			; [byte]	Windows NT flags
text_FAT12_sign		equ 0x28 ; or 0x29 ; [byte] Signature
text_FAT12_serial	equ 0xFEBEADDE	; [dword]	Serial number (e.g. "DEAD-BEEF")
text_FAT12_ulabel	equ 'TESTUS' ; [string] Volume (user) label, length is should be less than 12
text_FAT12_isboot	equ 1			; Bootable? = 1, else 0. It's needed for IF in the code.

macro FAT12_ulabel {
	AA db text_FAT12_ulabel
	times (11 - ($ - AA)) db 0x20
}

start:
	db 0xEB, 0x3C, 0x90
	db text_FAT12_label ; STRING
	db text_FAT12_bs
	db text_FAT12_sc
	db text_FAT12_rs
	db text_FAT12_fatcount
	db text_FAT12_dirent
	db text_FAT12_totalsec
	db text_FAT12_meddesc
	dw text_FAT12_sf
	dw text_FAT12_st
	db text_FAT12_heads
	db text_FAT12_hscount
	db text_FAT12_lscount
	db text_FAT12_drvindex
	db text_FAT12_NTflags
	db text_FAT12_sign
	dd text_FAT12_serial
	FAT12_ulabel
Bootcode:
	cli
	xor ax,ax
	mov ds,ax
	mov ss,ax
	mov es,ax
	mov sp,0x7C00

	mov ax,0x0604
	int 0x16

	mov ax,0x0040 ; warm reboot
	push ax
	pop ds
	mov word [ds:0x0072],0x1234
		; because 0000:0072 == 0x1234
	mov ax,0xFFFF
	push ax
	mov ax,0
	push ax
	retf
; Bootcode ends
	db (512 - ($ - start) - 2) dup (0)

	if text_FAT12_isboot eq 1
		dw 0xAA55
	end if
