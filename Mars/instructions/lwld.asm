lui $1,0x0001
ori $1,$1,0x8
sw $1,0($0)
ori $2,4
sw $2,4($0)
lui $3,0xffff
sw $3,8($0)
lwld $4,0($0)
lwld $5,4($0)
lwld $6,8($0)
