ori $1,$0,5
ori $2,$0,8
lui $3,0xf000
ori $3,$3,0x000f
swc $4,$3,$1
swc $5,$3,$2