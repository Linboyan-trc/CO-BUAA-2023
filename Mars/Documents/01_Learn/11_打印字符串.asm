.data
msg: .ascii "Hello,bitch!"

.text
la $a0,msg
li $v0,4
syscall
