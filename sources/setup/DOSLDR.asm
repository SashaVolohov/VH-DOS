; Операционная система VH-DOS
; © Саша Волохов, 2020-2021.

; Данный файл служит для запуска установщика ОС, и представляет собой сам установщик.

	org 500h

start:
	mov ax, 0002h
    int 10h
	
	mov ah,02h
	mov bh,0
	mov dh,0
	mov dl,0
	int 10h
	
	mov bp,setup_welcome
	mov cx,27

	call print_mes
	
	mov ah,02h
	mov bh,0
	mov dh,2
	mov dl,0
	int 10h
	
	mov bp,setup_welcome_2
	mov cx,38

	call print_mes
	
	mov ah,02h
	mov bh,0
	mov dh,3
	mov dl,0
	int 10h
	
	mov bp,setup_welcome_3
	mov cx, 29

	call print_mes
	
	mov ah,02h
	mov bh,0
	mov dh, 5
	mov dl, 0
	int 10h
	
	mov ah,10h
    int 16h
	
	cmp al, 0Dh
    jz install
	jmp start

print_mes:
	mov bl,7
	xor bh,bh
	mov ax,1301h
	int 10h
	mov si,0
	ret

;----
setup_welcome db 'Welcome to Setup of VH-DOS!',0
setup_welcome_2 db 'Press Enter to start the installation.',0
setup_welcome_3 db 'Press Ctrl+Alt+Del to reboot.',0
setup_progress db 'Setup is copying files...',0
setup_error db 'DISK ERROR. Setup cannot continue.',0