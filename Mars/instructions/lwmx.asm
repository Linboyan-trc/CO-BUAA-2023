ori $1,$0,9
sw $1,0($0)
ori $2,$0,10
lui $2,0xffff
ori $2,$2,0xffff
lwmx $0,0($0)
lwmx $2,0($0)
add $5,$5,$5