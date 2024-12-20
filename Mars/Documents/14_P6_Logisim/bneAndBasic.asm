ori $1,$0,0x0001
ori $2,$0,0x0002
#beq
bne $1,$2,label
lui $8,0x0001
lui $9,0x0001
label:
lui $16,0x0002
#jaljr
jal sum
    lui $8,0x1010
    j end	
sum:
lui $24,0xffff
jr $ra

end:
    lui $9,0x2020

ori $1,$0,0x0001	# $1 <= 1
lui $2,0xffff
ori $2,$2,0xffff	# $2 <= -1
# cal_r
add $8,$1,$2
sub $9,$1,$2
and $10,$1,$2
or $11,$1,$2
slt $12,$1,$2
sltu $13,$1,$2

# cal_i
addi $14,$1,0x0002
andi $15,$1,0x0002

# sw sh sb
#lui $3,0x8765
#ori $3,$3,0x4321

sw $3,0($0)

sh $3,4($0)
sh $3,10($0)

sb $3,12($0)
sb $3,17($0)
sb $3,22($0)
sb $3,27($0)

# lw lh lb
lw $16,0($0)

lh $17,0($0)
lh $18,2($0)

lb $19,0($0)
lb $20,1($0)
lb $21,2($0)
lb $22,3($0)

