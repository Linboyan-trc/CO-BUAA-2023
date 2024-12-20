ori $1,$0,0x0001
ori $2,$0,0x0001
bhwal $1,$2,label
lui $3,0x1111
lui $4,0x1111
label:
lui $5,0x1111
bhwal $0,$0,label2
lui $6,0x1111
lui $7,0x1111
label2:
lui $8,0x1111
