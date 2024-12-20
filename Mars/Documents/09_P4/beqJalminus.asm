ori $1,$0,1
label:
add $2,$2,$1
beq $2,$1,label
label2:
add $3,$3,$1
beq $3,$2,label3
jal label2
label3:
lui $8,0x0001