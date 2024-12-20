.data
msg_01: .ascii "a>b\0"
msg_02: .ascii "a<=b\0"

.text
# scanf a and b
li $v0,5
syscall
move $t0,$v0
li $v0,5
syscall
move $t1,$v0
# judge a>b or a<=b
bgt $t1,$t0,place_01
li $v0,4
la $a0,msg_01
syscall
# exit
li $v0,10
syscall

place_01:
li $v0,4
la $a0,msg_02
syscall