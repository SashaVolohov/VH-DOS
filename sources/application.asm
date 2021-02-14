macro align value { db value - 1 - ($ + value - 1) mod (value) dup 0 }
HEADS = 1
SPT = 7
begin:
	file "boot\DOSLDR.bin"
	file "utils\command.bin"
	file "utils\cls.bin"
	align 512
	align HEADS*SPT*512
