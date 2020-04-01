
org 7c00h
use16   
jmp initialize ;; Внимание прижок   

;; Basic calls:
    ;; strlen    - return lenght of string
    ;; puts      - outpute string
    ;; putsc     - outpute char
    ;; puts_mas  - correct outpute strings more 25
    ;; fclear     - clear bash
    ;; htn_start - outpute hex ( 10h > outpute >  10 )
    ;; atn_start - outpute dec ( 10h > outpute >  16 )
    ;; cin       - input dec
    ;; nl        - new line
    ;; entr0     - bash call to enter command 
    ;; mes       - Output messages
        ;; bl - type of message ( 1, 2 - info, 3 - info + ask ( yes \ no ) )
        ;; dx - offset head line of message 
        ;; ax - text of message
        ;; return of ask ( Al - 1 - Yes | AL - 2 No )
    ;; bsod      - blue screen of death ( input AL - code of error )
    ;; clear_call - clear buffers
        ;; bx - offset buffer
        ;; di - end fill
    
     
    
    


;; FS calls : ( AL )
    ;; 01 - read file
    ;; 02 - write file
    ;; 03 - delete file
    ;; 04 - return offsets of file ( sect \ roll \ head )
    ;; 05 - output files ( input roll \ head )  
    
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                              ..:::NeoCommander:::..                             ;;

neocom_entr0:
call nl
mov al,01h
mov ah,02h
mov dl,80h
mov dh,00h  
mov ch,00h
mov cl,01h
mov bx,buffer
int 13h      
jc neocom_eror_1
mov al,[clor]
mov [def],al
mov [clor],00011111b
call fclear  
mov [neo_com_select],01h 
neocom_entr1:
mov dx,0000h
mov ah,02h 
int 10h 
mov cx,2048
mov al,' '
mov bl,[clor]
mov ah,09h
mov bh,0
int 10h  
mov dx,0000h
mov ah,02h 
int 10h 
mov bx,neo_frame  
call puts    
call nl      
mov bx,neo_com1
call puts
call nl       
mov bx,neo_com2
call puts
call nl
mov bx,neo_com3
call puts
call nl
mov bx,neo_com4
call puts
call nl
mov bx,neo_com5
call puts
call nl
mov bx,neo_com6
call puts
call nl        
mov bx,neo_com7
call puts
call nl
mov bx,neo_com8
call puts
call nl
mov bx,neo_com9
call puts
call nl
mov bx,neo_come
call puts 
call put_selected_line
mov ah,0
int 16h  
cmp ah,48h
jz neo_selected_up
cmp ah,50h
jz neo_selected_down    
cmp al,'w'
jz neo_selected_up
cmp al,'s'
jz neo_selected_down 
cmp ah,1Ch
jz neo_com 
jmp neocom_entr1

neo_selected_down: 
cmp [neo_com_select],10
jz neocom_entr1
mov al,[neo_com_select]
inc al
mov [neo_com_select],al
jmp neocom_entr1     

neo_selected_up:
cmp [neo_com_select],1
jz neocom_entr1
mov al,[neo_com_select]
dec al
mov [neo_com_select],al
jmp neocom_entr1  

neo_com:
mov al,[neo_com_select]
cmp al,01
jz neocom1  
cmp al,02
jz neocom2
cmp al,03
jz neocom3
cmp al,04
jz neocom4
cmp al,05
jz neocom5
cmp al,06
jz neocom6
cmp al,07
jz neocom7
cmp al,08
jz neocom8
cmp al,09
jz neocom9
cmp al,10
jz neocom10


neocom1:
mov dx,0000h
mov ah,02h 
int 10h 
mov cx,2048
mov al,' '
mov bl,[clor]
mov ah,09h
mov bh,0
int 10h  
mov dx,0000h
mov ah,02h 
int 10h 
mov bx,neo_frame  
call puts    
call nl                                     
mov bx,neo_com1_mes1
call puts
call nl
mov ah,0
int 16h
cmp ah,1Ch
jz neocom1_1
cmp ah,01h
jz neo_coms_exit 
neocom1_1:
mov bx,neo_com1_mes2
call puts
call cin  
mov al,[cnum]
mov [frollp],al
jmp neocom_entr1

neo_com1_mes1 db 'Press Enter to write number, or Escape to return                               ',0
neo_com1_mes2 db 'Write number of roll : ',0

       
neocom2:
mov dx,0000h
mov ah,02h  
mov bh,00h
int 10h 
mov cx,2048
mov al,' '
mov bl,[clor]
mov ah,09h
mov bh,0
int 10h   
mov bh,00h
mov dx,0000h
mov ah,02h 
int 10h 
mov bx,neo_frame  
call puts    
call nl                                     
mov bx,neo_com1_mes1
call puts
call nl
mov ah,0
int 16h
cmp ah,1Ch
jz neocom2_1
cmp ah,01h
jz neo_coms_exit 
neocom2_1:
mov bx,neo_com2_mes2
call puts
call cin  
mov al,[cnum]
mov [fheadp],al
jmp neocom_entr1

neo_com2_mes2 db 'Write number of head : ',0


neocom3:
mov dx,0000h
mov ah,02h  
mov bh,00h
int 10h 
mov cx,2048
mov al,' '
mov bl,[clor]
mov ah,09h
mov bh,0
int 10h   
mov bh,00h
mov dx,0000h
mov ah,02h 
int 10h 
mov bx,neo_frame  
call puts    
call nl                                     
mov bx,neo_com1_mes1
call puts
call nl
mov ah,0
int 16h
cmp ah,1Ch
jz neocom3_1
cmp ah,01h
jz neo_coms_exit 
neocom3_1:
mov bx,neo_com3_mes2
call puts
call cin  
mov al,[cnum]
mov [roll],al 
formate_neo:   
 mov cl,00 
 mov [sect],cl  
 formate_neo_01: 
 mov bx,empy
 mov ch,[roll]              
 mov dh,[fheadp]        
 mov al,01h         
 mov ah,03h 
 mov dl,80h        
 int 13h   
 mov cl,[sect]
 inc cl
 mov [sect],cl
 cmp [sect],0FFh
 jne formate_neo_01 
jmp neocom_entr1
 

neo_com3_mes2 db 'Write number of roll : ',0


neocom4: 
mov dx,0000h
mov ah,02h  
mov bh,00h
int 10h 
mov cx,2048
mov al,' '
mov bl,[clor]
mov ah,09h
mov bh,0
int 10h   
mov bh,00h
mov dx,0000h
mov ah,02h 
int 10h 
mov bx,neo_frame  
call puts    
call nl                                     
mov bx,neo_com1_mes1
call puts
call nl
mov ah,0
int 16h
cmp ah,1Ch
jz neocom4_1
cmp ah,01h
jz neo_coms_exit 
neocom4_1:
mov bx,neo_com4_mes2
call puts
call cin     
mov al,[cnum]
mov [head],al 
mov [roll],0FFh
mov [sect],00h
formate_neo2:  
 mov ch,[roll]
 inc ch
 mov [roll],ch 
 mov cl,00 
 mov [sect],cl  
 formate_neo_02: 
 mov bx,empy
 mov ch,[roll]              
 mov dh,[head]        
 mov al,01h         
 mov ah,03h 
 mov dl,80h        
 int 13h   
 mov cl,[sect]
 inc cl
 mov [sect],cl
 cmp [sect],0FFh
 jne formate_neo_02
 cmp [roll],0FFh
 jnz formate_neo2
jmp neocom_entr1
 

neo_com4_mes2 db 'Write number of head : ',0


neocom5: 
mov dx,0000h
mov ah,02h  
mov bh,00h
int 10h 
mov cx,2048
mov al,' '
mov bl,[clor]
mov ah,09h
mov bh,0
int 10h   
mov bh,00h
mov dx,0000h
mov ah,02h 
int 10h 
mov bx,neo_frame  
call puts    
call nl                                     
mov bx,neo_com5_mes1
call puts
call nl
mov ah,0
int 16h
cmp ah,1Ch
jz neocom5_1
cmp ah,01h
jz neo_coms_exit 
neocom5_1:
mov bx,neo_com5_mes2
call puts        
mov bx,buffer
mov di,511
call input_call 
call fclear
mov dx,0000h
mov ah,02h
mov bh,0
int 10h 
mov bx,buffer1
mov di,511
call input_call 
mov cx,buffer1
mov bx,buffer
mov al,02h
call file_sys        
jmp neocom_entr1
 
neo_com5_mes1 db 'Press Enter to write name of file, or Escape to return                         ',0
neo_com5_mes2 db 'Write name of file : ',0



neocom6: 
mov dx,0000h
mov ah,02h  
mov bh,00h
int 10h 
mov cx,2048
mov al,' '
mov bl,[clor]
mov ah,09h
mov bh,0
int 10h   
mov bh,00h
mov dx,0000h
mov ah,02h 
int 10h 
mov bx,neo_frame  
call puts    
call nl                                     
mov bx,neo_com5_mes1
call puts
call nl
mov ah,0
int 16h
cmp ah,1Ch
jz neocom6_1
cmp ah,01h
jz neo_coms_exit 
neocom6_1:
mov bx,neo_com5_mes2
call puts        
mov bx,buffer
mov di,511
call input_call 
mov bx,buffer
mov al,03h
call file_sys      
jmp neocom_entr1


neocom7:
mov dx,0000h
mov ah,02h  
mov bh,00h
int 10h 
mov cx,2048
mov al,' '
mov bl,[clor]
mov ah,09h
mov bh,0
int 10h   
mov bh,00h
mov dx,0000h
mov ah,02h 
int 10h 
mov bx,neo_frame  
call puts    
call nl                                     
mov bx,neo_com5_mes1
call puts
call nl
mov ah,0
int 16h
cmp ah,1Ch
jz neocom7_1
cmp ah,01h
jz neo_coms_exit 
neocom7_1:
mov bx,neo_com5_mes2
call puts        
mov bx,buffer
mov di,511
call input_call 
mov bx,buffer
mov al,01h
call file_sys 
call fclear
mov dx,0000h
mov ah,02h  
mov bh,02h
int 10h
mov bx,2000h
call puts
mov ah,0
int 16h 
mov ah,0
int 16h    
jmp neocom_entr1




neocom8: 
call fclear_blue
mov dx,0000h
mov ah,02h
mov bh,00h
int 10h
neocom_8_1: 
mov al,'['
call putsc         
mov al,[offset_start]
add al,[offset_fil1]  
push ax
cmp al,09
jnbe neocom_8_2
mov al,'0'
call putsc
neocom_8_2:
pop ax
push ax
cmp al,99
jnbe neocom_8_3
mov al,'0'
call putsc
neocom_8_3:
pop ax
call atn_start   
mov al,']'
call putsc
mov al,' '
call putsc
mov bx,2000h   
mov dh,[fheadp]
mov ch,[frollp]
mov cl,[offset_start]
add cl,[offset_fil1] 
mov dl,80h
mov ah,02h    
mov al,01h
mov ah,02h
int 13h  ;; BSOD
mov bx,2000h
call puts        
mov cl,[offset_fil1]
inc cl
inc cl
mov [offset_fil1],cl
mov ch,50
cmp cl,ch
jz neocom_8_4
call nl  
jmp neocom_8_1
neocom_8_4:   
mov ah,0
int 16h  
cmp ah,48h
jz neocom_8_scroll_up
cmp ah,50h
jz neocom_8_scroll_down 
cmp ah,1Ch
jz neocom_8_exit
jmp neocom_8_4  

neocom_8_exit:
call fclear
jmp neo_coms_exit

neocom_8_scroll_up: 
cmp [offset_start],1
jz neocom_8_4 
sub [offset_start],02h   
mov [offset_fil1],00h
jmp neocom8     

neocom_8_scroll_down:   
cmp [offset_start],207
jz neocom_8_4 
add [offset_start],02h
mov [offset_fil1],00h
jmp neocom8








offset_start db 1
offset_fil1  db 0 
offset_file  db 0     


neocom9: 
call fclear_blue
mov dx,0000h
mov ah,02h
mov bh,00h
int 10h
neocom_9_1: 
mov al,'['
call putsc         
mov al,[offset_start]
add al,[offset_fil1]  
push ax
cmp al,09
jnbe neocom_9_2
mov al,'0'
call putsc
neocom_9_2:
pop ax
push ax
cmp al,99
jnbe neocom_9_3
mov al,'0'
call putsc
neocom_9_3:
pop ax
call atn_start   
mov al,']'
call putsc
mov al,' '
call putsc
mov bx,2000h   
mov dh,[fheadp]
mov ch,[frollp]
mov cl,[offset_start]
add cl,[offset_fil1] 
mov dl,80h
mov ah,02h    
mov al,01h
mov ah,02h
int 13h  ;; BSOD
mov bx,2000h
call puts        
mov cl,[offset_fil1]
inc cl
inc cl
mov [offset_fil1],cl
mov ch,50
cmp cl,ch
jz neocom_9_4
call nl  
jmp neocom_9_1
neocom_9_4:

mov al,[neocom_selected_file]
mov dl,160
mul dl
mov bx,ax
push ds
mov ax,0B800h
mov ds,ax
mov si,0000h       
mov ah,11110001b   
put_selected_neo_1:
mov [bx+si+1],ah 
add si,02h
cmp si,160
jnz put_selected_neo_1     
pop ds

 
mov ah,0
int 16h 
cmp al,'w'
jz selected_file_up
cmp al,'s'
jz selected_file_down 
cmp ah,48h
jz neocom_9_scroll_up
cmp ah,50h
jz neocom_9_scroll_down 
cmp ah,1Ch
jz neocom_9_work
cmp ah,0Eh
jz neocom_9_exit
jmp neocom_9_4  

neocom_9_work:
mov al,[offset_start]
add al,[neocom_n]
mov [neocom_sector],al 
call fclear_blue  
mov dx,0000h
mov ah,02h
mov bh,00h
int 10h
mov bx,neocom_9_mes_1
call puts        
neocom_work_0:
mov ah,0
int 16h
cmp al,'1'
jz neocom_9_com_1   
cmp al,'2'
jz neocom_9_com_2
cmp al,'3'
jz neocom_9_com_3
cmp al,'4'
jz neocom_9_com_4  
cmp al,'5'
jz neocom_9_com_5
jmp neocom_work_0

neocom_9_com_1:
call nl 
mov bx,neo_com5_mes2
call puts 
mov bx,buffer
mov di,511
call input_call 
call fclear_blue 
mov dx,0000h
mov ah,02h
mov bh,00h  
int 10h  
mov bx,buffer1
mov di,511
call input_call
mov bx,buffer  
mov dh,[fheadp]
mov ch,[frollp]
mov cl,[neocom_sector] 
mov dl,80h   
mov al,01h
mov ah,03h
int 13h 
mov bx,buffer1  
mov dh,[fheadp]
mov ch,[frollp]
mov cl,[neocom_sector] 
inc cl
mov dl,80h   
mov al,01h
mov ah,03h
int 13h  
jmp neocom9

neocom_9_com_2: 
call fclear_blue
mov bx,buffer
mov di,511
call clear_call 
mov dx,0000h
mov ah,02h
mov bh,00h
int 10h
mov bx,buffer  
mov dh,[fheadp]
mov ch,[frollp]
mov cl,[neocom_sector] 
inc cl
mov dl,80h   
mov al,01h
mov ah,02h
int 13h  
mov bx,buffer
call puts
mov ah,0
int 16h 
jmp neocom9


neocom_9_com_3:
mov bx,empy
mov dh,[fheadp]
mov ch,[frollp]
mov cl,[neocom_sector] 
mov dl,80h   
mov al,01h
mov ah,03h
int 13h    
mov bx,empy
mov dh,[fheadp]
mov ch,[frollp]
mov cl,[neocom_sector] 
inc cl
mov dl,80h   
mov al,01h
mov ah,03h
int 13h   
jmp neocom9

neocom_9_com_4: 
call nl  
mov bx,neo_com5_mes2
call puts 
mov bx,buffer
mov di,511
call input_call 
mov bx,buffer
mov dh,[fheadp]
mov ch,[frollp]
mov cl,[neocom_sector] 
mov dl,80h   
mov al,01h
mov ah,03h
int 13h      
jmp neocom9

neocom_9_com_5:   
jmp neocom9





neocom_9_mes_1 db '1) Write file',0Ah,0Dh,'2) Read file',0Ah,0Dh,'3) Delete file',0Ah,0Dh,'4) Rename file',0Ah,0Dh,'5) Exit',0



selected_file_up:
cmp [neocom_selected_file],00h
jz neocom_9_4 
sub [neocom_n],02h
sub [neocom_selected_file],01h
jmp neocom9    

selected_file_down:
cmp [neocom_selected_file],24
jz neocom_9_4 
add [neocom_n],02h
add [neocom_selected_file],01h
jmp neocom9       
 

neocom_9_exit:
call fclear
jmp neo_coms_exit

neocom_9_scroll_up: 
cmp [offset_start],1
jz neocom_9_4 
sub [offset_start],02h   
mov [offset_fil1],00h
jmp neocom9    

neocom_9_scroll_down:   
cmp [offset_start],207
jz neocom_9_4 
add [offset_start],02h
mov [offset_fil1],00h
jmp neocom9   

neocom_sector        db 0
neocom_n             db 0
neocom_selected_file db 0
;;;                      



neocom10:
mov al,[def]
mov [clor],al
call fclear
jmp entr0

neo_coms_exit:
jmp neocom_entr1 


put_selected_line: 
mov dh,[neo_com_select]
add dh,02h
mov al,[neo_com_select]
cmp al, 01h
jz neo_com1w  
cmp al, 02h
jz neo_com2w
cmp al, 03h
jz neo_com3w
cmp al, 04h
jz neo_com4w
cmp al, 05h
jz neo_com5w
cmp al, 06h
jz neo_com6w
cmp al, 07h
jz neo_com7w
cmp al, 08h
jz neo_com8w
cmp al, 09h
jz neo_com9w
cmp al, 0Ah
jz neo_com10w


neo_com1w: 
mov [clor],11110001b
mov ah,02
mov dl,00
mov bh,00
int 10h
mov bx,neo_com1
call puts 
mov [clor],00011111b
ret
 
neo_com2w: 
mov [clor],11110001b
mov ah,02
mov dl,00
mov bh,00
int 10h
mov bx,neo_com2
call puts 
mov [clor],00011111b   
ret              

neo_com3w: 
mov [clor],11110001b
mov ah,02
mov dl,00
mov bh,00
int 10h
mov bx,neo_com3
call puts 
mov [clor],00011111b   
ret

neo_com4w: 
mov [clor],11110001b
mov ah,02
mov dl,00
mov bh,00
int 10h
mov bx,neo_com4
call puts 
mov [clor],00011111b   
ret

neo_com5w: 
mov [clor],11110001b
mov ah,02
mov dl,00
mov bh,00
int 10h
mov bx,neo_com5
call puts 
mov [clor],00011111b   
ret

neo_com6w: 
mov [clor],11110001b
mov ah,02
mov dl,00
mov bh,00
int 10h
mov bx,neo_com6
call puts 
mov [clor],00011111b   
ret

neo_com7w: 
mov [clor],11110001b
mov ah,02
mov dl,00
mov bh,00
int 10h
mov bx,neo_com7
call puts 
mov [clor],00011111b   
ret

neo_com8w: 
mov [clor],11110001b
mov ah,02
mov dl,00
mov bh,00
int 10h
mov bx,neo_com8
call puts 
mov [clor],00011111b   
ret     

neo_com9w: 
mov [clor],11110001b
mov ah,02
mov dl,00
mov bh,00
int 10h
mov bx,neo_com9
call puts 
mov [clor],00011111b   
ret

neo_com10w: 
mov [clor],11110001b
mov ah,02
mov dl,00
mov bh,00
int 10h
mov bx,neo_come
call puts 
mov [clor],00011111b   
ret
   











neocom_eror_1:
mov bx,neo_error_1
call puts

neo_error_1 db 'Error 01: Can not read hard drive. Quiting...',0
neo_frame   db '                               .::Neo Commander::.',0Ah,0Dh
            db '--------------------------------------------------------------------------------',0 
neo_com1    db ' Change active roll                                                            ',0
neo_com2    db ' Change active head                                                            ',0
neo_com3    db ' Formate roll                                                                  ',0
neo_com4    db ' Formate head                                                                  ',0
neo_com5    db ' Create file                                                                   ',0
neo_com6    db ' Delete file                                                                   ',0
neo_com7    db ' Read   file                                                                   ',0
neo_com8    db ' Output files on current roll                                                  ',0
neo_com9    db ' Quit work with files mode                                                     ',0
neo_come    db ' Return to shell                                                               ',0
neo_com_select db 01h




                                                                                  ;;
                                                                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


fclear_blue:  
push ds
mov ax,0B800h
mov ds,ax
mov si,0000h   
mov al,' '
mov ah,00011111b  
fclear_blue_01:
mov [si],al
mov [si+1],ah
cmp si,3998
jz fclear_blue_exit
add si,02h
jmp fclear_blue_01 
fclear_blue_exit:
pop ds
jmp e

up_cursor:  
mov ah,03h
mov bh,00h
int 10h
dec dh
mov ah,02h
mov bh,00h
int 10h
jmp input_file_call_p0     

left_cursor:
mov ah,03h
mov bh,00h
int 10h
dec dl
mov ah,02h
mov bh,00h
int 10h  
jmp input_file_call_p0

down_cursor:
mov ah,03h
mov bh,00h
int 10h
inc dh
mov ah,02h
mov bh,00h
int 10h   
jmp input_file_call_p0

right_cursor:
mov ah,03h
mov bh,00h
int 10h
dec dl
mov ah,02h
mov bh,00h
int 10h               
jmp input_file_call_p0

input_file_call_empy:
mov al,00
call putsc
jmp input_file_call_p0


input_file_call: 
push bx
call fclear
mov dx,0000h
mov bh,0000h
mov ah,02h
int 10h
input_file_call_p0:   
mov ah,0
int 16h   
cmp ah,0Eh
jz input_file_call_empy
cmp ah,48h
jz up_cursor
cmp ah,4Bh
jz left_cursor
cmp ah,50h
jz down_cursor
cmp ah,4Dh
jz right_cursor
cmp ah,1Ch
jz input_file_call_exit
call putsc
jmp input_file_call_p0 

input_file_call_exit:
mov ax,0B800h
mov es,ax 
mov si,0000h 
mov di,si      
pop bx
input_file_call_p1:
mov al,[es:si]     
mov [bx+di],al
cmp di,2000
jz e
add si,02h
inc di 
jmp input_file_call_p1    


input_call:
mov si,0000h
call clear_call
mov si,0000h
input_call_p0:
mov ah,0
int 16h       
cmp ah,1Ch
jz e
cmp ah,0Eh
jz input_call_backspace  
cmp di,si              
jz input_call_p0       
mov [bx+si],al
push bx         
call putsc
pop bx
inc si
jmp input_call_p0


input_call_backspace:
cmp si,0000h  
jz input_call_p0
dec si
mov al,0     
mov [bx+si],al
mov al,08h
mov ah,0Eh
int 10h
mov al,20h
int 10h
mov al,08h
int 10h
jmp input_call_p0 


clear_call:
mov si,0000 
mov al,00
clear_call_01:
mov [bx+si],al
cmp si,di
jz e
inc si
jmp clear_call_01
    


;; Default output - without colors   
put_def:
mov al,[bx]
test al,al
jz e
inc bx
int 10h
jmp put_def

clear_blue0:
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h
mov al,' '
mov bl,[clor]
mov ah,09h
mov cx,2048
mov bh,00h
int 10h
mov [f],00h
jmp e

fclear:
mov al,[clor]
cmp al,00011111b
jz clear_blue0
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h   
mov [f],00h
jmp e


exit:
int 19h  


halt_Y:
call fclear
mov bx,halted
call puts
cli 
hlt

halted db 'Halted, shutdown PC on button...',0

halt:  
call nl
mov bx,halts
call puts
mov ah,0
int 16h
cmp al,'Y'
jz halt_Y    
cmp al,'y'
jz halt_Y 
cmp ah,1Ch
jz halt_Y
jmp entr0 


beep_sound: 
mov al,07h
mov ah,0Eh
int 10h
mov ah,01h
int 16h
jz beep_sound
mov ah,0
int 16h  
jmp entr0  

version: 
call nl
mov bx,build
call puts        
jmp entr0

build db 'Version is 0.1d',0

run_sector: 
call clear_buffer_0
mov si,0000h 
call nl
mov bx,hhead
call puts
call cin
mov al,[cnum]
mov [head],al 
call nl   
mov bx,hroll
call puts
call cin
mov al,[cnum]
mov [roll],al
call nl   
mov bx,hsect
call puts
call cin
mov al,[cnum]
mov [sect],al
 mov bx,buffer
 mov ch,[roll]              
 mov dh,[head]  
 mov cl,[sect]          
 mov al,01h         
 mov ah,[hh] 
 mov dl,80h
 int 13h
 jc eror 
 call nl
 jmp buffer   
 jmp entr0   

buff_cl db 0

get_0Ah:
mov cl,0Ah 
ret
get_0Bh: 
mov cl,0Bh
ret
get_0Ch:  
mov cl,0Ch
ret
get_0Dh:  
mov cl,0Dh
ret
get_0Eh:  
mov cl,0Eh
ret
get_0Fh:  
mov cl,0Fh 
ret

get_hex:
cmp cl,'A'
jz get_0Ah
cmp cl,'B'
jz get_0Bh
cmp cl,'C'
jz get_0Ch
cmp cl,'D'
jz get_0Dh
cmp cl,'E'
jz get_0Eh
cmp cl,'F'
jz get_0Fh
sub cl,30h
ret       

put_hex:       
call get_hex
mov al,16
mul cl    
mov cl,al
mov dl,cl
mov cl,ch
call get_hex  
add dl,cl   
ret


entr_hex:  
cmp si,01h
jz deb_hex
mov al,20h
mov ah,0Eh
int 10h
mov si,0000h
jmp deb_hex 

del_1:
mov al,08h
mov ah,0Eh
int 10h         
mov si,0002h
jmp deb_hex

del_hex:   
cmp si,0000h
jz del_1
dec si     
dec di
mov [buff+di],00h
mov al,08h
mov ah,0Eh
int 10h
mov al,20h
int 10h
mov al,08h
int 10h
jmp deb_hex  

debug_run:      
call nl
push program_return
jmp dbuff

debug1:     
mov [topd],di
mov di,0000h
mov si,0000h   
d0:
mov cl,[buff+di]
mov ch,[buff+di+1]
call put_hex
mov [dbuff+si],dl
inc di
inc di       
inc si       
cmp di,[topd]
jz debug_run
jmp d0   

topd dw 0

clear_buff_01: 
mov ax,0000h
mov si,0000h
cbs_01:
mov [buff+si],00
inc si
cmp si,1000
jne cbs_01
ret  

clear_buff_02: 
mov ax,0000h
mov si,0000h
cbs_02:
mov [dbuff+si],90
inc si
cmp si,1025
jne cbs_01
ret        

save_deb:   
mov [topd],di
mov di,0000h
mov si,0000h   
d1:
mov cl,[buff+di]
mov ch,[buff+di+1]
call put_hex
mov [dbuff+si],dl
inc di
inc di       
inc si       
cmp di,[topd]
jz debug_save
jmp d1    

debug_save:
call nl   
mov si,0000h
mov bx,cmd_file_name
call clear_bufffs 
mov si,0000h 
mov bx,filename
call puts
mov si,0000h
cmd_fs_deb: 
mov ah,0
int 16h   
cmp ah,1Ch
jz cmd_fs_deb1
mov [cmd_file_name+si],al
inc si 
call putsc 
jmp cmd_fs_deb
cmd_fs_deb1:
mov cx,dbuff
mov bx,cmd_file_name
mov al,02h
call file_sys
jmp entr0 


print_hex_com:  
mov al,0Ah
mov ah,0Eh
int 10h
mov al,0Dh
int 10h   
mov si,0000h
call clear_buff_01
mov si,0000h
call clear_buff_02     
mov si,0000h
mov di,0000h
deb_hex:
mov ah,0
int 16h
cmp al,'s'
jz save_deb  
cmp al,27
jz entr0
cmp al,20h
jz debug1
cmp ah,1Ch
jz entr_hex
cmp ah,0Eh
jz del_hex   
cmp si,02h
jz deb_hex   
mov [buff+di],al
call putsc
inc si   
inc di   
jmp deb_hex              

strlen:
mov al,[bx]
test al,al
jz e 
inc si      
inc bx
jmp strlen
              
blue: 
mov [clor],10011111b
jmp entr0
black:   
mov [clor],00001111b
jmp entr0
              
;; CMOS_Status
mmx_have:
mov bx,trues
call puts
jmp mmx_suc   

drive_have:
mov bx,trues
call puts
call nl
jmp drive_suc


cmos_stats:   
call nl
mov al,14h
out 70h,al
in al,71h  
mov [stat],al
mov bx,cdroms
call puts  
mov al,[stat]
test al,00000001b
jz drive_have
mov bx,falses
call puts
call nl
drive_suc:
mov bx,mmx
call puts
mov al,[stat]
test al,00000010b
jnz mmx_have
mov bx,falses
call puts
mmx_suc:   
ret


cdroms db 'Available drives = ',0
mmx   db 'Availability of FPU = ',0
trues db 'True',0
falses db 'False',0
stat db 00h 



eror_mem:
mov al,02h
mov [error],02h
jmp bsod

check_memory:      
call nl
mov bx,avaim
call puts
mov al,16h
out 70h,al
in al,71h  
mov ch,al
call htn_start  
mov al,15h
out 70h,al
in al,71h 
mov cl,al
call htn_start
cmp cx,0280h
jnb eror_mem
ret      





;; BSOD      

bad_memory:
mov bx,sram
call puts
mov ah,0
int 16h
mov al, 0xFE 
out 0x64, al
jmp entr0 

damage_uknown: 
mov bx,duknown
call puts
mov ah,0
int 16h
int 19h

damage_fs_wc: 
mov [error],00h
mov bx,dfwc
call puts   
mov ah,0
int 16h
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h     
mov ah,09h
mov al,' '
mov cx,2048  
mov bl,[def]
mov [clor],bl
mov bl,[clor]
mov bh,00h
int 10h
mov ah,02h
mov dx,0000h
mov bh,00h
int 10h
jmp entr0



bsod:          
mov bl,[clor]
mov [def],bl
mov [error],al
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h      
mov cx,2048
mov bl,00010001b
mov al,' '
mov ah,09h
mov bh,00h
int 10h     
mov [clor],00011111b
mov bx,damage
call puts 
mov al,[error]  
cmp al,01h
jz damage_fs_wc  
cmp al,02h
jz bad_memory
jmp damage_uknown
error db 0





;; 1) Системка вывода сообщений ( Не путать с выводом строк )
;; 2) Вывод на екран лого
;; 3) Процедура сохранения данных на винчестер  
;; 4) Процедура чтения данных с винчестера   
;; 5) Ввод десятичного числа 8-ми битного числа с клавиатуры  
;; 6) Вывод строк на екран   

;; File System
fse:
mov al,01h
ret          

fs_sect_read:
mov dl,80h
mov bx,1000h
mov ah,02h
mov al,01h
mov dh,[fhead]
mov ch,[froll]
mov cl,[fsect]
int 13h        
ret 

fs_buff_clear:
mov si,0000h  
mov cx,0000h
fs_buff_clear1:
mov bx,1000h
mov [bx+si],cx
inc si
cmp si,256   
jne fs_buff_clear1
ret

fses:
cmp al,cl
jz fse
mov al,02h
ret

fs_equs1:  
cmp cl,00h
jz fses 
inc si   
fs_equs: 
mov al,[bx+si]
mov cl,[1000h+si]
inc si
cmp al,cl
jz fs_equs1
mov al,02h
ret
      

fs_check_file_name: 
mov si,0000h
mov al,01h 
mov bx,[fname]
mov cx,1000h
call fs_equs
cmp al,01h
jz file_finded
jmp fs_point1

end_find:
mov dl,0FFh
ret            

file_finish_read:
mov dl,80h
mov bx,2000h
mov ah,02h
mov al,01h        
mov cl,[fsect]
inc cl
mov dh,[fhead]
mov ch,[froll]
int 13h
mov dl,0FFh
ret   

file_erase:
mov dl,80h
mov bx,empy
mov ah,03h
mov al,01h        
mov cl,[fsect]
mov dh,[fhead]
mov ch,[froll]
int 13h    
mov dl,80h
mov bx,empy
mov ah,03h
mov al,01h        
mov cl,[fsect]
mov dh,[fhead]
mov ch,[froll]
inc cl
int 13h  
mov dl,0FFh
ret         

file_info:
mov cl,[fsect]
mov ch,[froll]
mov dh,[fhead]
ret

file_finded:
mov dl,[ftype]
cmp dl,01h
jz file_finish_read  
cmp dl,03h
jz file_erase    
cmp dl,04h
jz file_info
ret
 

fs_next_roll: 
mov [fsect],01h
mov ch,[froll]
inc ch
mov [froll],ch
cmp ch,0FFh
jz end_find       

fs_space_finded:
mov dl,80h
mov bx,[fname]
mov ah,03h
mov al,01h
mov dh,[fhead]
mov ch,[froll]
mov cl,[fsect]
int 13h  
mov cl,[fsect]     
inc cl
mov dl,80h
mov bx,[fdata]
mov ah,03h
mov al,01h
mov dh,[fhead]
mov ch,[froll]
int 13h 
mov dl,0FFh
ret        

fs_find_file_to_erace: 
jmp fs_check_file_name 
fs_check_file_status:  
jmp fs_check_file_name


fs_find_available_space:
mov al,[1000h]
cmp al,00h
jz fs_space_finded  
jmp fs_point1 

fs_find: 
push dx   
mov dl,[fheadp]     
mov [fhead],dl
mov dl,[frollp]  
mov [froll],dl 
mov [fsect],01h
pop dx
fs_find1:
call fs_sect_read
mov dl,[ftype]
cmp dl,01h
jz fs_check_file_name
cmp dl,02h
jz fs_find_available_space
cmp dl,03h
jz fs_find_file_to_erace
cmp dl,04h
jz fs_check_file_status 
fs_point1:             
mov al,[fsect]
cmp al,255
jz fs_next_roll  
mov cl,[froll]
cmp cl,0FFh
jz end_find 
mov cl,[fsect]
add cl,02h  
mov [fsect],cl  
call fs_buff_clear
jmp fs_find1 

fheadp db 1
frollp db 1


fs_read:   
mov dl,01
jmp fs_find

fs_write:
mov dl,02
jmp fs_find

fs_erase: 
mov dl,03
jmp fs_find  

fs_check:
mov dl,04h
jmp fs_find

rete:
ret         

clear_dir_names:
mov si,0000h
mov ax,0000h 
cdn:
mov [3000+si],ax
cmp si,00FFh
jz rete
inc si
jmp cdn

fs_dir:
mov dl,05h
mov [fsect],01h  
mov ch,[roll]
mov [froll],ch
mov dh,[head]
mov [fhead],dh
jmp fs_dir0
fs_dir1:  
mov cl,[fsect]
add cl,02h 
mov [fsect],cl
cmp cl,0FFh
jz exit_dir
fs_dir0:    
call clear_dir_names
mov cl,[fsect]     
mov dl,80h
mov bx,3000h
mov ah,02h
mov al,01h
mov dh,[fhead]
mov ch,[froll]
int 13h 
mov al,[3000h]
cmp al,00h
jz fs_dir1
call nl
mov bx,3000h 
mov di,0000h 
call puts_mas
jmp fs_dir1

exit_dir:
ret

         
file_sys:  
push bx   
push ax
mov bx,2000h
call clear_bufffs
pop ax
pop bx
mov [fdata],cx   
mov dl,al
mov [ftype],dl
mov [fname],bx
cmp al,01
jz fs_read
cmp al,02
jz fs_write
cmp al,03
jz fs_erase
cmp al,04
jz fs_check
cmp al,05
jz fs_dir 
mov al,01h
mov [error],01h
jmp bsod


fsect db 0
fhead db 0
froll db 0  
fname dw 0 
fdata dw 0 
ftype db 0



;;                          еще раз внимание НАЧАЛО КОДА ТУТ НО ИСПОЛНЯТСЯ НЕ ОТ СЮДА! 
;; 1)
;; Система для быстрого вывода сообщения мы его видим в самом начале ОС ( список команд )
;; DX = Аддресс строки заголовка сообщения 
;; AX = Аддресс самого сообщения
;; BL = Если равно 3 то будет запрос нажать Y или N результат после выполения останеться в AL
;; AL = 01 - Когда была нажата Y 
;; AL = 02 - Когда было нажата N
;; message ______________________________________________________________________________________
apply1:
mov al,01h
ret
apply2:   
mov al,02h
ret   
   
apply:
call nl
mov bx,appl
call puts 
apply0:
mov ah,0
int 16h
cmp al,'y'
jz apply1
cmp al,'n'
jz apply2
jmp apply0

 
      
cl1:
mov [clor],00001111b 
jmp mes0
cl2:                
mov [clor],00001100b
jmp mes0
cl3:                
mov [clor],00001001b
jmp mes0
mes:     
mov [mest],bl
mov [mesh],dx
mov [mesi],ax        
push dx
mov dl,[clor] 
mov [pclor],dl
pop dx
cmp bl,01h
jz cl1
cmp bl,02h
jz cl2 
cmp bl,03h
jz cl3 
mes0:
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h
mov bx,word [mesh]
call puts  
call nl
mov bx,mline
call puts  
call nl
mov bx,word [mesi]
call puts 
call nl
mov bx,mline
call puts   
cmp [mest],01h
jz em
cmp [mest],02h
jz em  
cmp [mest],03h
jz apply 
jmp em

em:
mov ah,0
int 16h
ret


      
appl  db '# Yes (y) | No (n) #',0
mest  db 0
mesh  dw 0
mesi  dw 0
pclor db 0
clor  db 0 
mline db '________________________________________________________________________________',0

;;                             Конец системки вывода сообщений  
;; ###########################################################################################









;; ############################################################################################

nl_test_roll:
call nl
jmp test_roll
test_roll_start:   
mov bl,[clor]
mov [def],bl
call nl
mov bx,hhead
call puts
call cin
mov al,[cnum]
mov [head],al 
call nl   
mov bx,hroll
call puts
call cin
mov al,[cnum]
mov [roll],al
call nl 
mov [sect],00h
jmp test_roll                     
def db 0                   
test_green:
mov [clor],10101010b
mov al,' '     
mov [utime],al  
mov bx,utime
call puts
test_roll: 
mov ah,03h
mov bh,00h
int 10h
cmp dl,4Fh
jz nl_test_roll
mov bx,3000h
 mov ch,[roll]              
 mov dh,[head]  
 mov cl,[sect]          
 mov al,01h         
 mov ah,02h 
 mov dl,80h
 int 13h 
 mov ah,03h
int 10h   
 cmp dl,4Eh
 jz nl_roll 
 roll0: 
 mov cl,[sect]
 cmp cl,0FFh
 jz test_roll_exit
 inc cl
 mov [sect],cl 
 mov al,[3000h]
 cmp al,00h
 jz test_green
 mov [clor],11001100b 
mov al,' '     
mov [utime],al  
mov bx,utime
call puts
 jmp test_roll 
 nl_roll:
 call nl
 jmp roll0
 
 test_roll_exit:
 mov bl,[def]
 mov [clor],bl  
 call nl
 jmp entr0


;; ############################################################################################














;; 2)
;;#############################################################################################
;;          Єта функция выводит на екран лого ничего интересного просто вывод строк 
logo:
mov [clor],00001010b 
jmp logo_start   

new_l1: 
push dx
push ax
push bx   
call nl 
mov ah,03h
mov dl,00h
inc dh
mov ah,02h
mov bh,00h
int 10h
pop bx
pop ax
pop dx 
pop bx 
inc bx 
jmp puts1

puts1:   
mov al,[bx]
test al,al
jz e     
push bx
mov cx,01h  
mov bl,[clor]
mov bh,0
mov ah,09
int 10h
mov ah,03h
int 10h 
cmp dl,4Fh
jz new_l1
inc dl
mov ah,02h
mov bh,0
int 10h 
pop bx     
inc bx 
jmp puts1 

logo_start:
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h
mov dx,0000h
mov ah,02h  
mov bh,0
int 10h
mov bx,a1
call puts     
mov bx,a2
call puts  
mov bx,a3
call puts  
mov bx,a4
call puts  
mov bx,a5
call puts  
mov bx,a6
call puts   
mov bx,a7
call puts  
mov bx,a8
call puts  
mov bx,a9
call puts
mov bx,a10
call puts  
mov bx,a11
call puts  
mov bx,a12
call puts  
mov bx,a13
call puts  
mov bx,a14
call puts   
mov bx,a15
call puts  
mov bx,a16
call puts 
mov bx,a17
call puts 
mov bx,a18
call puts 
mov bx,a19
call puts  
mov bx,a20
call puts
mov ah,00h
int 16h
ret 

;; ###############################################################################################
;;                                    Конец вывода лого на екран 

;; 3) 
;; ###############################################################################################
;;                             Процедура записи на винчестер данных                             
;;  BX - Аддресс данных 
;;  Все следующие данные надо будеть ввести с клавиатуры в формате от 0 до 255 
;; Головка
;; Дорожка
;; Сектор                                                                     


save:      
push bx
mov [an],al 
call nl
mov bx,hhead
call puts
call cin
mov al,[cnum]
mov [head],al 
call nl   
mov bx,hroll
call puts
call cin
mov al,[cnum]
mov [roll],al
call nl   
mov bx,hsect
call puts
call cin
mov al,[cnum]
mov [sect],al 
 pop bx     
 mov al,[an]
 mov ch,[roll]              
 mov dh,[head]  
 mov cl,[sect]          
 mov al,01h         
 mov ah,[03h] 
 mov dl,80h
 int 13h
ret 
;; ###############################################################################################
;;                                      Конец записи на винчестер данных


;; 4) 
;; ###############################################################################################
;;                             Процедура записи на винчестер данных 
;;  AL - Количество секторов для чтения                             
;;  BX - Аддресс данных 
;;  Все следующие данные надо будеть ввести с клавиатуры в формате от 0 до 255 
;; Головка
;; Дорожка
;; Сектор  

fload:     
push bx
mov [an],al 
call nl
mov bx,hhead
call puts
call cin
mov al,[cnum]
mov [head],al 
call nl   
mov bx,hroll
call puts
call cin
mov al,[cnum]
mov [roll],al
call nl   
mov bx,hsect
call puts
call cin
mov al,[cnum]
mov [sect],al
 pop bx
 mov al,[an]
 mov ch,[roll]              
 mov dh,[head]  
 mov cl,[sect]                   
 mov ah,[02h] 
 mov dl,80h
 int 13h
ret 

;; ###############################################################################################
;;                                      Конец чтения с винчестера данных



;; Использую для выхода из call прижком сюда 
e: 
mov [e1],01h  
mov [g1],01h
ret    


;; Очиста екрана и установка нужного текстового режима BIOS, а так-же задание цвета текста. 
;; Переменная clor содержит цвет текста и цвет заднего фона текста
setcmd:
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h
mov dx,0000h
mov ah,02h  
mov bh,0
int 10h
mov [color],00001111b
mov [bcolor],00000000b 
mov al,[color]
mov ah,[bcolor]
add al,ah
mov [clor],al
ret

;; 5)
;; Ввод десятичного 8-ми битного числа с клавыатуры
;; Число попадает в режист CL а так-же в переменную "cnum"
;; __________________________________________________________________________CIN____________________________________________________________________________________________________________________________________________

delh:
cmp si,0000h
jz cin0     
dec si
mov ah,0x0E
mov bh,0
mov al,8
int 10h
mov ah,0x0E
mov bh,0
mov al,0
int 10h
mov ah,0x0E
mov bh,0
mov al,8
int 10h 
mov [cinn+si],00h
jmp cin0

hec:
mov si,0
mov [cnum],cl
ret

cin:  
mov si,0000h
cin0:
mov ah,0
int 16h  
cmp ah,0Eh  
jz delh
cmp ah,1Ch
je hecg
cmp si,03h
je cin0  
push ax    
mov [utime],al
mov bx,utime
call puts
pop ax
sub al,30h
mov ah,00h
mov [cinn+si],al
inc si
jmp cin0 
hecg:   
mov si,0
mov [cnum],0
mov cx,0000h
mov ax,0000h
mov al,[cinn+02h]
add cl,al
mov al,[cinn+01h]   
mov dl,0Ah
mul dl
add cl,al 
mov al,[cinn+00h]
mov dl,0Ah
mul dl
mul dl
add cl,al
jmp hec  

;; ###############################################################################################
;;                      Конец ввода десятичного 8-ми битного числа с клавиатуры

;; 6) 
;; ###############################################################################################
;;                                          Вывод строк на екран

;; Вывод большого массива строк
end_screen:    
mov ah,00h
int 16h
mov di,0000h
jmp puts_mas
   
new_l_mas: 
push dx
push ax
push bx
inc di
cmp di,24
jz end_screen   
call nl
pop bx
pop ax
pop dx 
pop bx 
inc bx 
jmp puts_mas

Ah0_mas:
mov ah,0Eh
mov al,0Ah
int 10h   
inc bx      
inc di
cmp di,24
jz end_screen  
jmp puts_mas  
          
Dh0_mas:
mov ah,0Eh
mov al,0Dh
int 10h   
inc bx
jmp puts_mas     

puts_mas:   
mov al,[bx]
test al,al
jz e   
cmp al,0Ah
jz Ah0_mas
cmp al,0Dh
jz Dh0_mas 
push bx 
mov cx,01h  
mov bl,[clor]
mov bh,0
mov ah,09
int 10h
mov ah,03h
int 10h 
cmp dl,4Fh
jz new_l_mas
inc dl
mov ah,02h
mov bh,0
int 10h 
pop bx     
inc bx 
jmp puts_mas 




      ;;         Перевод строк, так чтоб небыло багов, для двух функций выводов разные 
newl:  
push dx
push ax
push bx
call nl
pop bx
pop ax
pop dx
inc bx  
jmp putsc  
new_l: 
push dx
push ax
push bx   
call nl
pop bx
pop ax
pop dx 
pop bx 
inc bx 
jmp puts   


;; Если вдруг в строке 0Ah или 0Dh то вывод через другую подпрограмму INT 10б так как 09 Не поддерживает их  
Ah0:
mov ah,0Eh
mov al,0Ah
int 10h   
inc bx
jmp puts  
          
Dh0:
mov ah,0Eh
mov al,0Dh
int 10h   
inc bx
jmp puts   

 

;; Сам цикл вывода для строк 
;; _______STRING___________________________________________________________________________________
puts:   
mov al,[bx]
test al,al
jz e    
cmp al,0Ah
jz Ah0
cmp al,0Dh
jz Dh0 
push bx 
mov cx,01h  
mov bl,[clor]
mov bh,0
mov ah,09
int 10h
mov ah,03h
int 10h 
cmp dl,4Fh
jz new_l
inc dl
mov ah,02h
mov bh,0
int 10h 
pop bx     
inc bx 
jmp puts  

;; Сам цикл вывода для символа ( Не коректен, не доработан, забаган )  
;; _________CHAR_________________________________________________________________________________
putsc: 
mov ah,03h
int 10h
cmp dl,80
jz newl
mov cx,01h  
mov bl,[clor]
mov bh,0
mov ah,09
int 10h 
mov ah,03h
int 10h  
cmp dl,4Fh
jz newl
inc dl
mov ah,02h
mov bh,0
int 10h   
ret 

;; ################################################################################################
;;                                    КОНЕЦ ВЫВОДА СТРОК НА ЕКРАН


;; Вывод строчки на екран 
;; BX - Аддресс строки
screen_first:  
mov bx,NeoOS
call puts
ret

;; Проверка работоспособности винчестера через функции биос прериваные 13
checkdev1:
mov bx,false
call puts
ret 
checkdev0: 
mov bx,true
call puts     
mov [hard],01h
mov al,0Dh
mov ah,0Eh
int 10h   
mov al,0Ah
mov ah,0Eh
int 10h 
mov bx,readh
call puts
mov ax,0000h
mov es,ax
mov bx,0100h
mov ch,00h
mov cl,01h
mov dh,00h
mov dl,80h
mov al,01h
int 13h 
jc checkdev1
mov bx,true
call puts
ret
checkdev:  
mov al,0Dh
mov ah,0Eh
int 10h   
mov al,0Ah
mov ah,0Eh
int 10h
mov bx,cheak
call puts
mov dl,80h
mov ah,15h
int 13h
cmp ah,03h
jz checkdev0
mov bx,false
call puts
mov [hard],00h
ret   
;; Конец проверки 

del:         
cmp di,0001h
jz entr1     
dec si
mov ah,0x0E
mov bh,0
mov al,8
int 10h
mov ah,0x0E
mov bh,0
mov al,0
int 10h
mov ah,0x0E
mov bh,0
mov al,8
int 10h 
mov [buff+si],00h
dec di
jmp entr1      

clear_buff:
mov si,0000h
clr0:
mov [buff+si],00h
inc si
cmp si,80h
jnz clr0
ret      
dr db 132,160,232,160,32,226,235,32,171,226,231,232,160,239,03,0
;; ############################################################################################################
;; Для дебагера
;; Тут процедура для проверки строк на индентичность. Использую там где нужно команду размером строчку проверить
;; ///////////////////////////////// EQUS ////////////////////////////////////////////////////// 
equs2:
mov al,[bx]
cmp al,cl
jz e
ret

equs1:
inc bx
inc si
equs:  
mov cl,[buff+si]
mov al,[bx] 
cmp cl,00h
jz equs2      
mov al,[bx]
mov cl,[buff+si]
cmp al,cl      
jz equs1 
ret  

dequs1:
inc bx
inc si
dequs:
mov al,[bx] 
cmp al,00h
jz e      
mov al,[bx]
mov cl,[dbuff+si]
cmp al,cl      
jz dequs1 
ret
      
;; ##################################################################################################      


;; Вывод на екран помощи (help)            
chelp:
mov bx,cchelp
call puts
jmp entr0 


e_e1:
pop ds
ret                  

;; Очистка екрана 
clear_buff_video:
push ds
mov si,0   
mov cl,00h
mov ax,0B800h
mov ds,ax
clear_buff_video_0:
mov [si],cl
cmp si,0FFFFh
jz e_e1
inc si       
jmp clear_buff_video_0


clear_blue:
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h
mov al,' '
mov bl,[clor]
mov ah,09h
mov cx,2048
mov bh,00h
int 10h
mov [f],00h
jmp entr0

clear:
mov al,[clor]
cmp al,00011111b
jz clear_blue
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h   
mov [f],00h
jmp entr0        


;; Программа смены цвета текста, а именно значения переменной clor
ccolor:   
mov ah,0Eh
mov al,0Ah
int 10h
mov al,0Dh
int 10h
mov bx,cc3
call puts 
mov al,0Ah
mov ah,0Eh
int 10h
mov al,0Dh
int 10h
mov bx,ccr
call puts   
mov al,0Ah
mov ah,0Eh
int 10h
mov al,0Dh
int 10h
mov bx,ccg
call puts 
mov al,0Ah
mov ah,0Eh
int 10h
mov al,0Dh
int 10h
mov bx,ccb
call puts  
mov al,0Ah
mov ah,0Eh
int 10h
mov al,0Dh
int 10h
mov bx,ccd
call puts
mov al,0Ah
mov ah,0Eh
int 10h
mov al,0Dh
int 10h 
mov bx,cbwd
call puts
call nl
mov bx,cbwg
call puts
call nl
mov bx,cbdef
call puts
call nl
mov bx,cline
call puts
p4:
mov ah,0
int 16h  
cmp al,'1'
jz cred
cmp al,'2'
jz cgee
cmp al,'3'
jz cblu   
cmp al,'4'
jz cbwh 
cmp al,'5'
jz cbwc1  
cmp al,'6'
jz cgbc1 
cmp al,'7'
jz def_color
jmp entr0 

girl:    
call nl     
mov bl,0
mov ah,0Eh
 mov dl,0
 mov bx,dr
 mov ah,14
 call puts 
jmp entr0  

cbwc1:    
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h   
mov cx,2048
mov al,' '
mov bh,00h
mov bl,00011111b
mov ah,09h
int 10h 
mov ah,02h
mov dx,0000h
mov bh,00h
int 10h
mov [clor],00011111b
jmp entr0
cgbc1:   
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h  
mov [clor],00000010b
jmp entr0
def_color:
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h   
mov [clor],00001111b
jmp entr0
cred:     
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h  
mov [clor],00000100b
jmp entr0
cgee:     
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h   
mov [clor],00000010b
jmp entr0
cblu:     
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h          
mov [clor],00000001b
jmp entr0  
cbwh:     
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h   
mov [clor],00001111b 
jmp entr0
;; ###################################################################################################

del1: 
cmp si,0000
jz p6
dec si
mov ah,0x0E
mov bh,0
mov al,8
int 10h
mov ah,0x0E
mov bh,0
mov al,0
int 10h
mov ah,0x0E
mov bh,0
mov al,8
int 10h
jmp p6       


;; Уже хз но ничего интересного просто писать текст на екран, незнаю зачем но сделал.       
cecho:
mov si,0000h
mov ah,0Eh
mov al,0Ah
int 10h
mov al,0Dh
int 10h
p6:   
mov ah,0
int 16h   
cmp ah,1Ch
jz p6
cmp al,1Bh
jz eecho 
cmp ah,0Eh  
jz del1 
cmp si,79
jz del1
inc si
mov [utime],al  
mov bx,utime
call puts
jmp p6  

eecho:   
mov ah,03h
int 10h
inc dh
mov ah,02h
mov bh,0
int 10h 
jmp entr0   
;; ############################################################################################

checkdev00:
call checkdev
jmp entr0     

clr_pbuff:
mov si,0000h
mov [buff+si],00h
inc si
cmp si,80h
jz clr_pbuff
ret        


;; ##################################################################################################
;; Маштабный кусок кода дебагера

del2:
cmp di,0001h
jz pg0     
dec si
mov ah,0x0E
mov bh,0
mov al,8
int 10h
mov ah,0x0E
mov bh,0
mov al,0
int 10h
mov ah,0x0E
mov bh,0
mov al,8
int 10h 
mov [dbuff+si],00h
dec di
jmp pg0   


;; Помощь в меню дебагера
ghelp:
mov bx,cgh
call puts
jmp pg    

;; Выход из дебагера
gquit:   
call nl
jmp entr0           

;; Очистка на клавишу backspace
depdel:
cmp si,0000h
jz dep0
dec si
mov ah,0x0E
mov bh,0
mov al,8
int 10h
mov ah,0x0E
mov bh,0
mov al,0
int 10h
mov ah,0x0E
mov bh,0
mov al,8
int 10h 
mov [programm+si],00h
jmp dep0 

;; Ну очень простой, не оптимизированый конвентор с псевдо бинара 01010101 в десятичное число
b1:       
add cl,128
jmp b_1
b2:       
add cl,64     
jmp b_2
b3:      
add cl,32 
jmp b_3
b4:     
add cl,16
jmp b_4
b5:     
add cl,8
jmp b_5
b6:     
add cl,4
jmp b_6
b7:     
add cl,2
jmp b_7
b8:
add cl,1
jmp b_8

degrs:
mov cl,00h
mov al,[programm+0]
cmp al,31h
jz b1
b_1: 
mov al,[programm+1]
cmp al,31h
jz b2
b_2:         
mov al,[programm+2]
cmp al,31h
jz b3
b_3:
mov al,[programm+3]
cmp al,31h
jz b4
b_4:
mov al,[programm+4]
cmp al,31h
jz b5
b_5:
mov al,[programm+5]
cmp al,31h
jz b6
b_6:
mov al,[programm+6]
cmp al,31h
jz b7
b_7:              
mov al,[programm+7]
cmp al,31h
jz b8
b_8:
mov [programm1+di],cl
inc di
jmp dep




printt: 
mov di,0000h
mov si,0000h
dep:   
mov si,0000h
mov ah,0Eh
mov al,0Ah
int 10h
mov al,0Dh
int 10h  
mov bx,degp
call puts
dep0:   
mov ah,00h
int 16h  
cmp al,'q'
jz pg
cmp ah,1Ch
jz degrs
cmp ah,0Eh
jz depdel
cmp si,00008h
jz dep0    
mov [programm+si],al  
push si 
call putsc
pop si
inc si
jmp dep0  

fhelps:
call nl
mov bx,message1
call puts
jmp entr0


;; Запуск команды на дебагере, просто безусловный прижок на метку куда записивали тот бинарик что вводили
run:
mov bx,pg
push bx         
mov ah,0Eh
mov al,0Ah
int 10h
mov al,0Dh
int 10h
jmp programm1

;; Проверка введеной команды дебагера
dcom:
mov [g1],00h
mov al,[dbuff]
cmp al,00h
jz pg
push si
mov si,0000h
mov bx,cg5 
call dequs 
mov al,[g1]
cmp al,01h
jz ghelp  
mov si,0000h
mov bx,cg0 
call dequs 
mov al,[g1]
cmp al,01h
jz gquit   
mov si,0000h
mov bx,cg1 
call dequs 
mov al,[g1]
cmp al,01h
jz printt   
mov si,0000h
mov bx,cg4 
call dequs 
mov al,[g1]
cmp al,01h
jz run
jmp pg
      
;; DEBUG____________________________________________________________________________________________      
             
debug: 
call nl
mov ah,0Eh
mov al,0Ah
int 10h
mov al,0Dh
int 10h
mov ah,03h
int 10h    
mov bx,deg
call puts
pg:
mov al,0Ah
mov ah,0Eh
int 10h
mov al,0Dh
mov ah,0Eh
int 10h      
mov bx,degl
call puts    
mov si,0000h
mov di,0001h
pg0:   
mov ah,0
int 16h   
cmp ah,1Ch
jz dcom
cmp ah,0Eh  
jz del2
mov [dbuff+si],al 
call putsc    
inc si  
inc di
jmp pg0


jmp pg0  

comcom:
call checkcom
jmp entr0

nl:
mov ah,0Eh
mov al,0Ah
int 10h
mov al,0Dh
int 10h   
ret

;; COM_MENY_________________________________________________________________________________________
         
comme1:
;; read
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h
mov bx,comr
call puts
call nl  
cm0:
mov ah,01h
int 16h
jnz comme
mov dx,[comp]
mov ah,02h
int 14h   
cmp al,00h
jz cm0
call putsc
mov al,00h
jmp cm0
 
comme2:
;; write  
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h 
mov bx,comw
call puts
call nl
cm1:
mov ah,00h
int 16h
cmp al,1Bh
jz comme
mov dx,[comp]
mov ah,01h
int 14h   
call putsc
jmp cm1
 

comme3:
;; quit  
jmp entr0 

com10:
mov dx,0000h
jmp comme
com11:      
mov dx,0001h
jmp comme

comme: 
call nl
mov [comp],dx
call nl
mov bx,comy1
call puts
call nl
mov bx,comy2
call puts
call nl
mov bx,comy3
call puts
call nl
mov bx,comy4
call puts
call nl  
comss:
mov ah,00
int 16h 
cmp al,'1'
jz comme1 
cmp al,'2'
jz comme2 
cmp al,'3'
jz comme3   
jmp comss


;; ECHO______________________________________________________________________________________________
echo_ret:
jmp entr0 

eror_read: 
call nl  
mov bx,eror_r
call puts
jmp entr0
eror_write:
call nl  
mov bx,eror_w
call puts
jmp entr0
          
eror:
mov al,[hh]
cmp al,02h
jz eror_read
cmp al,03h
jz eror_write
jmp entr0
 
echo: 
mov si,0000h
call nl
echo0:     
mov ah,0
int 16h 
cmp al,1Bh
jz echo_ret
mov [utime],al
mov bx,utime
call puts  
inc si
jmp echo0  

symll:
call nl
call cin
mov bx,cnum
call puts
jmp entr0  


;; dec number on screen
nt:    
pop ax     
mov al,ah
cmp ah,20h
jz e       
add al,30h
call putsc
jmp nt
atn_start:  
mov [tne],al
mov al,00h
mov ah,20h
push ax     
mov al,[tne]
atn: 
cmp al,00h
jz nt
mov ah,00h  
mov cl,0Ah
div cl  
push ax
jmp atn
tne db 0 

;; hec number on screen
nt0:    
pop ax    
cmp al,20h
jz e
add ah,30h 
mov al,ah
mov ah,0Eh
int 10h
jmp nt0
htn_start:  
mov [tne],al
mov al,20h
mov ah,00h
push ax     
mov al,[tne]
atn0: 
cmp al,00h
jz nt0
mov ah,00h  
mov cl,10h
div cl  
push ax
jmp atn0 
 
hread:      
call clear_buffer_0
mov si,0000h 
mov [hh],02h   
jmp hwork

clear_buffer_0:
mov si,0000h
clear_buffer_1:
mov [buffer+si],00h
inc si
cmp si,512
jz e
jmp clear_buffer_1   

hdel:
cmp si,0000h
jz hwork1   
dec si
mov ah,0x0E
mov bh,0
mov al,8
int 10h
mov ah,0x0E
mov bh,0
mov al,0
int 10h
mov ah,0x0E
mov bh,0
mov al,8
int 10h 
mov [buffer+si],00h
jmp hwork1

hwork0:   
call clear_buffer_0
mov si,0000h 
hwork1: 
mov ah,0
int 16h
cmp ah,1Ch
jz hwork
cmp ah,0Eh  
jz hdel
mov [buffer+si],al 
call putsc   
inc si 
jmp hwork1

hwrite:
mov [hh],03h
call nl     
jmp hwork0

hwork:    
call nl
mov bx,hhead
call puts
call cin
mov al,[cnum]
mov [head],al 
call nl   
mov bx,hroll
call puts
call cin
mov al,[cnum]
mov [roll],al
call nl   
mov bx,hsect
call puts
call cin
mov al,[cnum]
mov [sect],al
 mov bx,buffer
 mov ch,[roll]              
 mov dh,[head]  
 mov cl,[sect]          
 mov al,01h         
 mov ah,[hh] 
 mov dl,80h
 int 13h
 jc eror    
 jmp entr0   
 
 echob:
 call nl
 mov si,0000h
 mov bx,buffer
 call puts
 jmp entr0        
 
 hcls:        
 call nl
 mov [hh],03h
mov bx,hhead
call puts
call cin
mov al,[cnum]
mov [head],al 
call nl   
mov bx,hroll
call puts
call cin
mov al,[cnum]
mov [roll],al
call nl   
mov bx,hsect
call puts
call cin
mov al,[cnum]
mov [sect],al
 mov bx,empy
 mov ch,[roll]              
 mov dh,[head]  
 mov cl,[sect]          
 mov al,01h         
 mov ah,[hh] 
 mov dl,80h
 int 13h
 jc eror    
 jmp entr0  
 
shutdow:
mov al, 0xFE 
out 0x64, al
jmp entr0 

clear_bufffs: 
mov ax,0000h
mov si,0000h
cbs:
mov [bx+si],ax
inc si
cmp si,00FFh
jne cbs
ret



cmd_fs_write:   
call nl
mov bx,cmd_file_data
call clear_bufffs 
mov bx,cmd_file_name
call clear_bufffs 
mov si,0000h 
mov bx,filename
call puts
mov si,0000h
cmd_fs0: 
mov ah,0
int 16h   
cmp ah,1Ch
jz cmd_fs1
mov [cmd_file_name+si],al
inc si 
call putsc 
jmp cmd_fs0
cmd_fs1:
mov si,0000h  
call nl        
mov bx,filedata
call puts
mov si,0000h
cmd_fs2: 
mov ah,0
int 16h   
cmp ah,1Ch
jz cmd_fs3
mov [cmd_file_data+si],al
inc si 
call putsc 
jmp cmd_fs2  
cmd_fs3:
mov cx,cmd_file_data
mov bx,cmd_file_name
mov al,02h
call file_sys
jmp entr0 


cmd_fs_read:          
call nl
mov bx,filename
call puts
mov bx,cmd_file_name  
call clear_bufffs  
mov si,0000h  
cmd_fs00: 
mov ah,0
int 16h   
cmp ah,1Ch
jz cmd_fs11
mov [cmd_file_name+si],al
inc si 
call putsc 
jmp cmd_fs00
cmd_fs11:
mov bx,cmd_file_name
mov al,01h
call file_sys 
call nl 
mov bx,filedata
call puts
mov bx,2000h
call puts
jmp entr0    

cmd_fs_del_mes:
mov bx,file_deleted
call puts
jmp entr0

cmd_fs_erase:  
call nl
mov bx,filename   
call puts
mov bx,cmd_file_name
call clear_bufffs  
mov si,0000h  
cmd_fs000: 
mov ah,0
int 16h   
cmp ah,1Ch
jz cmd_fs111
mov [cmd_file_name+si],al
inc si 
call putsc 
jmp cmd_fs000
cmd_fs111:
mov bx,cmd_file_name
mov al,03h
call file_sys 
call nl
cmp dl,0FFh
jz cmd_fs_del_mes
mov bx,file_not_deleted
call puts 
jmp entr0 
 
cmd_fs_clear:
mov bx,2000h  
call clear_bufffs
mov bx,bfc
call puts  

formating:      
call nl
mov bx,format_mes
call puts
mov [sect],01h 
mov bl,[clor]
mov [def],bl
call nl
mov bx,hhead
call puts
call cin
mov al,[cnum]
mov [head],al 
call nl   
mov bx,hroll
call puts
call cin
mov al,[cnum]
mov [roll],al
call nl 
mov [sect],00h
jmp formate

formate:  
 mov bx,empy
 mov ch,[roll]              
 mov dh,[head]  
 mov cl,[sect]          
 mov al,01h         
 mov ah,03h 
 mov dl,80h
 int 13h   
 mov cl,[sect]
 inc cl
 mov [sect],cl
 cmp [sect],0FFh
 jne formate
 jmp entr0  
 
fs_dir_c:
call nl
mov bx,hhead
call puts
call cin
mov al,[cnum]
mov [head],al 
call nl   
mov bx,hroll
call puts
call cin
mov al,[cnum]
mov [roll],al
mov bl,[roll]
mov bh,[head]
mov al,05
call file_sys   
jmp entr0 

get_time:  
call nl
mov bx,timess
call puts
mov ah,02h
int 1Ah  
mov al,ch
call htn_start 
mov al,':'
call putsc 
mov ah,02h
int 1Ah  
mov al,cl
call htn_start  
mov al,':'
call putsc 
mov ah,02h
int 1Ah  
mov al,dh
call htn_start  
jmp entr0 

best db 'best',0
test_bsod:
mov al,06h
call file_sys
jmp entr0 
         
system_stat:
call cmos_stats   
jmp entr0   

Glados:
call nl
mov bx,glados
call puts
jmp entr0  

run_prog:        
call nl
mov bx,filename
call puts
mov bx,cmd_file_name  
call clear_bufffs  
mov si,0000h  
cmd_fs0_deb: 
mov ah,0
int 16h   
cmp ah,1Ch
jz cmd_fs1_deb
mov [cmd_file_name+si],al
inc si 
call putsc 
jmp cmd_fs0_deb
cmd_fs1_deb:
mov bx,cmd_file_name
mov al,01h
call file_sys 
call nl   
push program_return
jmp 2000h
jmp entr0   

program_return:  
call nl
mov bx,returned
mov ah,0
int 16h
call puts
jmp entr0
         
fcheck:
call nl
mov bx,filename
call puts
mov bx,cmd_file_name  
call clear_bufffs  
mov si,0000h  
cmd_fs0_deb_fcheck: 
mov ah,0
int 16h   
cmp ah,1Ch
jz cmd_fs1_deb_fcheck
mov [cmd_file_name+si],al
inc si 
call putsc 
jmp cmd_fs0_deb_fcheck
cmd_fs1_deb_fcheck:
mov bx,cmd_file_name
mov al,04h
call file_sys    
push dx
push cx
push cx          
call nl
mov bx,hsect
call puts
pop cx
mov al,cl     
call atn_start
call nl       
mov bx,hroll
call puts
pop cx
mov al,ch
call atn_start
call nl       
mov bx,hhead
call puts
pop dx
mov al,dh
call atn_start
jmp entr0


          
      

                                                                                         


;; Проверка введеной команды 
;; COM_TEST__________________________________________________________________________________________
com_1:  
mov [e1],00h
mov al,[buff]
cmp al,00h
jz entr0
push si
mov si,0000h
mov bx,c1 
call equs 
mov al,[e1]
cmp al,01h
jz chelp
push si
mov si,0000h
mov bx,c2 
call equs 
mov al,[e1]
cmp al,01h
jz clear 
push si
mov si,0000h
mov bx,c3 
call equs 
mov al,[e1]
cmp al,01h
jz ccolor  
push si
mov si,0000h
mov bx,c8 
call equs 
mov al,[e1]
cmp al,01h
jz checkdev00  
mov si,0000h
mov bx,c4 
call equs 
mov al,[e1]
cmp al,01h
jz debug     
mov si,0000h
mov bx,c9 
call equs 
mov al,[e1]
cmp al,01h
jz comcom  
mov si,0000h
mov bx,c10 
call equs 
mov al,[e1]
cmp al,01h
jz com10 
mov si,0000h
mov bx,c11 
call equs 
mov al,[e1]
cmp al,01h
jz com11   
mov si,0000h
mov bx,c7 
call equs 
mov al,[e1]
cmp al,01h
jz echo  
mov si,0000h
mov bx,c12 
call equs 
mov al,[e1]
cmp al,01h
jz symll 
mov si,0000h
mov bx,c5 
call equs 
mov al,[e1]
cmp al,01h
jz hread 
mov si,0000h
mov bx,c6
call equs 
mov al,[e1]
cmp al,01h
jz hwrite  
mov si,0000h
mov bx,c13
call equs 
mov al,[e1]
cmp al,01h
jz echob  
mov si,0000h
mov bx,c14
call equs 
mov al,[e1]
cmp al,01h
jz hcls   
mov si,0000h
mov bx,c15
call equs 
mov al,[e1]
cmp al,01h
jz shutdow
mov si,0000h
mov bx,c16
call equs 
mov al,[e1]
cmp al,01h
jz test_roll_start    
mov si,0000h
mov bx,c17
call equs 
mov al,[e1]
cmp al,01h
jz cmd_fs_write 
mov si,0000h
mov bx,c18
call equs 
mov al,[e1]
cmp al,01h
jz cmd_fs_read       
mov si,0000h
mov bx,c19
call equs 
mov al,[e1]
cmp al,01h
jz cmd_fs_erase     
mov si,0000h
mov bx,c20
call equs 
mov al,[e1]
cmp al,01h
jz cmd_fs_clear 
mov si,0000h
mov bx,c21
call equs 
mov al,[e1]
cmp al,01h
jz formating
mov si,0000h
mov bx,c22
call equs 
mov al,[e1]
cmp al,01h
jz fs_dir_c     
mov si,0000h
mov bx,c23
call equs 
mov al,[e1]
cmp al,01h
jz get_time  
mov si,0000h
mov bx,c24
call equs 
mov al,[e1]
cmp al,01h
jz test_bsod  
mov si,0000h
mov bx,c25
call equs 
mov al,[e1]
cmp al,01h
jz system_stat   
mov si,0000h
mov bx,c26
call equs 
mov al,[e1]
cmp al,01h
jz Glados      
mov si,0000h
mov bx,c27
call equs 
mov al,[e1]
cmp al,01h
jz fhelps  
mov si,0000h
mov bx,c28
call equs 
mov al,[e1]
cmp al,01h
jz print_hex_com    
mov si,0000h
mov bx,c29
call equs 
mov al,[e1]
cmp al,01h
jz run_prog    
mov si,0000h
mov bx,c30
call equs 
mov al,[e1]
cmp al,01h
jz run_sector
mov si,0000h 
mov bx,c31
call equs 
mov al,[e1]
cmp al,01h
jz fullhelp 
mov si,0000h 
mov bx,c32
call equs 
mov al,[e1]
cmp al,01h
jz version    
mov si,0000h 
mov bx,c33
call equs 
mov al,[e1]
cmp al,01h
jz beep_sound    
mov si,0000h 
mov bx,c34
call equs 
mov al,[e1]
cmp al,01h
jz halt
mov si,0000h 
mov bx,c35
call equs 
mov al,[e1]
cmp al,01h
jz exit
mov si,0000h 
mov bx,c36
call equs 
mov al,[e1]
cmp al,01h
jz fcheck
mov si,0000h 
mov bx,best
call equs 
mov al,[e1]
cmp al,01h
jz girl  
mov si,0000h 
mov bx,c37
call equs 
mov al,[e1]
cmp al,01h
jz neocom_entr0        
       



enot:
mov al,0Ah
mov ah,0Eh
int 10h
mov al,0Dh
mov ah,0Eh
int 10h
mov bx,nfond
call puts     
mov bx,buff
call puts
mov bx,nfond2
call puts
jmp entr0 

checkcome:
mov bx,false
call puts
ret 


fullhelp:
call nl
mov bx,chelpfull 
mov di,0000h
call puts_mas
jmp entr0   




 

;; COM______________________________________________________________________________________________
checkcom: 
mov al,0Ah
mov ah,0Eh
int 10h
mov al,0Dh
int 10h
mov bx,com1
call puts
mov ah,0
mov al,11100011b
mov dx,00h
int 14h   
jc checkcome
mov bx,true
call puts
mov ah,0Eh
mov al,0Dh
int 10h
mov al,0Ah
int 10h
mov bx,com2
call puts   
mov ah,0
mov al,11100011b
mov dx,01h
int 14h   
;; test
jc checkcome
mov bx,true
call puts
ret  

scroll_down:
mov ah,0Eh
mov al,0Ah
int 10h
mov al,0Dh
int 10h 
mov ah,00h
int 16h
cmp al,']'
jz scroll_down
jmp entr0

reboot:
int 19h
 
                                                                                                    
                          

initialize: 
mov dx,message
mov ax,message1
mov bl,01h
call mes 
call logo
call setcmd  
call screen_first 
call check_memory
call cmos_stats      
call checkdev 
call checkcom  
jmp entr

entr:
mov al,0Ah
mov ah,0Eh
int 10h
mov al,0Dh
mov ah,0Eh
int 10h
p0:                       
mov bx,ready
call puts
mov ah,0
int 16h
call clear_buff_video   
mov dx,0000h
mov ah,02h
mov bh,0
int 10h
jmp entr0

entr0: 
mov al,[f]
cmp al,00h
jz p3 
mov al,0Ah
mov ah,0Eh
int 10h
mov al,0Dh
mov ah,0Eh
int 10h
p3:  
mov [f],01
mov di,0001h 
mov si,0000h
mov bx,line   
call puts
call clear_buff 
mov si,0000h    
entr1:
mov ah,0
int 16h   
cmp al,'['
jz scroll_down 
cmp ah,1Ch
jz com_1
cmp ah,0Eh  
jz del
mov [buff+si],al 
call putsc 
inc di    
inc si  
jmp entr1   


;; H 
eror_r db 'Read::Eror',0
eror_w db 'Write::Eror',0
hh db 0   
hsect db 'Sector :',0
hroll db 'Roll   :',0
hhead db 'Head   :',0
sect  db 0
roll  db 0
head  db 0
;; end;  

;; Putcheck
offsetd db 'Offset from 7C00:00',0     
offsetc db 'Char : ',0
;; end

;; cmd_seting 
hard   db 0
color  db 0
bcolor db 0
;; end 
             
;; load - save
      
an db 0
      
      
;; end     

avaim db 'Available memory of 16-bit addressing : ',0


;; command   
c1 db 'help',0
c2 db 'clear',0
c3 db 'color',0
c4 db 'debug',0
c5 db 'read',0
c6 db 'write',0
c7 db 'echo',0 
c8 db 'hdds',0  
c9 db 'checkcom',0
c10 db 'com1',0
c11 db 'com2',0 
c12 db 'sym',0 
c13 db 'viewb',0  
c14 db 'hclear',0  
c15 db 'reboot',0 
c16 db 'troll',0 
c17 db 'fwrite',0
c18 db 'fread',0
c19 db 'ferase',0    
c20 db 'fread',0 
c21 db 'formate',0
c22 db 'fdir',0  
c23 db 'time',0
c24 db 'test',0
c25 db 'scmos',0
c26 db 'Glados',0
c27 db 'fhelp',0
c28 db 'hexcode',0    
c29 db 'runfile',0 
c30 db 'runsector',0 
c31 db 'fullhelp',0   
c32 db 'version',0
c33 db 'beep',0
c34 db 'halt',0
c35 db 'exit',0  
c36 db 'fcheck',0 
c37 db 'neocom',0
dw 0,0,0
;; end


halts db 'Halt CPU? Y or N',0  

;; command
chelpfull db 'help',0Ah,0Dh,'clear',0Ah,0Dh,'color',0Ah,0Dh,'debug',0Ah,0Dh,'read',0Ah,0Dh,'write',0Ah,0Dh,'echo',0Ah,0Dh,'hdds',0Ah,0Dh,'checkcom',0Ah,0Dh,'com1',0Ah,0Dh,'com2',0Ah,0Dh,'sym',0Ah,0Dh,'viewb',0Ah,0Dh,'hclear',0Ah,0Dh,'troll',0Ah,0Dh,'fclear',0Ah,0Dh,'ferase',0Ah,0Dh,'fread',0Ah,0Dh,'fwrite',0Ah,0Dh,'fdir',0Ah,0Dh,'formate',0Ah,0Dh,'time',0Ah,0Dh,'scmos',0Ah,0Dh,'hexcode',0Ah,0Dh,'runfile',0Ah,0Dh,'runsector',0Ah,0Dh,'version',0
;; end

;; comme
comp dw 0 
comy1 db 'COM Meny',0
comy2 db '1) Read',0
comy3 db '2) Write',0
comy4 db '3) Quit',0   
comr  db 'Reading to quit press escape',0   
comw  db 'Writing to quit press escape',0
db 0
          
;; color
cc3 db 'Color of text:',0
ccr db 'Red   1',0
ccg db 'Green 2',0
ccb db 'Blue  3',0  
ccd db 'White 4',0
cbwd db 'White on Blue  5',0
cbwg db 'Green on Black 6',0
cbdef db 'Default        7',0
cline db 'C>',0
;; end 

;; debug 
degp db 'W>',0
deg  db 'Debug 0.1',0
degl db 'D>',0
cg0   db 'quit',0
cg1   db 'input',0
cg3   db 'reset',0
cg4   db 'start',0
cg5   db 'help',0
cgh   db ': - input - start - quit',0
;; end

;; general 
f      db 0 
com1   db 'Initialize COM0...',0
com2   db 'Initialize COM1...',0
NeoOS  db 'Operating System Neo loading wait...',0
cheak  db 'Cheking status Hard Drive Disk...',0
readh  db 'Cheking read with Hard Drive Disk...',0 
ready  db 'Press any key...',0
true   db 'Ok',0
false  db 'No',0  
line   db '>',0    
nfond  db ' !Command "',0
nfond2 db '" - not found! ',0  
cchelp db ': - clear - color - debug - read - write - echo - fhelp',0  
returned db 'Program returns to kernal.',0
;; end                                                                
bfc db 'Buffer cleared',0

cnum   db 0
db 0
pbuff  db 0
e1     db 0 
g1     db 0
utime  db 0  
db 0   
db 0    
dbuff  db 1024 dup(00)
nop 
nop
jmp program_return
jmp entr0
jmp entr0
buff   db 1024 dup(00)    
cinn   db 0
db 0   
buffer   db 512 dup(00)    
buffer1   db 512 dup(00) 

glados db 'Ym not ready, my creator busy...',0

format_mes db 'Formating',0
damage     db 0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,0Ah,0Dh,'                            System was droped',0Ah,0Dh,'             This message appears because operating system find eror',0Ah,0Dh,0   
sram db '             Not enough RAM',0Ah,0Dh,'             The computer does not support this operating system.',0Ah,0Dh,'             Press any key to reboot...',0
programm db 0,0,0,0,0,0,0,0
db 0  
programm1 db 512 dup(00)    
empy      db 512 dup(00)  
timess    db 'Time is : ',0
filename db 'File name: ',0
filedata db 'Data:',0
file_not_deleted db 'File not deleted',0
file_deleted db 'File was deleted',0
message db 'Operating System Neo',0
message1 db 'Command of OS',0Ah,0Dh,'clear - Clear screen',0Ah,0Dh,'color - Set color of text',0Ah,0Dh,'debug - Mini bites debuger',0Ah,0Dh,'read - Read sector from Hard Drive Disk',0Ah,0Dh,'write - Write sector from Hard Drive Disk',0Ah,0Dh,'hdds - Test Hard Drive Disk',0Ah,0Dh,'checkcom - Test COM ports',0Ah,0Dh,'com 1 (com2) - Work with COM ports',0Ah,0Dh,'viewb - View buffer of read HDD',0Ah,0Dh,'hclear - Clear sector from Hard Drive Disk',0Ah,0Dh,'shutdown - Shutdown computer',0Ah,0Dh,'troll - Test roll on HDD',0Ah,0Dh,'fread - FS read',0Ah,0Dh,'fwrite - FS write',0Ah,0Dh,'ferase - FS delete file',0Ah,0Dh,'fclear - clear buffer file system',0Ah,0Dh,'formate - Formating HDD',0Ah,0Dh,'hexcode - HEX Debuger',0  
duknown  db 'Uknown eror, you must reboot PC to prevent hardware damage',0Ah,0Dh,'Press any key...',0
dfwc     db '             File System wrong function',0Ah,0Dh,'             You can return to command shell, press any key...',0
;; LOGO
a1 db '                                                                                ',0      
a2 db '                            00                0                                 ',0     
a3 db '                            0 0               0                                 ',0     
a4 db '                            0  0              0                                 ',0     
a5 db '                            0   0             0                                 ',0     
a6 db '                            0    0            0                                 ',0     
a7 db '                            0     0           0                                 ',0     
a8 db '                            0      0          0                                 ',0     
a9 db '                            0       0         0                                 ',0     
a10 db '                            0        0        0                                 ',0     
a11 db '                            0         0       0                                 ',0     
a12 db '                            0          0      0                                 ',0     
a13 db '                            0           0     0                                 ',0     
a14 db '                            0            0    0                                 ',0     
a15 db '                            0             0   0  0000  00                       ',0     
a16 db '                            0              0  0  0    0  0                      ',0     
a17 db '                            0               0 0  0000 0  0                      ',0     
a18 db '                            0                00  0    0  0                      ',0     
a19 db '                            0                 0  0000  00                       ',0     
a20 db '                                                                                ',0     
;; END;  
test_segm db 0
cmd_file_name db 256 dup(00)
cmd_file_data db 512 dup(00)
ret
ret