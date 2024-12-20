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
