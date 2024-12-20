ori $1,$0,0x0001	# $1 <= 1
lui $2,0xffff
ori $2,$2,0xffff	# $2 <= -1
# cal_r
add $8,$1,$2
sub $9,$1,$2


# sw sh sb
lui $3,0x8765
ori $3,$3,0x4321

sw $3,0($0)


# lw lh lb
lw $16,0($0)


