ori $1,$0,0x00f0
ori $2,$0,0x00ff
jal sum
add $4,$2,$1
beq $3,$4,label

sum:
add $3,$2,$1
jr $ra

label:
ori $5,$0,1
