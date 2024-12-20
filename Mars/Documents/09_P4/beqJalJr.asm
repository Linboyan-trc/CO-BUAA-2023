#first
lui $1,0xffff
ori $1,$1,0xffff
#R
ori $2,$0,1
ori $3,$0,2
add $4,$3,$2
sub $5,$3,$2
#I
sw $4,0($0)
sw $5,4($0)
lw $6,0($0)
#lwsw
ori $8,$0,16
sw $8,-4($8)
lw $9,-12($8)
#beq
beq $5,$2,label
lui $12,0x0001
label:
lui $12,0x0002
#jaljr
jal sum
    lui $13,0x1010
    jal end	
sum:
lui $16,0xffff
jr $ra

end:
    lui $14,0x2020