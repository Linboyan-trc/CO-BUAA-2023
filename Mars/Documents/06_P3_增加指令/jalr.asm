ori $1,$0,0x00f0
ori $2,$0,0x00ff
ori $12,$0,0x3018
jalr $3,$12
add $5,$2,$1
beq $5,$4,label

sum:
add $4,$2,$1
jr $3

label:
ori $6,$0,1