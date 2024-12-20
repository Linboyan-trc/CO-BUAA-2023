ori $1,$0,0xffff
beq $1,$1,label
ori $2,$0,0xffff
ori $3,$0,0xffff
ori $4,$0,0xffff
label:
ori $5,$0,0xffff
beq $1,$2,label2
ori $6,$0,0xffff
label2:
ori $6,$0,0x1234