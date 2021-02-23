; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.

; Данный файл служит для запуска ОС.
; Этот файл находится в MBR дискеты/жёсткого диска. Загружается по адресу 0x7c00

org 7c00h

FAT12_Bootable_Disk_Directive equ 055h,0AAh

start:
	cli
	xor ax,ax
	mov ds,ax
	mov es,ax
	mov ss,ax
	mov sp,07C00h
	sti
	
	mov ax, 0002h
	int 10h
	mov ah,2
	mov bh,0
	; xor dx,dx ; Не требуется
	int 10h

	mov bp,fail_ldr
	mov cx,18

	call print_mes

	mov ah,2
	mov bh,0
	mov dh,1
	mov dl,0
	int 10h

	mov bp,fail_ldr_two
	mov cx,29
	call print_mes

	mov ax,0
	mov es,ax
	mov bx,00500h
	mov ch,0
	mov cl,2
	mov dh,0
	mov dl,80d
	mov al,1
	mov ah,2
	int 13h
	jmp 0000:0500h
	call ClearMes
	
	mov ah,2
	mov bh,0
	mov dh,2
	mov dl,0
	int 10h
	
	jmp $
	
print_mes:
	mov bl,07h					
	xor bh,bh
	mov ax,1301h
	int 10h
	mov si,0
	ret
		
ClearMes:
	mov bp,0
	mov cx,0
	call print_mes
	ret
	
;----
fail_ldr db 'DOSLDR is missing.',0
fail_ldr_two db 'Press <Ctrl>-<Alt>-<Del> to restart.',0
db 512 - FAT12_Bootable_Disk_Directive - start dup (0)
db FAT12_Bootable_Disk_Directive
