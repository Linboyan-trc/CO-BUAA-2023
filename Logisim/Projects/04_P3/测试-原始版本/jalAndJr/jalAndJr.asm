ori $1,$0,0xffff
lui $2,0xffff
jal sum
beq $0,$0,label


sum:
add $3,$1,$2
jr $ra

label:
lui $4,0x1000