ori $1,$0,7
ori $2,$0,10
ori $3,$0,10
ori $4,$0,12
ori $5,$0,7
ori $6,$0,6
ori $7,$0,7
ori $8,$0,9
ori $9,$0,4
ori $10,$0,6
ori $11,$0,10
ori $12,$0,7
ori $13,$0,7
ori $14,$0,7
ori $15,$0,7
ori $16,$0,4
ori $17,$0,10
ori $18,$0,5
ori $19,$0,5
ori $20,$0,4
ori $21,$0,10
ori $22,$0,11
ori $23,$0,3
ori $24,$0,7
ori $25,$0,7
ori $26,$0,10
ori $27,$0,5
ori $28,$0,12
ori $29,$0,4
ori $30,$0,11
jal Text0
nop
JumpZone0:
jal JumpOut0
nop
Text0:
ori $30,$30,214
multu $29,$30
ori $12,$0,12
sb $24,22($12)
mtlo $0
addi $28,$30,129
addi $11,$15,282
ori $29,$0,4
sw $20,12($29)
sub $13,$31,$8
andi $8,$12,268
mtlo $15
andi $20,$3,384
ori $17,$30,343
nop
mfhi $19
div $17,$9
ori $23,$0,8
lw $23,40($23)
ori $29,$0,16
lb $24,18($29)
mthi $2
ori $25,$17,354
mtlo $29
ori $24,$0,24
sw $20,20($24)
slt $2,$15,$30
sub $27,$27,$3
addi $5,$30,54
mfhi $31
and $6,$22,$24
mtlo $12
nop
multu $2,$15
beq $16,$24,JumpZone0
nop
JumpOut0:
jal Text1
nop
JumpZone1:
multu $24,$16
jal JumpOut1
nop
Text1:
mthi $25
slt $23,$3,$13
ori $2,$0,16
lh $29,38($2)
andi $3,$26,185
add $8,$24,$0
lui $29,58
ori $28,$0,8
lh $15,78($28)
mfhi $26
sltu $26,$15,$7
nop
ori $8,$0,16
sw $4,116($8)
sltu $1,$10,$11
lui $11,4
nop
ori $14,$3,409
ori $7,$0,4
sb $24,37($7)
mfhi $21
divu $14,$24
mtlo $26
andi $16,$8,83
ori $4,$0,24
lb $25,37($4)
mfhi $4
mthi $11
mfhi $25
slt $10,$25,$1
ori $1,$0,4
sb $25,6($1)
multu $9,$30
div $24,$28
ori $11,$0,8
lh $10,54($11)
bne $21,$14,JumpZone1
nop
JumpOut1:
jal Text2
nop
JumpZone2:
ori $14,$0,12
lh $21,74($14)
jal JumpOut2
nop
Text2:
or $17,$26,$25
divu $7,$19
andi $17,$1,317
ori $30,$0,24
lh $20,74($30)
nop
ori $2,$0,16
lw $17,48($2)
or $31,$12,$19
andi $22,$31,195
add $7,$5,$26
mthi $27
or $17,$10,$28
sub $19,$5,$13
mult $14,$25
lui $12,405
mult $31,$20
ori $13,$0,20
sw $17,64($13)
addi $30,$2,318
or $29,$28,$11
divu $19,$25
ori $26,$0,8
lh $16,18($26)
or $30,$7,$11
mflo $19
and $11,$15,$11
ori $12,$0,16
lh $7,52($12)
ori $9,$0,20
lh $16,32($9)
nop
ori $5,$0,8
sb $5,10($5)
div $23,$8
nop
beq $19,$8,JumpZone2
nop
JumpOut2:
beq $16,$4,JumpOut3
nop
JumpOut3:
sub $20,$4,$2
ori $18,$0,8
lh $13,30($18)
divu $6,$0
ori $9,$0,20
sh $9,48($9)
ori $3,$0,12
lh $5,50($3)
ori $1,$0,12
lh $3,26($1)
add $26,$7,$12
andi $3,$29,272
add $8,$11,$1
ori $3,$18,378
slt $23,$15,$5
ori $15,$8,356
mthi $30
ori $18,$0,4
sb $22,11($18)
mult $17,$2
add $1,$18,$15
slt $15,$25,$10
ori $9,$0,8
sb $14,29($9)
ori $27,$0,4
lw $1,36($27)
nop
sltu $27,$31,$16
mtlo $28
mtlo $29
ori $20,$0,4
sw $0,156($20)
multu $20,$10
add $29,$29,$15
mtlo $11
sub $2,$5,$17
ori $31,$0,20
lh $29,18($31)
beq $3,$24,JumpOut5
nop
JumpOut4:
ori $11,$0,16
sw $20,12($11)
ori $31,$0,8
sb $4,14($31)
ori $19,$0,24
sw $7,76($19)
ori $3,$0,16
sh $8,14($3)
ori $3,$0,16
sb $9,20($3)
sltu $2,$0,$29
or $17,$29,$6
sub $3,$20,$14
mult $13,$6
ori $17,$0,20
lw $25,76($17)
andi $19,$5,107
mtlo $13
ori $26,$0,8
lb $4,13($26)
ori $29,$0,12
lh $7,78($29)
sltu $1,$21,$23
sub $13,$27,$4
nop
or $28,$2,$2
divu $8,$30
div $12,$22
ori $29,$0,8
lb $22,40($29)
ori $3,$0,16
sh $9,4($3)
ori $23,$0,24
lb $23,1($23)
ori $1,$0,12
lb $22,2($1)
multu $21,$18
addi $13,$18,420
div $15,$28
nop
and $7,$5,$6
beq $10,$4,JumpOut6
nop
JumpOut5:
ori $17,$0,16
sb $18,34($17)
slt $6,$10,$4
divu $7,$3
ori $31,$0,8
lw $12,132($31)
sltu $10,$22,$17
div $14,$6
mult $1,$14
nop
mult $28,$20
or $12,$27,$20
sltu $27,$9,$1
ori $8,$7,237
add $12,$5,$20
and $21,$23,$14
mtlo $26
sltu $21,$16,$8
ori $4,$0,4
lb $3,6($4)
mthi $3
or $19,$10,$24
addi $13,$11,2
div $9,$25
sltu $4,$29,$5
divu $27,$23
mult $15,$15
lui $15,251
mult $29,$15
divu $22,$26
ori $2,$0,20
lw $10,100($2)
ori $23,$0,4
lw $4,120($23)
mult $26,$26
beq $19,$5,JumpOut6
nop
JumpOut6:
multu $16,$28
div $19,$31
multu $7,$31
divu $26,$14
sub $16,$17,$19
ori $22,$0,4
lh $24,36($22)
or $31,$6,$6
lui $3,338
sub $26,$14,$27
sltu $19,$0,$26
ori $9,$0,16
lh $3,26($9)
div $16,$23
andi $10,$2,268
divu $15,$19
ori $17,$0,24
sh $29,6($17)
sub $12,$13,$26
ori $16,$0,8
lh $10,28($16)
multu $27,$27
slt $17,$24,$31
ori $1,$0,20
lw $14,32($1)
lui $7,119
mtlo $6
nop
lui $24,235
ori $29,$0,16
sb $21,1($29)
ori $15,$0,12
lh $10,50($15)
addi $2,$3,211
ori $25,$0,20
sb $8,4($25)
multu $22,$10
sb $28,1($0)
beq $14,$29,JumpOut7
nop
JumpOut7:
lui $21,214
nop
sub $31,$13,$28
ori $3,$0,12
sb $15,40($3)
mthi $1
andi $10,$18,299
andi $15,$11,167
andi $4,$28,285
ori $21,$0,16
sw $9,132($21)
divu $10,$14
addi $21,$22,385
slt $6,$16,$27
slt $22,$25,$16
addi $21,$30,196
ori $14,$9,417
ori $10,$0,8
sw $27,156($10)
mfhi $1
andi $12,$24,98
ori $15,$0,20
lw $25,104($15)
mfhi $9
mtlo $24
div $1,$0
mflo $30
ori $8,$0,12
sh $20,8($8)
mtlo $0
and $29,$21,$23
sub $4,$28,$0
andi $12,$26,227
mflo $5
mult $11,$8
beq $22,$17,JumpOut8
nop
JumpOut8:
ori $26,$0,4
lb $17,39($26)
sltu $20,$29,$4
ori $1,$4,199
sltu $1,$17,$0
ori $17,$0,4
sh $3,68($17)
mtlo $31
lui $7,211
mfhi $17
ori $6,$29,334
add $21,$1,$26
and $18,$1,$23
ori $4,$0,12
lb $4,21($4)
sltu $27,$29,$30
addi $11,$15,120
sltu $10,$26,$15
add $1,$3,$13
divu $31,$4
addi $3,$26,239
div $1,$20
mtlo $1
divu $6,$2
or $8,$3,$26
mflo $4
nop
addi $14,$10,296
and $12,$22,$5
mflo $11
ori $4,$0,20
sh $5,42($4)
beq $12,$7,JumpOut9
nop
JumpOut9:
sltu $4,$6,$14
andi $20,$25,450
multu $9,$13
add $30,$7,$8
addi $6,$21,157
and $8,$17,$28
mthi $31
add $28,$30,$2
mult $0,$14
div $11,$1
ori $13,$0,20
sb $2,16($13)
and $24,$1,$10
andi $19,$17,74
addi $13,$8,400
nop
divu $3,$31
mfhi $26
ori $12,$0,20
lh $2,32($12)
mtlo $26
sltu $27,$26,$23
ori $10,$0,4
sb $25,3($10)
ori $9,$0,4
sb $8,15($9)
and $28,$11,$6
lui $29,278
or $5,$14,$19
addi $3,$22,418
mtlo $22
mflo $11
addi $10,$9,354
beq $23,$13,JumpOut10
nop
JumpOut10:
mult $0,$20
mult $11,$19
ori $3,$0,12
sb $20,27($3)
ori $10,$0,24
lw $27,96($10)
div $29,$28
mtlo $24
divu $29,$19
add $26,$24,$29
mult $25,$7
sb $18,1($0)
mfhi $7
lui $4,172
ori $20,$8,235
nop
sub $19,$30,$21
lui $18,126
mflo $29
addi $3,$23,160
lui $27,191
mtlo $27
slt $29,$3,$11
sub $11,$11,$25
mult $12,$23
ori $13,$0,8
lb $3,19($13)
ori $11,$0,12
lw $14,24($11)
andi $24,$20,207
lui $28,125
mflo $27
ori $30,$0,12
lb $26,4($30)
beq $28,$9,JumpOut11
nop
JumpOut11:
ori $15,$0,12
lb $2,2($15)
ori $15,$0,12
sw $27,12($15)
divu $11,$16
sltu $14,$8,$22
mflo $10
mtlo $3
or $21,$2,$14
mthi $22
ori $4,$0,16
lh $18,0($4)
ori $23,$0,16
lh $27,62($23)
ori $11,$0,12
sb $20,13($11)
mfhi $25
mflo $14
mthi $31
mult $4,$1
ori $11,$0,16
lw $7,56($11)
sltu $25,$14,$11
sub $31,$27,$28
mflo $6
mtlo $22
add $14,$30,$14
ori $14,$0,4
lw $3,160($14)
mflo $30
lui $19,322
ori $30,$0,20
lh $8,28($30)
div $29,$19
ori $4,$0,20
sb $15,28($4)
nop
ori $17,$0,12
sb $12,19($17)
sltu $3,$13,$24
beq $11,$23,JumpOut12
nop
JumpOut12:
lui $23,455
slt $15,$19,$13
mtlo $2
slt $9,$23,$16
and $26,$4,$6
ori $24,$0,24
sh $0,76($24)
mtlo $18
ori $18,$0,20
sh $23,80($18)
addi $27,$8,231
add $9,$22,$23
ori $20,$14,380
mfhi $10
andi $10,$18,24
addi $31,$15,153
ori $7,$0,4
sw $18,128($7)
mflo $18
andi $4,$22,262
mfhi $27
sltu $28,$30,$7
slt $16,$23,$14
lh $18,50($0)
lui $20,315
andi $2,$13,155
mflo $26
ori $18,$0,16
lh $11,0($18)
mtlo $11
ori $1,$0,20
lw $20,144($1)
ori $9,$0,4
lb $19,3($9)
mflo $19
mflo $4
beq $19,$9,JumpOut13
nop
JumpOut13:
div $18,$16
sub $12,$12,$20
ori $8,$0,24
lw $2,36($8)
sltu $15,$28,$10
slt $25,$8,$27
add $22,$16,$8
slt $19,$4,$7
and $21,$9,$12
ori $15,$0,4
sh $9,36($15)
mult $20,$21
sub $31,$16,$22
ori $2,$0,8
lb $25,12($2)
mult $2,$15
sub $20,$4,$13
and $23,$25,$26
mult $31,$18
mult $31,$29
divu $1,$22
ori $29,$0,8
lh $22,56($29)
nop
add $30,$3,$19
mthi $28
ori $28,$0,4
sb $30,7($28)
lui $17,359
mult $31,$9
ori $31,$0,16
sb $21,7($31)
ori $16,$0,12
lb $23,6($16)
or $23,$8,$31
mtlo $22
beq $12,$27,JumpOut14
nop
JumpOut14:
or $7,$8,$15
add $21,$8,$9
ori $27,$0,4
sh $15,48($27)
mult $30,$18
mthi $30
add $10,$13,$0
andi $27,$3,16
and $31,$8,$24
lui $19,108
mfhi $9
or $23,$16,$5
lui $29,118
ori $20,$0,24
lb $29,17($20)
andi $1,$8,366
add $8,$27,$25
or $5,$28,$31
add $25,$3,$20
and $6,$24,$10
nop
ori $27,$22,152
multu $18,$2
lui $4,270
and $19,$5,$26
div $13,$17
sub $11,$3,$19
ori $28,$0,16
sb $28,7($28)
multu $12,$24
ori $16,$0,20
sb $20,28($16)
sub $30,$2,$14
ori $8,$0,8
sw $15,140($8)
beq $20,$14,JumpOut15
nop
JumpOut15:
mfhi $19
multu $2,$20
or $21,$27,$7
andi $23,$7,278
addi $7,$6,156
nop
mult $5,$27
mtlo $14
sub $16,$24,$0
lui $5,190
slt $1,$13,$29
andi $13,$18,66
andi $10,$12,143
slt $24,$4,$12
ori $18,$0,4
sw $15,112($18)
mult $29,$25
andi $23,$0,221
add $28,$24,$12
andi $16,$28,206
ori $1,$0,4
sb $1,0($1)
div $14,$22
or $12,$19,$2
multu $23,$18
add $24,$22,$18
add $10,$10,$3
ori $29,$0,16
lh $4,76($29)
or $25,$10,$25
mflo $8
addi $2,$24,122
and $17,$5,$26
beq $3,$4,JumpOut16
nop
JumpOut16:
nop
ori $23,$0,24
lb $26,2($23)
and $11,$5,$30
ori $4,$29,14
multu $29,$5
and $27,$13,$9
mtlo $31
ori $23,$0,8
lh $20,24($23)
multu $1,$20
mthi $1
ori $4,$1,246
andi $27,$5,89
mtlo $22
ori $20,$0,8
sb $25,6($20)
sub $10,$21,$2
multu $13,$16
ori $9,$0,24
sw $21,104($9)
sub $30,$11,$16
lui $8,188
add $26,$11,$4
mflo $16
andi $7,$19,395
ori $8,$0,24
sb $29,32($8)
multu $9,$20
or $6,$20,$6
mult $22,$18
ori $14,$0,16
sh $29,0($14)
addi $14,$16,167
mtlo $6
div $16,$25
beq $8,$21,JumpOut17
nop
JumpOut17:
mfhi $15
multu $8,$7
mfhi $27
mtlo $6
ori $10,$0,12
lb $11,33($10)
ori $5,$0,24
lb $14,30($5)
div $1,$20
or $19,$24,$25
div $29,$11
andi $2,$14,106
lui $10,440
slt $3,$13,$25
lui $29,34
lui $19,245
addi $17,$23,64
ori $14,$0,12
lb $2,39($14)
andi $9,$20,131
ori $26,$0,8
sh $17,62($26)
mthi $10
ori $15,$22,289
addi $21,$18,141
andi $12,$5,271
div $8,$11
ori $17,$0,20
lh $24,16($17)
sub $26,$15,$27
mflo $6
ori $21,$0,12
sh $7,12($21)
mthi $22
mtlo $23
slt $10,$0,$18
beq $3,$1,JumpOut18
nop
JumpOut18:
ori $3,$0,12
lb $3,22($3)
divu $0,$19
mfhi $17
mtlo $19
lui $5,338
mfhi $26
mfhi $1
and $11,$23,$8
lui $27,40
ori $12,$0,24
lw $21,28($12)
multu $31,$24
ori $27,$0,16
lw $5,12($27)
addi $10,$0,289
mult $11,$8
and $6,$14,$5
ori $5,$2,394
ori $27,$0,12
sw $2,160($27)
add $16,$13,$24
andi $25,$24,390
multu $8,$2
and $29,$22,$27
ori $6,$13,76
mult $27,$14
and $1,$4,$12
divu $13,$11
ori $19,$0,8
lh $16,18($19)
mflo $6
or $8,$10,$4
mult $21,$18
add $7,$6,$3
beq $17,$26,JumpOut19
nop
JumpOut19:
ori $24,$9,17
ori $25,$0,12
sb $5,30($25)
multu $23,$21
mthi $24
mult $18,$6
ori $18,$31,279
mfhi $10
addi $3,$24,169
addi $11,$13,402
ori $26,$0,12
lb $17,23($26)
add $8,$30,$31
mult $1,$15
divu $12,$27
or $12,$22,$9
sltu $30,$19,$20
ori $16,$0,20
lw $27,72($16)
lui $23,317
ori $21,$0,12
sw $14,132($21)
or $7,$6,$24
ori $9,$0,20
sb $1,30($9)
mtlo $0
ori $5,$0,20
sh $30,58($5)
mflo $5
add $28,$26,$6
ori $17,$0,4
sh $10,80($17)
sltu $27,$19,$19
ori $19,$0,20
lb $20,4($19)
lui $7,204
mfhi $18
add $1,$0,$16
beq $23,$21,JumpOut20
nop
JumpOut20:
ori $4,$0,16
sh $19,36($4)
ori $1,$0,24
lb $11,15($1)
or $12,$9,$2
nop
mflo $30
andi $19,$29,250
nop
multu $27,$26
add $25,$23,$11
mfhi $5
ori $31,$0,8
sh $2,48($31)
and $3,$28,$10
ori $24,$0,8
lh $21,38($24)
divu $30,$1
mtlo $29
ori $21,$0,12
sw $24,152($21)
divu $19,$0
sltu $28,$2,$18
slt $9,$27,$7
ori $3,$0,8
sw $1,4($3)
and $9,$16,$20
or $12,$3,$19
divu $0,$4
div $13,$11
ori $26,$0,12
sh $24,0($26)
slt $25,$5,$1
ori $2,$21,352
slt $26,$10,$11
div $2,$20
mult $21,$2
beq $3,$12,JumpOut21
nop
JumpOut21:
ori $14,$0,8
sh $16,12($14)
addi $26,$6,355
ori $17,$0,4
lw $13,128($17)
or $8,$22,$26
mflo $17
ori $31,$0,20
lb $10,1($31)
div $20,$16
sub $28,$14,$3
sub $17,$10,$25
mfhi $16
sltu $24,$26,$30
mfhi $7
nop
lui $24,106
add $4,$28,$15
or $28,$8,$17
sltu $23,$18,$2
ori $26,$0,12
sb $14,37($26)
nop
divu $25,$7
mtlo $20
div $19,$31
div $17,$24
nop
ori $27,$0,8
sw $5,64($27)
mult $16,$6
nop
ori $15,$0,24
lh $24,42($15)
multu $16,$9
ori $20,$0,12
lw $11,80($20)
beq $7,$4,JumpOut22
nop
JumpOut22:
ori $5,$0,8
sh $27,42($5)
ori $6,$0,20
sb $28,8($6)
sltu $21,$12,$0
mult $17,$0
ori $15,$19,362
ori $20,$20,276
ori $18,$0,16
sb $21,39($18)
sub $22,$14,$20
or $16,$9,$5
add $12,$1,$14
mult $8,$21
multu $21,$22
ori $18,$0,8
lb $7,7($18)
ori $10,$0,16
sh $3,8($10)
mflo $6
ori $27,$0,20
sh $5,16($27)
mflo $10
mthi $0
mult $9,$31
div $6,$12
ori $17,$0,16
lh $7,74($17)
ori $24,$0,20
sh $14,42($24)
ori $14,$0,12
lh $6,42($14)
mult $23,$6