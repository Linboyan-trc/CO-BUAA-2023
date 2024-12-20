ori $1,$0,0x00f0
ori $2,$0,0x00ff
j sum
add $1,$1,$1

sum:
add $3,$2,$1
