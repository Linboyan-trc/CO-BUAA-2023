.data
  ary: .space 400
  
.text
ori $1,$0,0x00ff
ori $2,$1,0xff00
ori $9,$0,1
sw $2,ary($0)
lw $3,ary($0)
sub $2,$2,$9
loop:
add $2,$2,$9
beq $2,$3,loop