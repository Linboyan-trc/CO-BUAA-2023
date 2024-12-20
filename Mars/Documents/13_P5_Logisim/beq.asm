ori $1,$0,0x0001
ori $2,$0,0x0001
#beq
beq $1,$2,label
lui $8,0x0001
lui $9,0x0001
label:
lui $16,0x0002
#jaljr
jal sum
    lui $8,0x1010
    jal end	
sum:
lui $24,0xffff
jr $ra

end:
    lui $9,0x2020