.data
  ary: .space 400
  
.text
ori $1,$0,0x00ff
ori $2,$1,0xff00
sw $2,ary($0)
lw $3,ary($0)