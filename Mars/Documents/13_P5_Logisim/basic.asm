# forward
# ori $1,$0,5
# ori $2,$0,10
# add $3,$2,$1
# add $4,$3,$2

# load
# ori $1,$0,5
# sw $1,0($0)
# lw $2,0($0)
# add $3,$2,$1

# JReg
# ori $1,$0,0x3018
# jr $1
# ori $2,$0,0xffff
# ori $2,$0,0xffff
# ori $2,$0,0xffff
# ori $2,$0,0xffff
# ori $3,$0,0x1234

# JReg Load
ori $1,$0,0x3018
sw $1,0($0)
lw $2,0($0)
jr $2
ori $3,$0,0xffff
ori $3,$0,0xffff
ori $4,$0,0x1234


