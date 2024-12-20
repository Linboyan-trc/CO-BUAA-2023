ori $22,$22,4
ori $23,$23,88
ori $24,$24,12348
sw $24,4($0)
addi $24,$24,104
ori $0,$0,28
ori $1,$1,16
ori $2,$2,20
ori $3,$3,36
ori $4,$4,28
ori $5,$5,28
ori $6,$6,20
ori $7,$7,28
ori $8,$8,28
ori $9,$9,16
addi $10,$10,-32740
addi $11,$11,-32748
addi $12,$12,-32740
ori $13,$13,65508
addi $14,$14,-32736
addi $15,$15,-32764
ori $16,$16,65516
addi $17,$17,-32756
addi $18,$18,-32752
addi $19,$19,-32748
addi $20,$20,-32764
addi $21,$21,-32740
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
start:
addi $31,$0,12320
jr $24
add $24,$24,$23
jal start
label22:
nop
sh $31,6146($25)
divu $31,$20
multu $31,$19
add $31,$17,$31
divu $31,$4
mult $3,$31
multu $2,$31
lui $31,6
nop
mult $31,$12
mthi $31
addi $31,$31,8
add $31,$4,$31
multu $17,$31
nop
slt $31,$2,$31
mthi $31
mult $16,$31
sltu $31,$31,$17
and $31,$31,$10

jal start
nop
addi $31,$31,12
or $31,$31,$7
multu $1,$31
or $31,$31,$0
beq $31,$6,label53
lw $31,4($0)
jr $31
lw $31,4($0)
jr $31
ori $21,$31,0
nop
bne $31,$21,label62
nop
jal label36
mthi $31
jal label35
sub $21,$31,$0
nop
beq $21,$31,label31
multu $31,$2

jal start
label54:
nop
sh $31,6144($25)
lw $31,6144($25)
lb $31,6146($25)
divu $31,$16
mtlo $31
sub $31,$31,$1
andi $31,$31,36
ori $25,$25,0
nop
nop
lb $31,6146($25)
nop
nop
add $25,$25,$22
lw $31,6144($25)
lh $31,6146($25)
slt $31,$31,$5
ori $31,$31,32
nop
lui $31,6

jal start
label12:
nop
or $31,$16,$31
nop
sub $31,$31,$18
nop
lb $31,6144($25)
mflo $31
lui $31,6
lw $25,0($0)
nop
sh $31,6144($25)
addi $31,$31,0
sb $31,6147($25)
mthi $31
sltu $31,$31,$5
nop
addi $31,$31,36
sub $25,$25,$22
lw $31,6144($25)
lw $31,6144($25)
nop

jal start
nop
sb $31,6147($25)
ori $31,$31,12
ori $31,$31,28
nop
mult $31,$5
jr $31
div $31,$3
or $25,$25,$22
sb $31,6146($25)
nop
jal label76
ori $31,$31,32
div $31,$1
jal label32
addi $31,$31,4
jr $31
mtlo $31
multu $31,$2
div $31,$2
mult $3,$31

jal start
label56:
nop
mfhi $31
nop
mflo $31
lui $31,6
nop
nop
mfhi $31
sh $31,6146($25)
nop
lui $31,6
lh $25,0($0)
nop
lw $31,6144($25)
slt $31,$18,$31
mfhi $31
nop
lw $31,6144($25)
lh $31,6146($25)
or $25,$25,$22
sh $31,6144($25)

jal start
label7:
nop
divu $31,$18
mtlo $31
andi $31,$31,0
nop
mflo $31
lh $31,6146($25)
andi $31,$31,16
div $31,$2
lh $25,0($0)
nop
lw $31,6144($25)
mthi $31
andi $25,$25,0
sb $31,6146($25)
lui $25,0
nop
nop
lh $31,6146($25)
addi $31,$31,20
andi $31,$31,16

jal start
label40:
nop
mthi $31
mflo $31
sw $31,6144($25)
mthi $31
multu $3,$31
andi $31,$31,32
sh $31,6144($25)
lui $31,6
mthi $31
lui $31,1
addi $25,$25,4
nop
lh $31,6146($25)
nop
add $31,$7,$31
nop
lui $31,1
mthi $31
mult $31,$17
sb $31,6144($25)

jal start
label81:
nop
lh $31,6146($25)
lw $31,6144($25)
sh $31,6144($25)
sw $31,6144($25)
andi $31,$31,4
andi $31,$31,0
mult $31,$3
sltu $31,$11,$31
or $31,$31,$3
lw $31,6144($25)
addi $31,$31,4
andi $31,$31,28
mfhi $31
mult $8,$31
lui $31,0
slt $31,$31,$0
and $31,$31,$3
lui $31,9
sh $31,6144($25)
mult $31,$2

jal start
label39:
nop
lb $31,6147($25)
addi $31,$31,12
and $31,$31,$4
nop
lh $31,6144($25)
or $31,$31,$5
or $31,$2,$31
add $31,$31,$10
add $31,$31,$5
slt $31,$2,$31
mtlo $31
and $25,$25,$22
nop
lh $31,6144($25)
lw $31,6144($25)
addi $31,$31,28
lui $31,0
nop
addi $31,$31,4
nop

jal start
label16:
nop
mthi $31
sltu $31,$31,$16
sw $31,6144($25)
lui $31,3
sb $31,6145($25)
nop
mult $15,$31
mflo $31
multu $31,$19
sltu $31,$14,$31
mtlo $31
lui $31,6
lw $31,6144($25)
lui $31,7
ori $31,$31,16
ori $31,$31,20
lh $25,0($0)
lh $31,6146($25)
lw $31,6144($25)
mfhi $31

jal start
label62:
nop
lui $31,1
add $31,$31,$11
and $31,$1,$31
nop
andi $31,$31,32
nop
addi $31,$31,20
lui $31,9
nop
nop
divu $31,$1
mthi $31
nop
and $25,$25,$22
lw $31,6144($25)
ori $25,$25,0
nop
sw $31,6144($25)
mtlo $31
sltu $31,$13,$31

jal start
nop
addi $31,$31,32
nop
ori $21,$31,0
nop
beq $21,$31,label83
mtlo $31
andi $25,$25,12
nop
sb $31,6145($25)
nop
andi $21,$31,65535
nop
beq $31,$21,label76
or $31,$31,$8
multu $31,$6
nop
sw $31,6144($25)
addi $25,$25,4
nop
sb $31,6145($25)

jal start
label20:
nop
lui $31,8
mfhi $31
sub $31,$9,$31
lh $31,6144($25)
lh $31,6146($25)
mfhi $31
multu $10,$31
and $25,$25,$22
nop
sw $31,6144($25)
nop
andi $31,$31,20
add $31,$11,$31
lb $31,6147($25)
andi $31,$31,8
lh $25,0($0)
lh $31,6146($25)
multu $5,$31
and $31,$12,$31
multu $11,$31

jal start
label18:
nop
nop
div $31,$18
nop
divu $31,$15
lw $31,6144($25)
andi $25,$25,12
lh $31,6146($25)
lui $25,0
lw $31,6144($25)
lw $25,0($0)
nop
sw $31,6144($25)
mthi $31
lui $31,4
mflo $31
add $25,$25,$22
mthi $25
mfhi $25
lh $31,6146($25)
addi $31,$31,36

jal start
label94:
nop
lb $31,6147($25)
ori $31,$31,16
ori $31,$31,24
sb $31,6146($25)
lui $25,0
nop
sh $31,6146($25)
lh $31,6144($25)
mfhi $31
mult $6,$31
nop
nop
lui $31,8
nop
andi $31,$31,8
lh $31,6146($25)
mfhi $31
nop
nop
sb $31,6147($25)

jal start
nop
nop
div $31,$5
mthi $31
div $31,$5
addi $31,$31,0
ori $25,$25,4
nop
sh $31,6144($25)
jal label69
ori $31,$31,4
jal label1
ori $31,$31,12
jal label66
nop
jal label79
nop
sub $21,$31,$0
nop
beq $21,$31,label42
ori $31,$31,36

jal start
nop
mtlo $31
or $31,$31,$1
divu $31,$4
mthi $31
lh $25,0($0)
nop
sw $31,6144($25)
sh $31,6144($25)
beq $31,$2,label86
or $31,$31,$4
jal label72
divu $31,$3
jal label28
or $31,$31,$1
or $31,$4,$31
jal label72
or $31,$31,$5
mtlo $31
mtlo $31
sh $31,6146($25)

jal start
label72:
nop
mult $6,$31
mult $11,$31
mfhi $31
sh $31,6144($25)
mflo $31
sw $31,6144($25)
multu $3,$31
lui $31,5
addi $31,$31,20
lui $31,8
mult $17,$31
nop
multu $17,$31
mthi $31
mult $31,$1
and $31,$31,$13
or $31,$5,$31
div $31,$13
or $31,$31,$12
sub $31,$31,$3

jal start
label5:
nop
add $31,$16,$31
sw $31,6144($25)
nop
slt $31,$31,$18
mult $31,$9
lui $31,5
nop
lui $31,6
nop
or $31,$31,$13
slt $31,$12,$31
multu $5,$31
mfhi $31
lh $25,0($0)
nop
lb $31,6144($25)
nop
divu $31,$13
mtlo $31
lb $31,6144($25)

jal start
nop
lw $31,6144($25)
multu $31,$16
div $31,$4
nop
ori $21,$31,0
nop
bne $31,$21,label59
mfhi $31
sw $31,6144($25)
or $21,$31,$0
nop
beq $31,$21,label7
mtlo $31
jal label50
or $25,$25,$22
nop
nop
lh $31,6146($25)
addi $31,$31,8
addi $31,$31,24

jal start
label47:
nop
addi $31,$31,0
sh $31,6146($25)
sw $31,6144($25)
mflo $31
lh $31,6146($25)
andi $31,$31,24
sb $31,6145($25)
nop
ori $25,$25,12
mthi $25
mfhi $25
lb $31,6144($25)
mflo $31
and $31,$10,$31
lh $31,6146($25)
lb $25,0($0)
lh $31,6146($25)
nop
mtlo $31
lh $31,6146($25)

jal start
nop
mult $3,$31
add $31,$31,$6
andi $31,$31,0
bne $31,$8,label73
lh $25,0($0)
lb $31,6145($25)
jal label70
mthi $31
addi $31,$31,20
bne $31,$0,label30
sb $31,6144($25)
nop
sub $21,$31,$0
bne $21,$31,label26
lh $25,0($0)
nop
sb $31,6144($25)
beq $31,$4,label55
sw $31,6144($25)
addi $31,$31,0

jal start
label48:
nop
mthi $31
sw $31,6144($25)
sb $31,6145($25)
nop
mthi $31
lb $31,6147($25)
lb $31,6145($25)
mflo $31
andi $31,$31,0
lb $31,6147($25)
mthi $31
ori $31,$31,8
mult $31,$17
nop
andi $31,$31,16
mflo $31
addi $31,$31,32
andi $25,$25,8
nop
sb $31,6147($25)

jal start
nop
div $31,$9
mult $6,$31
addi $31,$31,36
jr $31
sub $21,$31,$0
nop
beq $31,$21,label30
mtlo $31
divu $31,$8
jal label23
divu $31,$4
jr $31
divu $31,$3
lh $31,4($0)
nop
jr $31
multu $31,$2
jal label47
divu $31,$7
mthi $31

jal start
nop
mult $6,$31
nop
divu $31,$2
jr $31
ori $31,$31,20
beq $31,$0,label73
nop
add $21,$31,$0
nop
beq $31,$21,label2
nop
jal label54
nop
ori $31,$31,32
or $21,$31,$0
nop
beq $21,$31,label94
nop
jal label37
mthi $31

jal start
label55:
nop
divu $31,$10
ori $31,$31,32
lh $31,6144($25)
mult $31,$19
ori $31,$31,12
and $31,$1,$31
sub $31,$31,$0
lui $31,4
and $25,$25,$22
nop
lb $31,6145($25)
lh $31,6146($25)
mthi $31
lh $31,6144($25)
andi $25,$25,12
nop
lb $31,6146($25)
nop
or $31,$31,$16
sltu $31,$16,$31

jal start
nop
div $31,$9
mthi $31
sw $31,6144($25)
multu $31,$1
or $31,$31,$1
nop
beq $31,$5,label74
addi $31,$31,12
jal label30
addi $31,$31,16
multu $31,$6
sub $25,$25,$22
nop
sw $31,6144($25)
jal label58
mthi $31
ori $31,$31,8
mfhi $31
jr $31
nop

jal start
nop
nop
sh $31,6146($25)
andi $31,$31,32
lui $31,4
andi $21,$31,65535
nop
beq $21,$31,label59
lui $31,0
or $21,$31,$0
nop
beq $31,$21,label25
or $31,$19,$31
nop
lui $31,4
sltu $31,$18,$31
lh $31,6146($25)
mult $14,$31
addi $25,$25,4
nop
lw $31,6144($25)

jal start
label14:
nop
mflo $31
mfhi $31
lb $31,6144($25)
mtlo $31
and $31,$31,$5
ori $25,$25,4
mthi $25
mfhi $25
lh $31,6146($25)
lb $25,0($0)
lb $31,6147($25)
divu $31,$16
lh $31,6146($25)
sub $25,$25,$22
sb $31,6147($25)
sb $31,6145($25)
nop
div $31,$17
andi $31,$31,16
mfhi $31

jal start
label69:
nop
andi $31,$31,36
sb $31,6147($25)
lb $31,6145($25)
ori $31,$31,32
lui $31,1
nop
lui $31,2
sub $25,$25,$22
lw $31,6144($25)
andi $31,$31,20
andi $31,$31,24
andi $25,$25,4
lb $31,6146($25)
sub $31,$31,$12
nop
andi $31,$31,4
divu $31,$10
sh $31,6144($25)
andi $31,$31,0
divu $31,$18

jal start
label89:
nop
lb $31,6144($25)
or $31,$31,$4
mfhi $31
sb $31,6145($25)
lui $31,7
divu $31,$7
divu $31,$13
or $25,$25,$22
sw $31,6144($25)
lh $25,0($0)
nop
lw $31,6144($25)
lui $31,5
nop
multu $31,$2
multu $5,$31
and $25,$25,$22
nop
sw $31,6144($25)
divu $31,$11

jal start
nop
div $31,$3
add $21,$31,$0
nop
beq $21,$31,label28
ori $31,$31,28
beq $31,$3,label81
or $31,$31,$5
ori $31,$31,12
jal label7
nop
ori $31,$31,8
mthi $31
addi $31,$31,4
mfhi $31
nop
nop
jr $31
divu $31,$6
nop
mtlo $31

jal label1011
label1011:
nop
nop
lb $31,-12287($31)
jal start
nop
sub $31,$31,$7
ori $31,$31,8
sh $31,6146($25)
mthi $31
mfhi $21
nop
nop
nop
bne $21,$31,label91
add $31,$5,$31
mtlo $31
or $31,$7,$31
and $31,$31,$8
beq $31,$12,label29
div $31,$4
sh $31,6144($25)

jal start
nop
addi $31,$31,8
nop
div $31,$8
bne $31,$8,label95
lw $25,0($0)
nop
sw $31,6144($25)
jr $31
multu $8,$31
bne $31,$5,label28
or $31,$31,$6
beq $31,$3,label53
mult $31,$8
addi $31,$31,36
mthi $31
ori $31,$31,8
mfhi $31
nop
jr $31
mthi $31

jal start
nop
mthi $31
or $31,$3,$31
nop
jal label42
mthi $31
lw $31,4($0)
mfhi $31
nop
nop
jr $31
div $31,$8
sb $31,6144($25)
sb $31,6145($25)
addi $31,$31,32
beq $31,$5,label19
nop
addi $31,$31,36
sub $21,$31,$0
beq $31,$21,label69
mtlo $31

jal start
label68:
nop
nop
sh $31,6146($25)
mthi $31
addi $31,$31,4
ori $31,$31,20
div $31,$6
mtlo $31
divu $31,$5
addi $31,$31,20
mthi $31
addi $31,$31,8
mfhi $31
divu $31,$5
mtlo $31
mult $15,$31
nop
lh $31,6146($25)
lw $31,6144($25)
lui $31,0
lui $31,6

jal start
nop
div $31,$2
addi $31,$31,0
mult $8,$31
nop
jal label29
or $31,$8,$31
mtlo $31
jal label76
nop
jr $31
nop
jr $31
divu $31,$7
beq $31,$8,label87
mult $8,$31
mult $31,$8
mthi $31
jal label85
sb $31,6144($25)
addi $31,$31,0

jal start
label67:
nop
sb $31,6144($25)
divu $31,$14
multu $3,$31
andi $31,$31,4
and $31,$31,$13
lh $25,0($0)
lw $31,6144($25)
andi $25,$25,8
nop
lw $31,6144($25)
or $31,$19,$31
mflo $31
or $25,$25,$22
lw $31,6144($25)
nop
multu $18,$31
ori $31,$31,4
andi $25,$25,4
nop
sw $31,6144($25)

jal start
nop
lb $31,6144($25)
addi $31,$31,12
slt $31,$2,$31
sw $31,6144($25)
mthi $31
jal label46
div $31,$15
mthi $31
nop
bne $31,$8,label19
mult $31,$15
div $31,$10
addi $31,$31,16
jal label20
lui $31,2
jal label91
mtlo $31
bne $31,$16,label56
div $31,$13
lw $31,6144($25)

jal start
label1:
nop
sltu $31,$18,$31
divu $31,$16
addi $31,$31,32
and $31,$31,$1
lw $31,6144($25)
slt $31,$0,$31
lw $31,6144($25)
add $31,$16,$31
divu $31,$3
sb $31,6145($25)
lui $25,0
lb $31,6144($25)
add $31,$31,$16
and $31,$31,$17
divu $31,$17
sw $31,6144($25)
nop
sltu $31,$31,$5
sltu $31,$31,$19
lui $31,1

jal start
label52:
nop
lui $31,4
slt $31,$15,$31
nop
sltu $31,$31,$11
add $31,$31,$2
sw $31,6144($25)
andi $31,$31,8
sltu $31,$7,$31
lw $31,6144($25)
ori $31,$31,12
mfhi $31
nop
ori $31,$31,32
mflo $31
divu $31,$9
mfhi $31
mfhi $31
lui $31,7
or $31,$31,$16
andi $31,$31,32

jal start
label46:
nop
lw $31,6144($25)
lh $31,6146($25)
mflo $31
ori $31,$31,36
andi $31,$31,12
addi $25,$25,4
sb $31,6146($25)
lh $31,6146($25)
lb $31,6146($25)
sub $31,$31,$16
nop
addi $31,$31,20
lw $31,6144($25)
mult $31,$19
nop
nop
mtlo $31
nop
div $31,$7
nop

jal start
label35:
nop
lh $31,6146($25)
nop
divu $31,$10
mflo $31
sw $31,6144($25)
andi $31,$31,4
nop
ori $31,$31,24
div $31,$19
divu $31,$2
nop
and $25,$25,$22
nop
sb $31,6145($25)
addi $31,$31,32
lui $31,7
mflo $31
multu $31,$18
addi $31,$31,28
nop

jal start
nop
mthi $31
mult $0,$31
sw $31,6144($25)
jr $31
mult $3,$31
andi $21,$31,65535
beq $21,$31,label7
or $31,$31,$22
nop
nop
jr $31
sb $31,6144($25)
jal label54
multu $5,$31
bne $31,$6,label49
mthi $31
mtlo $31
divu $31,$3
mult $2,$31
divu $31,$1

jal start
label73:
nop
nop
sb $31,6144($25)
nop
andi $31,$31,28
lui $31,5
lh $31,6144($25)
lb $25,0($0)
nop
nop
lb $31,6146($25)
slt $31,$15,$31
mfhi $31
lh $25,0($0)
nop
nop
lb $31,6147($25)
multu $31,$10
div $31,$19
sw $31,6144($25)
andi $31,$31,24

jal start
label91:
nop
div $31,$5
add $31,$31,$7
and $31,$2,$31
mthi $31
divu $31,$7
sh $31,6144($25)
nop
add $31,$31,$0
andi $31,$31,36
andi $31,$31,0
sb $31,6147($25)
lui $31,9
addi $31,$31,0
lh $31,6144($25)
add $31,$31,$16
mflo $31
nop
sw $31,6144($25)
addi $31,$31,36
mthi $31

jal start
label21:
nop
or $31,$31,$4
mthi $31
div $31,$6
nop
mflo $31
mult $31,$8
mult $31,$19
lui $31,5
andi $31,$31,4
sltu $31,$0,$31
and $31,$31,$14
mflo $31
ori $31,$31,28
ori $25,$25,4
lh $31,6144($25)
mthi $31
add $31,$31,$14
lh $31,6146($25)
add $31,$31,$14
mfhi $31

jal start
nop
multu $7,$31
mthi $31
sw $31,6144($25)
mult $1,$31
addi $21,$31,0
nop
nop
beq $31,$21,label98
mthi $31
div $31,$7
add $25,$25,$22
sw $31,6144($25)
mthi $31
sb $31,6147($25)
jal label51
addi $31,$31,16
or $25,$25,$22
nop
sw $31,6144($25)
nop

jal start
nop
andi $31,$31,24
lw $31,6144($25)
addi $31,$31,4
lui $31,1
mfhi $31
mult $19,$31
multu $31,$19
and $31,$31,$7
jal label9
nop
slt $31,$8,$31
or $25,$25,$22
nop
lw $31,6144($25)
or $21,$31,$0
nop
nop
nop
bne $31,$21,label75
mult $15,$31

jal start
nop
sb $31,6145($25)
and $31,$31,$13
div $31,$8
div $31,$7
or $25,$25,$22
lh $31,6144($25)
sub $25,$25,$22
lb $31,6144($25)
add $21,$31,$0
nop
nop
nop
beq $21,$31,label72
sub $31,$31,$13
beq $31,$8,label9
mfhi $31
nop
bne $31,$17,label55
mflo $31
or $31,$31,$7

jal start
nop
mthi $31
div $31,$18
add $21,$31,$0
nop
nop
bne $21,$31,label84
addi $31,$31,12
lb $31,6144($25)
ori $31,$31,8
nop
andi $25,$25,4
lw $31,6144($25)
jal label2
divu $31,$14
lui $31,4
sub $25,$25,$22
nop
sh $31,6146($25)
mthi $31
mtlo $31

jal start
label66:
nop
addi $31,$31,32
mult $31,$1
and $31,$14,$31
addi $25,$25,4
nop
lw $31,6144($25)
multu $12,$31
nop
lui $31,9
or $25,$25,$22
sh $31,6146($25)
addi $31,$31,12
sub $25,$25,$22
nop
sw $31,6144($25)
divu $31,$16
nop
addi $31,$31,20
add $31,$31,$18
lb $31,6145($25)

jal start
label50:
nop
lb $31,6144($25)
lui $31,4
mtlo $31
lb $31,6144($25)
sub $31,$17,$31
nop
add $25,$25,$22
nop
lw $31,6144($25)
lb $31,6145($25)
lui $31,1
slt $31,$31,$1
ori $25,$25,8
sb $31,6145($25)
addi $31,$31,32
slt $31,$13,$31
lh $31,6146($25)
andi $31,$31,28
or $31,$31,$4
lw $31,6144($25)

jal start
nop
addi $31,$31,36
nop
multu $9,$31
lh $31,6144($25)
mult $31,$8
bne $31,$6,label12
lw $25,0($0)
nop
lw $31,6144($25)
lh $31,6146($25)
sltu $31,$31,$9
mthi $31
addi $25,$25,4
lw $31,6144($25)
mfhi $31
andi $31,$31,24
jal label5
ori $25,$25,0
nop
lh $31,6144($25)

jal label1012
label1012:
nop
lw $31,-12288($31)
jal start
nop
andi $31,$31,4
div $31,$11
multu $31,$19
andi $31,$31,28
sltu $31,$31,$9
jal label18
or $31,$31,$3
jal label3
addi $31,$31,24
jal label87
or $31,$31,$2
beq $31,$17,label94
andi $21,$31,65535
nop
beq $31,$21,label7
mthi $31
mthi $31

jal start
nop
add $31,$31,$7
nop
mthi $31
jal label38
or $31,$31,$22
nop
jr $31
multu $7,$31
lh $25,0($0)
nop
sb $31,6147($25)
jal label85
or $31,$31,$22
nop
jr $31
lw $31,4($0)
jr $31
mthi $31
jal label98
nop

jal start
label51:
nop
div $31,$12
ori $31,$31,12
mfhi $31
nop
lb $31,6145($25)
lui $31,5
mtlo $31
andi $31,$31,24
mflo $31
lui $31,2
div $31,$10
mfhi $31
lb $31,6146($25)
andi $31,$31,12
mfhi $31
addi $25,$25,4
sw $31,6144($25)
slt $31,$31,$13
or $31,$3,$31
or $31,$14,$31

jal start
label74:
nop
or $31,$8,$31
lui $31,2
lw $31,6144($25)
sub $31,$17,$31
sub $25,$25,$22
nop
lw $31,6144($25)
mthi $31
lui $31,9
mfhi $31
div $31,$7
andi $31,$31,4
lw $31,6144($25)
slt $31,$31,$3
lh $25,0($0)
lh $31,6146($25)
div $31,$2
mthi $31
lh $31,6146($25)
divu $31,$11

jal start
label32:
nop
lb $31,6144($25)
add $31,$31,$3
andi $31,$31,12
addi $31,$31,28
nop
sb $31,6145($25)
sw $31,6144($25)
div $31,$14
multu $8,$31
add $31,$31,$10
andi $31,$31,0
div $31,$19
sub $25,$25,$22
sw $31,6144($25)
or $31,$31,$1
sltu $31,$31,$10
nop
sb $31,6144($25)
nop
lui $31,6

jal start
label42:
nop
addi $31,$31,16
mthi $31
lh $31,6146($25)
nop
mthi $31
and $31,$15,$31
lui $31,4
lw $25,0($0)
nop
lw $31,6144($25)
lh $31,6144($25)
addi $31,$31,36
mult $31,$0
mfhi $31
mult $13,$31
multu $1,$31
or $31,$31,$6
mfhi $31
lui $31,1
mflo $31

jal start
label83:
nop
lw $31,6144($25)
slt $31,$31,$11
div $31,$18
nop
mthi $31
add $31,$1,$31
lh $25,0($0)
lw $31,6144($25)
lh $31,6144($25)
addi $31,$31,0
div $31,$18
andi $31,$31,4
lw $31,6144($25)
mult $31,$15
nop
nop
lui $31,8
mthi $31
sltu $31,$0,$31
andi $31,$31,12

jal start
nop
mtlo $31
sh $31,6144($25)
nop
jal label78
divu $31,$2
lh $25,0($0)
sw $31,6144($25)
jal label80
mthi $31
addi $31,$31,4
mfhi $31
nop
jr $31
addi $31,$31,4
multu $31,$7
jal label65
mult $8,$31
jal label94
ori $31,$31,0
nop

jal start
label13:
nop
ori $31,$31,16
nop
divu $31,$8
mfhi $31
andi $31,$31,4
andi $31,$31,0
nop
mult $17,$31
mtlo $31
add $31,$14,$31
andi $31,$31,36
lui $31,7
and $31,$31,$4
addi $25,$25,4
lb $31,6145($25)
or $31,$31,$18
andi $31,$31,24
sw $31,6144($25)
add $25,$25,$22
sb $31,6145($25)

jal start
nop
div $31,$3
multu $5,$31
divu $31,$1
jr $31
div $31,$9
ori $31,$31,20
jal label53
divu $31,$9
sb $31,6147($25)
jal label89
mthi $31
jal label86
ori $31,$31,0
jr $31
nop
jal label78
addi $31,$31,4
jr $31
multu $2,$31
mthi $31

jal start
label99:
nop
lw $31,6144($25)
lh $31,6146($25)
nop
mult $13,$31
sw $31,6144($25)
lw $31,6144($25)
multu $14,$31
nop
nop
lh $31,6144($25)
div $31,$9
slt $31,$2,$31
sub $31,$13,$31
mthi $31
sltu $31,$31,$2
lh $25,0($0)
nop
lw $31,6144($25)
sub $31,$31,$5
mtlo $31

jal start
label63:
nop
nop
div $31,$11
lw $31,6144($25)
andi $31,$31,20
andi $25,$25,8
nop
sh $31,6146($25)
sb $31,6144($25)
lw $25,0($0)
lw $31,6144($25)
mult $31,$11
nop
mthi $31
lui $31,0
lui $31,2
nop
nop
or $25,$25,$22
lw $31,6144($25)
mthi $31

jal start
nop
multu $19,$31
add $31,$31,$8
addi $31,$31,0
bne $31,$19,label50
lw $31,6144($25)
jal label93
mfhi $31
multu $10,$31
sub $31,$16,$31
beq $31,$14,label30
nop
nop
lui $31,7
mult $31,$18
multu $3,$31
divu $31,$14
mult $6,$31
jal label64
mthi $31
mfhi $31

jal label1013
nop
label1014:
beq $31,$31,label60
nop
nop
label1013:
jal label1014
nop
jal start
label31:
nop
sh $31,6146($25)
mfhi $31
sb $31,6146($25)
mflo $31
mtlo $31
addi $31,$31,20
lb $25,0($0)
nop
sb $31,6147($25)
divu $31,$1
andi $31,$31,16
sltu $31,$31,$0
nop

jal start
nop
nop
divu $31,$9
ori $31,$31,0
div $31,$16
lw $31,6144($25)
beq $31,$3,label29
mthi $31
lui $21,2
lui $31,4
nop
nop
bne $31,$21,label84
mult $16,$31
nop
nop
jal label21
andi $25,$25,0
lw $31,6144($25)
and $31,$31,$12
lb $31,6147($25)

jal start
nop
mult $2,$31
nop
nop
ori $31,$31,8
jal label99
mult $4,$31
andi $25,$25,12
sb $31,6145($25)
bne $31,$1,label47
ori $31,$31,28
div $31,$5
or $31,$6,$31
sw $31,6144($25)
sb $31,6144($25)
addi $21,$31,0
nop
nop
bne $21,$31,label31
mult $31,$2
ori $31,$31,32

jal start
label79:
nop
andi $31,$31,16
nop
sh $31,6144($25)
addi $31,$31,4
andi $25,$25,8
nop
lh $31,6144($25)
nop
lh $31,6144($25)
mthi $31
mthi $31
slt $31,$31,$11
nop
mult $7,$31
mult $31,$7
or $31,$12,$31
multu $31,$4
andi $31,$31,4
sw $31,6144($25)
nop

jal start
nop
lh $31,6144($25)
mtlo $31
mfhi $31
lw $31,6144($25)
mtlo $31
andi $31,$31,0
or $21,$31,$0
nop
bne $21,$31,label41
multu $31,$15
mthi $31
jal label34
mthi $31
jal label31
sb $31,6147($25)
mthi $31
sh $31,6144($25)
bne $31,$7,label92
mthi $31
mthi $31

jal start
nop
divu $31,$17
div $31,$20
lw $31,6144($25)
bne $31,$14,label93
mtlo $31
beq $31,$13,label37
mult $31,$0
multu $31,$13
or $21,$31,$0
nop
nop
bne $31,$21,label52
or $31,$7,$31
add $25,$25,$22
lw $31,6144($25)
ori $25,$25,4
nop
sw $31,6144($25)
addi $31,$31,4
divu $31,$11

jal start
label80:
nop
divu $31,$12
addi $31,$31,28
mult $16,$31
andi $31,$31,4
lw $31,6144($25)
multu $16,$31
sw $31,6144($25)
mfhi $31
nop
andi $31,$31,32
addi $31,$31,4
sltu $31,$31,$3
sub $31,$7,$31
sub $31,$17,$31
lh $31,6146($25)
ori $25,$25,4
nop
lh $31,6146($25)
mflo $31
mthi $31

jal label1015
label1015:
nop
nop
lw $31,-12288($31)
jal start
label93:
nop
lb $31,6145($25)
lui $31,2
mflo $31
lui $31,7
slt $31,$11,$31
lb $31,6145($25)
mtlo $31
or $25,$25,$22
sh $31,6146($25)
sub $31,$31,$12
mult $31,$18
add $31,$14,$31
mtlo $31
and $31,$31,$9
nop
mthi $31

jal start
label10:
nop
div $31,$16
mfhi $31
sub $31,$31,$9
sh $31,6146($25)
andi $31,$31,0
nop
sltu $31,$8,$31
andi $31,$31,16
addi $31,$31,36
mtlo $31
mfhi $31
andi $31,$31,12
sh $31,6146($25)
lui $31,3
mfhi $31
nop
multu $9,$31
ori $25,$25,8
nop
lh $31,6146($25)

jal start
label6:
nop
lh $31,6146($25)
add $31,$10,$31
andi $31,$31,4
and $31,$31,$14
nop
lui $31,7
add $25,$25,$22
nop
sb $31,6144($25)
lb $31,6145($25)
divu $31,$14
andi $25,$25,8
mthi $25
mfhi $25
lh $31,6144($25)
lui $31,8
or $31,$3,$31
or $31,$31,$5
andi $31,$31,32
addi $31,$31,32

jal start
label27:
nop
nop
lw $31,6144($25)
multu $5,$31
and $31,$31,$17
divu $31,$5
andi $31,$31,16
mflo $31
mflo $31
mthi $31
lui $31,0
multu $31,$17
sw $31,6144($25)
sltu $31,$31,$11
nop
lui $25,0
nop
lw $31,6144($25)
add $31,$6,$31
lui $31,3
ori $31,$31,32

jal start
nop
nop
addi $31,$31,24
mtlo $31
beq $31,$5,label43
nop
jal label44
mtlo $31
nop
jal label8
ori $25,$25,12
nop
sw $31,6144($25)
or $31,$31,$22
nop
jr $31
addi $21,$31,0
nop
beq $31,$21,label45
mtlo $31
add $31,$31,$2

jal start
label15:
nop
and $31,$31,$3
slt $31,$16,$31
mult $8,$31
lw $31,6144($25)
sub $31,$31,$2
multu $5,$31
sub $31,$4,$31
multu $2,$31
and $25,$25,$22
lw $31,6144($25)
lui $25,0
mthi $25
mfhi $25
lh $31,6146($25)
lh $25,0($0)
sw $31,6144($25)
sh $31,6146($25)
nop
nop
lh $31,6144($25)

jal start
label25:
nop
mflo $31
mthi $31
mfhi $31
sltu $31,$18,$31
lw $31,6144($25)
mult $31,$10
lw $31,6144($25)
sub $31,$8,$31
mtlo $31
lb $25,0($0)
nop
lw $31,6144($25)
mfhi $31
nop
mflo $31
add $31,$5,$31
ori $25,$25,4
sw $31,6144($25)
ori $31,$31,24
nop

jal label1016
label1016:
nop
nop
lb $31,-12288($31)
jal start
label45:
nop
sb $31,6147($25)
mfhi $31
lui $31,8
lui $31,0
mflo $31
ori $25,$25,12
sb $31,6145($25)
or $31,$31,$15
sw $31,6144($25)
andi $31,$31,4
addi $31,$31,8
divu $31,$15
add $31,$31,$8
mthi $31
or $31,$11,$31
nop

jal start
label85:
nop
or $31,$5,$31
nop
mfhi $31
or $31,$31,$18
multu $6,$31
or $25,$25,$22
nop
sh $31,6144($25)
ori $31,$31,36
div $31,$13
lh $31,6146($25)
slt $31,$17,$31
divu $31,$12
nop
slt $31,$15,$31
nop
and $31,$31,$15
sh $31,6144($25)
addi $25,$25,4
lb $31,6145($25)

jal start
label95:
nop
add $31,$31,$4
mthi $31
mult $12,$31
mult $16,$31
or $25,$25,$22
nop
lb $31,6146($25)
lb $31,6146($25)
lh $31,6144($25)
lui $31,8
nop
andi $31,$31,20
mthi $31
sub $31,$31,$4
lw $31,6144($25)
mtlo $31
multu $31,$19
add $31,$9,$31
mult $31,$6
lb $31,6146($25)

jal start
nop
mtlo $31
lw $31,6144($25)
mthi $31
lb $31,6145($25)
bne $31,$16,label57
and $25,$25,$22
lb $31,6144($25)
addi $31,$31,12
bne $31,$12,label52
andi $31,$31,4
jal label23
addi $31,$31,32
mflo $31
mtlo $31
mflo $21
nop
nop
bne $21,$31,label85
ori $31,$31,4
mflo $31

jal start
label36:
nop
add $31,$31,$14
nop
sb $31,6145($25)
andi $31,$31,24
lb $25,0($0)
sh $31,6146($25)
or $31,$11,$31
ori $31,$31,4
and $31,$16,$31
div $31,$17
mflo $31
nop
lb $31,6145($25)
nop
mult $7,$31
lui $31,8
mfhi $31
sub $31,$31,$16
multu $2,$31
multu $11,$31

jal start
nop
nop
nop
nop
or $31,$0,$31
divu $31,$8
jr $31
lh $31,4($0)
nop
jr $31
ori $31,$31,24
nop
multu $6,$31
sw $31,6144($25)
jal label33
add $31,$4,$31
lh $25,0($0)
nop
sb $31,6147($25)
mthi $31
nop

jal start
label4:
nop
multu $15,$31
sltu $31,$12,$31
multu $1,$31
multu $2,$31
div $31,$6
mflo $31
nop
andi $31,$31,28
mflo $31
lui $31,6
and $25,$25,$22
nop
nop
lh $31,6146($25)
nop
andi $31,$31,12
lh $31,6144($25)
sltu $31,$31,$12
sltu $31,$7,$31
mflo $31

jal start
label3:
nop
slt $31,$31,$8
lb $31,6145($25)
lui $31,2
slt $31,$19,$31
mflo $31
multu $31,$10
mflo $31
lui $31,0
mflo $31
slt $31,$31,$1
lw $31,6144($25)
div $31,$6
and $31,$31,$16
lb $31,6146($25)
sb $31,6147($25)
nop
mult $31,$13
mthi $31
sub $31,$18,$31
div $31,$18

jal start
nop
mfhi $31
mflo $31
lh $31,6146($25)
mflo $31
or $21,$31,$0
nop
nop
nop
beq $31,$21,label79
lui $31,2
sb $31,6146($25)
slt $31,$31,$16
lui $31,6
mtlo $31
mflo $21
nop
nop
nop
beq $31,$21,label4
nop

jal start
label9:
nop
slt $31,$31,$16
lui $31,5
nop
mult $31,$19
nop
addi $25,$25,4
nop
sh $31,6144($25)
andi $31,$31,24
addi $25,$25,4
nop
lb $31,6146($25)
and $31,$31,$14
mtlo $31
add $31,$31,$12
mthi $31
sub $25,$25,$22
nop
nop
lb $31,6144($25)

jal start
label64:
nop
lh $31,6144($25)
lw $31,6144($25)
andi $31,$31,12
divu $31,$4
ori $31,$31,20
divu $31,$15
sub $31,$1,$31
nop
mtlo $31
lb $25,0($0)
lh $31,6144($25)
nop
lui $25,0
lw $31,6144($25)
or $31,$31,$5
lb $31,6146($25)
addi $25,$25,4
sh $31,6144($25)
mthi $31
divu $31,$6

jal start
label88:
nop
slt $31,$31,$6
divu $31,$4
lb $31,6144($25)
mfhi $31
sltu $31,$11,$31
addi $31,$31,36
addi $25,$25,4
nop
nop
lb $31,6144($25)
andi $31,$31,28
div $31,$13
mflo $31
andi $31,$31,12
divu $31,$10
lui $31,6
mtlo $31
slt $31,$1,$31
lui $31,4
lw $31,6144($25)

jal start
label2:
nop
and $31,$31,$17
lb $31,6144($25)
andi $31,$31,20
and $31,$31,$17
lb $25,0($0)
nop
lw $31,6144($25)
andi $31,$31,8
slt $31,$9,$31
lb $31,6146($25)
mtlo $31
or $25,$25,$22
lh $31,6144($25)
divu $31,$13
or $31,$18,$31
lw $31,6144($25)
ori $31,$31,4
mult $31,$2
mthi $31
div $31,$9

jal start
nop
sh $31,6144($25)
mfhi $31
div $31,$14
lh $31,6146($25)
andi $31,$31,12
bne $31,$5,label49
mflo $31
lb $31,6146($25)
nop
lui $31,4
jal label26
div $31,$2
lh $31,6144($25)
mtlo $31
mthi $31
jal label38
sb $31,6145($25)
lui $31,6
andi $31,$31,8
and $31,$31,$1

jal start
label90:
nop
ori $31,$31,28
ori $31,$31,24
div $31,$14
mflo $31
mfhi $31
sltu $31,$2,$31
lui $31,1
addi $31,$31,4
ori $31,$31,28
div $31,$2
mthi $31
ori $31,$31,20
mthi $31
sb $31,6146($25)
nop
lw $31,6144($25)
div $31,$19
addi $25,$25,4
sh $31,6144($25)
nop

jal start
nop
sb $31,6146($25)
addi $31,$31,4
sh $31,6144($25)
multu $0,$31
div $31,$3
beq $31,$2,label91
multu $31,$4
multu $7,$31
nop
jal label2
ori $31,$31,12
or $21,$31,$0
beq $21,$31,label49
add $21,$31,$0
bne $31,$21,label25
sh $31,6146($25)
multu $0,$31
jal label68
nop
mtlo $31

jal start
nop
mult $0,$31
mtlo $31
sub $21,$31,$0
nop
nop
beq $31,$21,label56
divu $31,$3
jal label32
nop
add $21,$31,$0
beq $31,$21,label42
divu $31,$1
divu $31,$1
jal label9
sw $31,6144($25)
beq $31,$2,label73
andi $25,$25,12
nop
sw $31,6144($25)
or $31,$0,$31

jal start
nop
sb $31,6147($25)
add $31,$31,$0
add $31,$4,$31
addi $21,$31,0
bne $31,$21,label81
ori $21,$31,0
nop
nop
bne $21,$31,label5
add $21,$31,$0
nop
bne $31,$21,label50
div $31,$3
mthi $31
jal label45
sh $31,6146($25)
jal label10
divu $31,$7
jal label37
sh $31,6146($25)

jal start
nop
add $31,$7,$31
ori $31,$31,32
nop
nop
add $31,$31,$4
mult $31,$5
mult $0,$31
bne $31,$2,label58
mtlo $31
jal label50
or $21,$31,$0
nop
bne $31,$21,label53
nop
jal label37
sb $31,6145($25)
and $25,$25,$22
nop
sb $31,6144($25)
sh $31,6144($25)

jal start
nop
multu $31,$5
addi $31,$31,20
mfhi $31
lh $31,6146($25)
nop
addi $31,$31,12
jal label4
mflo $31
slt $31,$31,$18
andi $31,$31,0
andi $25,$25,4
sh $31,6144($25)
mult $31,$9
addi $31,$31,28
beq $31,$0,label91
div $31,$4
jal label17
nop
jal label74
div $31,$10

jal label1017
label1017:
nop
nop
lb $31,-12285($31)
jal start
label82:
nop
lui $31,4
multu $8,$31
ori $31,$31,8
lui $31,2
andi $25,$25,12
nop
lh $31,6144($25)
sltu $31,$15,$31
div $31,$9
nop
sltu $31,$31,$3
sltu $31,$31,$13
sltu $31,$8,$31
lh $31,6144($25)
add $31,$31,$12
mflo $31

jal start
nop
add $31,$31,$5
nop
nop
jal label89
addi $31,$31,16
sh $31,6144($25)
mthi $31
andi $21,$31,65535
nop
nop
beq $21,$31,label13
sw $31,6144($25)
bne $31,$3,label16
nop
addi $31,$31,20
jr $31
sub $21,$31,$0
beq $31,$21,label59
lw $25,0($0)
sw $31,6144($25)

jal start
nop
div $31,$4
add $31,$2,$31
sw $31,6144($25)
sb $31,6147($25)
jr $31
lw $31,4($0)
nop
jr $31
mthi $31
mult $7,$31
mthi $31
nop
mtlo $31
jr $31
nop
mult $31,$8
lui $25,0
sb $31,6144($25)
bne $31,$4,label60
add $31,$31,$3

jal start
nop
sh $31,6146($25)
sh $31,6144($25)
nop
or $31,$31,$2
jal label97
ori $21,$31,0
nop
bne $31,$21,label14
div $31,$1
mult $31,$4
divu $31,$7
jal label18
multu $31,$7
beq $31,$6,label36
divu $31,$9
or $31,$1,$31
mult $31,$6
jal label86
sh $31,6146($25)
nop

jal start
nop
mult $31,$9
or $21,$31,$0
nop
nop
bne $31,$21,label38
add $31,$31,$2
slt $31,$19,$31
mthi $31
beq $31,$14,label54
mult $31,$7
mflo $31
lui $31,4
multu $3,$31
bne $31,$8,label1
add $25,$25,$22
sb $31,6146($25)
jal label69
mflo $31
nop
nop

jal start
label59:
nop
divu $31,$2
nop
divu $31,$12
sw $31,6144($25)
or $25,$25,$22
lw $31,6144($25)
mtlo $31
andi $31,$31,8
andi $31,$31,28
sub $31,$31,$8
nop
andi $31,$31,24
lh $31,6146($25)
and $25,$25,$22
sh $31,6146($25)
mflo $31
lw $31,6144($25)
mult $31,$11
lh $31,6146($25)
mtlo $31

jal start
nop
sub $31,$31,$18
mthi $31
mfhi $21
nop
nop
nop
beq $21,$31,label76
lh $31,6144($25)
mult $6,$31
lb $25,0($0)
nop
sw $31,6144($25)
lh $31,6144($25)
mflo $31
andi $25,$25,12
sw $31,6144($25)
addi $31,$31,12
mult $31,$6
jal label36
mult $17,$31

jal start
label30:
nop
nop
lw $31,6144($25)
mthi $31
nop
mult $31,$1
sub $31,$3,$31
nop
nop
divu $31,$13
div $31,$20
mtlo $31
lb $25,0($0)
nop
lh $31,6144($25)
mflo $31
andi $31,$31,0
lh $31,6144($25)
add $31,$31,$8
lh $31,6144($25)
nop

jal start
nop
multu $31,$10
ori $31,$31,24
sb $31,6146($25)
lb $25,0($0)
nop
nop
lh $31,6144($25)
multu $31,$8
nop
sb $31,6146($25)
jal label12
mtlo $31
jal label7
ori $31,$31,8
slt $31,$8,$31
nop
sub $31,$31,$19
andi $31,$31,12
and $31,$18,$31
divu $31,$9

jal start
nop
sb $31,6147($25)
nop
lui $31,3
mthi $31
mfhi $21
nop
nop
bne $31,$21,label88
divu $31,$12
lui $25,0
sh $31,6146($25)
bne $31,$12,label61
addi $31,$31,24
nop
addi $25,$25,4
lw $31,6144($25)
beq $31,$10,label96
multu $31,$10
andi $31,$31,12
sltu $31,$31,$19

jal start
label8:
nop
slt $31,$6,$31
sltu $31,$18,$31
andi $31,$31,4
sub $31,$31,$10
andi $31,$31,32
mult $17,$31
andi $31,$31,0
ori $31,$31,8
nop
mtlo $31
mthi $31
lui $31,6
mthi $31
addi $31,$31,32
div $31,$16
multu $31,$14
add $25,$25,$22
nop
sw $31,6144($25)
sb $31,6146($25)

jal start
nop
nop
multu $31,$7
ori $31,$31,0
or $31,$31,$4
multu $31,$4
ori $25,$25,4
nop
sb $31,6147($25)
multu $0,$31
sh $31,6146($25)
ori $31,$31,36
addi $31,$31,36
div $31,$1
divu $31,$2
beq $31,$1,label70
sh $31,6146($25)
beq $31,$7,label36
ori $31,$31,28
jr $31
mult $31,$1

jal start
label97:
nop
sh $31,6146($25)
sh $31,6146($25)
sub $31,$18,$31
and $31,$31,$9
or $31,$12,$31
lb $31,6146($25)
add $25,$25,$22
nop
lh $31,6144($25)
addi $31,$31,4
lui $25,0
lh $31,6144($25)
mflo $31
lui $25,0
nop
lw $31,6144($25)
div $31,$20
lh $25,0($0)
nop
sb $31,6145($25)

jal start
label57:
nop
mult $2,$31
sw $31,6144($25)
lh $31,6144($25)
add $31,$31,$19
lb $31,6144($25)
nop
mthi $31
or $31,$18,$31
lui $31,1
andi $31,$31,28
andi $31,$31,16
slt $31,$31,$12
lb $31,6147($25)
lb $25,0($0)
lw $31,6144($25)
slt $31,$5,$31
divu $31,$7
mult $5,$31
lui $31,4
mfhi $31

jal start
label65:
nop
lui $31,8
mult $7,$31
andi $31,$31,4
lh $31,6144($25)
lb $31,6144($25)
lh $25,0($0)
sb $31,6145($25)
add $31,$31,$8
nop
nop
nop
mflo $31
lw $31,6144($25)
lui $31,5
mflo $31
ori $31,$31,8
andi $31,$31,16
and $25,$25,$22
nop
sh $31,6144($25)

jal start
nop
nop
lw $31,6144($25)
mtlo $31
jal label72
sub $31,$16,$31
multu $31,$2
ori $31,$31,24
mtlo $31
mflo $21
nop
nop
beq $21,$31,label68
mflo $31
add $25,$25,$22
mthi $25
mfhi $25
lb $31,6147($25)
beq $31,$10,label89
andi $31,$31,8
and $31,$31,$8

jal start
label78:
nop
mult $9,$31
slt $31,$31,$8
sw $31,6144($25)
mfhi $31
nop
sub $31,$31,$14
nop
mfhi $31
nop
lui $31,5
nop
mthi $31
mflo $31
mflo $31
addi $31,$31,36
mflo $31
divu $31,$3
mult $13,$31
mfhi $31
lui $31,6

jal start
label87:
nop
sltu $31,$0,$31
lh $31,6144($25)
mtlo $31
and $31,$12,$31
nop
lui $31,4
addi $31,$31,4
andi $31,$31,8
lh $25,0($0)
nop
sb $31,6145($25)
or $31,$19,$31
sb $31,6145($25)
nop
slt $31,$31,$10
lb $31,6145($25)
lh $31,6144($25)
ori $31,$31,24
slt $31,$6,$31
addi $31,$31,12

jal start
label61:
nop
div $31,$18
nop
multu $10,$31
mthi $31
nop
div $31,$3
nop
mflo $31
addi $31,$31,16
sub $25,$25,$22
sh $31,6146($25)
addi $31,$31,32
add $25,$25,$22
nop
lb $31,6147($25)
ori $25,$25,12
mthi $25
mfhi $25
lh $31,6146($25)
add $31,$31,$3

jal start
label76:
nop
mflo $31
mfhi $31
lb $31,6146($25)
or $31,$31,$5
lw $31,6144($25)
or $25,$25,$22
lb $31,6147($25)
lh $25,0($0)
nop
sb $31,6146($25)
divu $31,$18
mult $31,$18
nop
add $31,$6,$31
add $31,$19,$31
mfhi $31
lh $31,6146($25)
andi $31,$31,12
nop
sb $31,6147($25)

jal start
nop
mfhi $31
lh $31,6144($25)
divu $31,$8
jal label17
add $21,$31,$0
nop
bne $21,$31,label30
sw $31,6144($25)
sltu $31,$5,$31
beq $31,$16,label26
add $25,$25,$22
mthi $25
mfhi $25
lh $31,6146($25)
addi $31,$31,0
nop
jal label98
addi $31,$31,8
mfhi $31
sh $31,6144($25)

jal start
label19:
nop
multu $31,$5
nop
addi $31,$31,8
mult $13,$31
lui $31,5
ori $31,$31,20
mfhi $31
ori $31,$31,24
and $31,$0,$31
mtlo $31
andi $31,$31,4
ori $31,$31,20
nop
andi $31,$31,20
lb $25,0($0)
lw $31,6144($25)
mfhi $31
andi $31,$31,28
nop
nop

jal start
nop
and $31,$2,$31
mflo $31
div $31,$10
nop
ori $31,$31,4
lw $25,0($0)
nop
nop
lb $31,6144($25)
nop
lui $31,9
mthi $31
mfhi $21
nop
nop
beq $31,$21,label32
andi $25,$25,12
nop
nop
lh $31,6146($25)

jal start
nop
sh $31,6146($25)
divu $31,$18
ori $21,$31,0
nop
bne $21,$31,label12
divu $31,$8
nop
add $31,$31,$15
lb $25,0($0)
nop
lb $31,6146($25)
jal label50
mult $31,$7
nop
divu $31,$9
jal label71
sh $31,6146($25)
jal label33
mflo $31
addi $31,$31,28

jal start
label41:
nop
sw $31,6144($25)
mult $31,$14
nop
slt $31,$3,$31
nop
nop
nop
ori $31,$31,8
nop
lui $31,0
lui $25,0
nop
lh $31,6146($25)
lb $25,0($0)
sh $31,6144($25)
or $25,$25,$22
nop
lb $31,6147($25)
nop
add $31,$31,$13

jal start
label28:
nop
mflo $31
slt $31,$5,$31
nop
sub $31,$5,$31
and $31,$31,$9
lui $25,0
nop
sh $31,6144($25)
div $31,$12
sw $31,6144($25)
andi $31,$31,28
and $25,$25,$22
lw $31,6144($25)
mtlo $31
ori $25,$25,4
lh $31,6144($25)
multu $11,$31
ori $31,$31,24
nop
sb $31,6145($25)

jal start
label77:
nop
ori $31,$31,12
sub $31,$31,$4
lh $31,6146($25)
nop
ori $25,$25,8
nop
lw $31,6144($25)
or $31,$31,$11
nop
mthi $31
slt $31,$31,$6
andi $31,$31,12
div $31,$15
sub $31,$15,$31
mfhi $31
nop
nop
mthi $31
and $31,$31,$0
sltu $31,$9,$31

jal start
nop
sh $31,6144($25)
nop
mthi $31
jal label64
or $31,$31,$6
jal label19
nop
nop
mtlo $31
jr $31
ori $31,$31,28
mtlo $31
mthi $31
or $31,$31,$22
mfhi $31
jr $31
andi $25,$25,4
sh $31,6146($25)
jal label91
ori $31,$31,24

jal start
nop
divu $31,$4
add $31,$6,$31
sw $31,6144($25)
divu $31,$1
sub $25,$25,$22
nop
sb $31,6144($25)
addi $31,$31,28
nop
nop
bne $31,$3,label99
mthi $31
div $31,$5
nop
nop
nop
jal label21
mtlo $31
mult $31,$1
mthi $31

jal start
label33:
nop
nop
lh $31,6146($25)
andi $31,$31,36
div $31,$2
andi $31,$31,24
lh $25,0($0)
nop
lw $31,6144($25)
addi $31,$31,20
addi $31,$31,16
mthi $31
or $31,$14,$31
nop
divu $31,$12
sltu $31,$14,$31
or $31,$1,$31
mflo $31
nop
and $31,$31,$3
ori $31,$31,0

jal start
label98:
nop
mult $19,$31
mtlo $31
andi $31,$31,4
lb $25,0($0)
nop
lb $31,6147($25)
sh $31,6146($25)
mflo $31
divu $31,$19
lb $25,0($0)
lb $31,6145($25)
mult $31,$17
addi $31,$31,32
andi $25,$25,12
nop
lw $31,6144($25)
ori $31,$31,32
ori $25,$25,8
lb $31,6144($25)
or $31,$31,$8

jal start
label24:
nop
divu $31,$11
divu $31,$12
ori $31,$31,16
multu $15,$31
or $31,$0,$31
add $31,$18,$31
mfhi $31
mtlo $31
mflo $31
lw $25,0($0)
nop
lw $31,6144($25)
slt $31,$12,$31
multu $19,$31
lw $31,6144($25)
mflo $31
ori $25,$25,0
lb $31,6146($25)
slt $31,$14,$31
mthi $31

jal label1018
nop
label1019:
jr $31
nop
label1018:
jal label1019
nop
jal start
label23:
nop
sw $31,6144($25)
mflo $31
sltu $31,$17,$31
andi $31,$31,0
andi $31,$31,20
addi $31,$31,28
div $31,$9
mtlo $31
and $31,$31,$2
mthi $31
ori $25,$25,4
lw $31,6144($25)
ori $31,$31,20
mthi $31

jal start
nop
sw $31,6144($25)
slt $31,$31,$19
lw $31,6144($25)
lb $31,6144($25)
ori $21,$31,0
nop
nop
beq $21,$31,label71
mthi $31
lb $31,6147($25)
jal label2
ori $31,$31,16
jal label52
divu $31,$4
beq $31,$17,label14
andi $31,$31,0
and $31,$31,$19
jal label47
sh $31,6146($25)
slt $31,$3,$31

jal start
nop
nop
andi $21,$31,65535
nop
beq $31,$21,label89
nop
mtlo $31
nop
div $31,$5
mthi $31
mthi $31
or $31,$31,$22
nop
nop
jr $31
or $31,$6,$31
div $31,$2
sw $31,6144($25)
jal label92
nop
divu $31,$5

jal start
nop
mthi $31
multu $31,$8
nop
jal label23
mult $31,$3
jal label14
mthi $31
lh $31,4($0)
mfhi $31
nop
jr $31
div $31,$9
andi $21,$31,65535
nop
nop
bne $21,$31,label74
mthi $31
mtlo $31
divu $31,$1
nop

jal start
label92:
nop
addi $31,$31,24
andi $31,$31,0
addi $31,$31,20
sltu $31,$31,$11
mthi $31
mtlo $31
and $31,$13,$31
nop
mthi $31
lh $25,0($0)
nop
sb $31,6147($25)
sh $31,6146($25)
nop
addi $31,$31,4
ori $31,$31,12
lw $31,6144($25)
nop
slt $31,$13,$31
nop

jal start
label34:
nop
mtlo $31
mthi $31
sb $31,6145($25)
sw $31,6144($25)
lw $31,6144($25)
lw $31,6144($25)
lui $31,8
nop
lb $25,0($0)
sb $31,6144($25)
sltu $31,$7,$31
sw $31,6144($25)
lui $31,8
mthi $31
or $31,$0,$31
add $31,$31,$15
nop
mfhi $31
divu $31,$3
addi $31,$31,12

jal start
nop
nop
addi $31,$31,12
div $31,$1
jr $31
ori $31,$31,8
jr $31
multu $5,$31
nop
lw $31,4($0)
nop
nop
jr $31
lw $31,4($0)
nop
jr $31
sh $31,6146($25)
mult $31,$0
nop
jr $31
nop

jal start
label43:
nop
sub $31,$7,$31
mfhi $31
mult $31,$2
sh $31,6144($25)
nop
mtlo $31
lui $31,8
ori $25,$25,0
sh $31,6144($25)
mthi $31
mtlo $31
lb $31,6144($25)
nop
sltu $31,$31,$14
lw $31,6144($25)
sub $31,$16,$31
lb $31,6144($25)
lh $25,0($0)
sb $31,6145($25)
mflo $31

jal start
label11:
nop
mflo $31
mult $13,$31
mthi $31
add $25,$25,$22
nop
nop
lb $31,6147($25)
div $31,$19
ori $25,$25,4
lw $31,6144($25)
and $25,$25,$22
sw $31,6144($25)
mfhi $31
lw $31,6144($25)
sub $31,$31,$18
divu $31,$12
andi $25,$25,0
nop
sh $31,6144($25)
lh $31,6146($25)

jal start
nop
sw $31,6144($25)
div $31,$6
mult $4,$31
nop
add $31,$31,$6
addi $31,$31,12
div $31,$3
lh $31,4($0)
nop
nop
jr $31
nop
sw $31,6144($25)
mthi $31
nop
or $31,$31,$22
nop
nop
jr $31
mtlo $31

jal start
nop
or $31,$3,$31
mult $7,$31
ori $31,$31,16
mthi $31
beq $31,$3,label13
mthi $31
beq $31,$7,label52
addi $31,$31,16
jal label4
or $21,$31,$0
bne $21,$31,label14
mult $31,$2
divu $31,$4
ori $25,$25,8
sw $31,6144($25)
jal label89
nop
jal label15
nop
addi $31,$31,28

jal start
label53:
nop
andi $31,$31,0
mflo $31
lw $31,6144($25)
sltu $31,$31,$11
add $31,$18,$31
divu $31,$13
add $25,$25,$22
mthi $25
mfhi $25
lh $31,6144($25)
andi $31,$31,24
and $25,$25,$22
nop
sw $31,6144($25)
or $31,$10,$31
sub $31,$31,$17
lb $31,6146($25)
divu $31,$3
nop
andi $31,$31,0

jal start
nop
mtlo $31
div $31,$2
mtlo $31
beq $31,$5,label92
lb $25,0($0)
sh $31,6146($25)
nop
addi $31,$31,20
nop
jal label87
nop
jal label75
addi $31,$31,20
jal label79
lh $31,4($0)
jr $31
ori $31,$31,16
nop
beq $31,$5,label52
nop

jal start
label84:
nop
or $31,$31,$16
nop
addi $31,$31,24
addi $31,$31,12
mtlo $31
add $31,$31,$0
sub $25,$25,$22
nop
lh $31,6144($25)
andi $25,$25,8
sh $31,6144($25)
and $31,$31,$6
div $31,$16
nop
mult $18,$31
or $25,$25,$22
nop
nop
lh $31,6144($25)
div $31,$13

jal start
label17:
nop
sltu $31,$31,$1
and $31,$5,$31
sltu $31,$7,$31
lui $31,2
nop
nop
nop
sub $25,$25,$22
nop
lb $31,6145($25)
lb $25,0($0)
lh $31,6144($25)
addi $31,$31,4
lui $31,0
andi $31,$31,12
mtlo $31
lh $31,6146($25)
ori $31,$31,20
addi $31,$31,32
add $31,$31,$19

jal start
label96:
nop
addi $31,$31,36
and $31,$31,$10
addi $31,$31,28
sub $31,$6,$31
add $31,$31,$18
lb $25,0($0)
nop
lb $31,6144($25)
lui $31,9
sw $31,6144($25)
lw $25,0($0)
sh $31,6146($25)
add $31,$31,$7
or $31,$0,$31
addi $31,$31,24
nop
nop
or $31,$31,$15
addi $31,$31,8
mthi $31

jal start
label29:
nop
sh $31,6144($25)
div $31,$12
andi $31,$31,8
multu $9,$31
lh $31,6146($25)
sh $31,6146($25)
nop
div $31,$20
divu $31,$3
andi $31,$31,20
andi $25,$25,0
lh $31,6146($25)
div $31,$16
lui $31,9
divu $31,$5
lw $31,6144($25)
addi $25,$25,4
nop
sb $31,6144($25)
sb $31,6146($25)

jal start
nop
mthi $31
div $31,$4
nop
divu $31,$9
jal label72
multu $31,$2
addi $31,$31,36
jal label60
nop
mtlo $31
add $21,$31,$0
nop
beq $21,$31,label46
divu $31,$2
sh $31,6146($25)
ori $31,$31,4
jal label4
ori $21,$31,0
beq $31,$21,label99
add $31,$4,$31

jal start
label70:
nop
mflo $31
sltu $31,$10,$31
or $31,$13,$31
mthi $31
mflo $31
andi $25,$25,4
nop
lb $31,6144($25)
mfhi $31
sb $31,6147($25)
addi $31,$31,36
lui $31,4
nop
mult $31,$18
nop
mthi $31
sltu $31,$1,$31
or $31,$31,$0
div $31,$2
lh $31,6144($25)

jal start
nop
nop
mtlo $31
andi $21,$31,65535
nop
bne $21,$31,label80
mult $31,$4
addi $31,$31,0
div $31,$6
jal label44
mthi $31
lw $31,4($0)
mfhi $31
jr $31
nop
jal label80
nop
div $31,$3
jal label26
nop
nop

jal start
nop
lui $31,5
nop
mflo $31
mtlo $31
sb $31,6144($25)
slt $31,$31,$0
div $31,$4
slt $31,$31,$9
sub $25,$25,$22
nop
lh $31,6144($25)
beq $31,$4,label38
multu $6,$31
lh $31,6144($25)
lw $31,6144($25)
sub $21,$31,$0
nop
nop
bne $21,$31,label34
mflo $31

jal start
nop
sw $31,6144($25)
ori $31,$31,32
mtlo $31
div $31,$9
jr $31
nop
jal label2
multu $31,$6
or $31,$8,$31
nop
jal label69
addi $21,$31,0
nop
nop
bne $31,$21,label10
nop
divu $31,$5
nop
jal label61
multu $31,$8

jal start
label71:
nop
nop
lb $31,6145($25)
sh $31,6144($25)
mfhi $31
andi $31,$31,24
mfhi $31
mult $0,$31
sltu $31,$1,$31
mfhi $31
or $25,$25,$22
nop
nop
lb $31,6146($25)
sltu $31,$31,$13
mfhi $31
mtlo $31
lb $31,6145($25)
sltu $31,$31,$16
andi $31,$31,28
mult $0,$31

jal start
label44:
nop
sh $31,6146($25)
lh $31,6146($25)
nop
sh $31,6144($25)
andi $31,$31,8
mfhi $31
mthi $31
multu $31,$2
mtlo $31
mthi $31
nop
and $31,$31,$2
add $31,$12,$31
nop
sb $31,6145($25)
lb $31,6147($25)
andi $31,$31,24
andi $31,$31,4
slt $31,$31,$12
mtlo $31

jal start
label86:
nop
mthi $31
multu $10,$31
ori $31,$31,36
lw $25,0($0)
nop
lw $31,6144($25)
mtlo $31
div $31,$7
lh $31,6144($25)
multu $31,$15
and $25,$25,$22
sb $31,6147($25)
or $25,$25,$22
nop
nop
lb $31,6147($25)
lh $31,6146($25)
addi $31,$31,36
andi $31,$31,8
lui $31,9

jal start
label26:
nop
multu $31,$12
mthi $31
sltu $31,$31,$13
and $31,$11,$31
lui $31,8
div $31,$8
div $31,$4
mfhi $31
sub $31,$5,$31
ori $31,$31,16
addi $31,$31,16
lui $25,0
nop
sb $31,6147($25)
lh $31,6146($25)
or $25,$25,$22
nop
lw $31,6144($25)
ori $31,$31,12
or $31,$1,$31

jal start
label49:
nop
sltu $31,$31,$18
sh $31,6144($25)
sw $31,6144($25)
mult $13,$31
multu $31,$14
lw $31,6144($25)
div $31,$14
lw $25,0($0)
lh $31,6144($25)
sub $31,$14,$31
mthi $31
div $31,$16
and $31,$31,$17
lb $31,6145($25)
or $31,$31,$19
addi $31,$31,20
multu $31,$11
addi $25,$25,4
nop
lb $31,6146($25)

jal start
label60:
nop
nop
mult $31,$0
multu $12,$31
multu $18,$31
lh $31,6146($25)
or $31,$16,$31
lui $31,3
divu $31,$3
multu $31,$5
mflo $31
ori $31,$31,8
lui $31,7
divu $31,$11
nop
andi $31,$31,28
sub $31,$31,$3
add $31,$10,$31
addi $31,$31,28
addi $31,$31,36
nop

jal start
label58:
nop
sw $31,6144($25)
mult $18,$31
multu $31,$17
andi $31,$31,36
multu $31,$19
mtlo $31
mflo $31
slt $31,$3,$31
mult $6,$31
ori $31,$31,8
lw $25,0($0)
nop
lw $31,6144($25)
addi $25,$25,4
nop
lw $31,6144($25)
sw $31,6144($25)
divu $31,$3
add $31,$31,$10
and $31,$4,$31

jal start
nop
div $31,$1
mtlo $31
sw $31,6144($25)
jal label95
nop
or $31,$31,$2
add $21,$31,$0
nop
beq $21,$31,label15
mthi $31
nop
multu $31,$2
ori $21,$31,0
nop
nop
beq $21,$31,label39
sub $21,$31,$0
beq $21,$31,label57
div $31,$4
addi $31,$31,4

jal start
nop
addi $31,$31,36
addi $31,$31,4
nop
nop
jr $31
nop
jal label39
nop
addi $31,$31,8
nop
addi $21,$31,0
nop
bne $21,$31,label73
or $31,$31,$4
addi $31,$31,24
or $31,$31,$22
nop
jr $31
add $31,$1,$31
mthi $31

jal start
nop
multu $31,$3
andi $21,$31,65535
nop
bne $31,$21,label57
nop
nop
beq $31,$0,label67
sub $25,$25,$22
sh $31,6146($25)
div $31,$6
bne $31,$8,label85
mult $31,$6
nop
sw $31,6144($25)
bne $31,$7,label85
mthi $31
jal label47
mult $31,$3
jr $31
addi $31,$31,36

jal start
label38:
nop
addi $31,$31,32
lh $31,6146($25)
lb $31,6147($25)
mult $10,$31
sltu $31,$31,$10
multu $13,$31
or $25,$25,$22
lb $31,6144($25)
nop
mflo $31
lui $31,2
mflo $31
mfhi $31
andi $31,$31,12
divu $31,$7
divu $31,$10
sub $25,$25,$22
mthi $25
mfhi $25
lh $31,6146($25)

jal start
label37:
nop
mflo $31
andi $31,$31,28
mfhi $31
addi $31,$31,32
nop
andi $31,$31,32
sub $31,$31,$1
divu $31,$6
sb $31,6146($25)
nop
sltu $31,$4,$31
lb $25,0($0)
nop
nop
lh $31,6146($25)
div $31,$8
sub $25,$25,$22
nop
sh $31,6146($25)
sb $31,6144($25)

jal start
nop
addi $31,$31,24
nop
multu $31,$8
nop
ori $21,$31,0
nop
beq $31,$21,label76
mult $31,$8
jal label93
andi $21,$31,65535
bne $21,$31,label25
divu $31,$9
bne $31,$3,label68
nop
mthi $31
addi $31,$31,4
mfhi $31
jr $31
sw $31,6144($25)
sb $31,6147($25)

jal start
label0:
nop
multu $16,$31
nop
lh $31,6146($25)
mult $31,$2
mtlo $31
and $31,$19,$31
divu $31,$17
or $31,$31,$2
slt $31,$10,$31
lui $31,6
lui $31,9
mthi $31
lui $31,0
mult $31,$13
andi $25,$25,12
nop
sh $31,6144($25)
or $31,$31,$15
lui $31,2
addi $31,$31,8

jal start
nop
mtlo $31
nop
multu $31,$6
add $31,$5,$31
addi $31,$31,24
jal label86
nop
jal label59
mult $1,$31
jal label32
mthi $31
lh $31,4($0)
mfhi $31
nop
nop
jr $31
mult $31,$7
bne $31,$6,label34
divu $31,$8
sh $31,6146($25)

jal start
nop
mthi $31
or $31,$31,$1
divu $31,$3
div $31,$5
nop
mthi $31
add $31,$31,$22
mfhi $31
nop
jr $31
mthi $31
addi $31,$31,4
mfhi $31
nop
jr $31
addi $31,$31,4
nop
nop
jr $31
addi $31,$31,28

jal start
nop
add $31,$31,$1
nop
div $31,$7
addi $31,$31,32
divu $31,$2
jal label34
andi $21,$31,65535
beq $31,$21,label49
lh $31,4($0)
nop
nop
jr $31
or $31,$5,$31
bne $31,$0,label97
div $31,$3
jr $31
nop
sb $31,6145($25)
jal label68
div $31,$9

jal start
label75:
nop
mfhi $31
mfhi $31
nop
divu $31,$18
addi $25,$25,4
sw $31,6144($25)
add $31,$2,$31
divu $31,$14
divu $31,$11
add $25,$25,$22
nop
sh $31,6144($25)
nop
sub $25,$25,$22
sw $31,6144($25)
lh $25,0($0)
sw $31,6144($25)
divu $31,$6
addi $31,$31,4
ori $31,$31,4

jal start
nop
andi $31,$31,12
lb $31,6147($25)
divu $31,$9
lw $31,6144($25)
addi $31,$31,16
lw $25,0($0)
nop
sh $31,6146($25)
mflo $31
sub $21,$31,$0
nop
nop
bne $21,$31,label81
lw $31,6144($25)
andi $31,$31,4
beq $31,$0,label29
mflo $31
bne $31,$5,label13
div $31,$18
sub $31,$13,$31

nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop