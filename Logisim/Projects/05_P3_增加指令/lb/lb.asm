.data
  ary: .space 400
  
.text
ori $1,$0,0x00ff
ori $2,$1,0xff00
sll $2,$2,16
ori $2,$2,0x1234 # ffff1234
sw $2,ary($0)
lw $3,ary($0)
lb $4,ary($0)
ori $8,$0,1
lb $5,ary($8)
ori $8,$0,2
lb $6,ary($8)
ori $8,$0,3
lb $7,ary($8)