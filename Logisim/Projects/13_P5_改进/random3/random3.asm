ori $1,$0,7
ori $2,$0,3
ori $3,$0,12
ori $4,$0,6
ori $5,$0,10
ori $6,$0,8
ori $7,$0,12
ori $8,$0,8
ori $9,$0,11
ori $10,$0,8
ori $11,$0,10
ori $12,$0,11
ori $13,$0,8
ori $14,$0,7
ori $15,$0,12
ori $16,$0,5
ori $17,$0,10
ori $18,$0,7
ori $19,$0,10
ori $20,$0,10
ori $21,$0,3
ori $22,$0,10
ori $23,$0,11
ori $24,$0,9
ori $25,$0,11
ori $26,$0,3
ori $27,$0,5
ori $28,$0,5
ori $29,$0,11
ori $30,$0,8
lui $22,394
jal Text0
nop
JumpZone0:
lui $22,78
jal JumpOut0
nop
Text0:
add $10,$10,$31
nop
ori $29,$8,365
nop
ori $19,$11,62
ori $12,$0,20
sw $8,44($12)
sub $14,$8,$4
lui $5,360
ori $20,$0,4
sw $18,124($20)
lui $18,434
sub $3,$23,$10
nop
nop
ori $4,$22,172
ori $12,$16,100
lui $3,260
ori $16,$18,173
sub $7,$13,$21
add $22,$23,$9
nop
ori $14,$0,24
sw $12,52($14)
sub $8,$5,$26
sub $1,$22,$24
ori $10,$10,240
ori $26,$0,4
lw $28,124($26)
sub $7,$0,$3
add $24,$20,$25
sub $10,$25,$3
ori $10,$0,12
lw $7,104($10)
beq $2,$22,JumpZone0
nop
JumpOut0:
jal Text1
nop
JumpZone1:
ori $22,$0,8
lw $2,84($22)
jal JumpOut1
nop
Text1:
ori $8,$0,20
lw $26,160($8)
nop
sub $28,$3,$19
ori $16,$25,140
lui $8,179
add $2,$5,$9
lui $15,274
ori $24,$0,24
sw $1,136($24)
ori $8,$0,12
sw $3,64($8)
ori $31,$0,20
sw $27,108($31)
sub $28,$8,$18
add $20,$26,$31
ori $30,$0,4
lw $18,112($30)
nop
ori $19,$0,20
lw $15,136($19)
lui $7,211
ori $15,$0,24
sw $5,140($15)
sub $15,$2,$8
nop
sub $26,$4,$9
ori $9,$5,435
ori $19,$0,20
lw $30,36($19)
ori $5,$27,186
sub $18,$13,$12
ori $8,$10,164
ori $25,$0,16
sw $11,80($25)
lui $20,31
ori $12,$0,20
sw $16,136($12)
lui $23,83
ori $15,$0,12
sw $3,140($15)
beq $29,$19,JumpZone1
nop
JumpOut1:
jal Text2
nop
JumpZone2:
ori $19,$0,24
sw $29,0($19)
jal JumpOut2
nop
Text2:
ori $8,$0,20
sw $23,152($8)
sub $5,$7,$2
ori $6,$9,19
sub $8,$29,$18
ori $15,$0,8
sw $4,148($15)
ori $27,$0,12
sw $17,28($27)
add $26,$9,$1
lui $29,319
nop
ori $6,$0,16
lw $2,4($6)
ori $12,$4,315
sub $13,$14,$28
ori $23,$26,55
nop
lui $29,170
sub $3,$10,$14
lui $4,211
add $6,$26,$5
nop
sub $8,$9,$12
sub $6,$6,$5
ori $1,$23,32
ori $6,$0,16
sw $10,52($6)
nop
sub $27,$25,$11
nop
lui $8,209
ori $7,$0,12
lw $31,68($7)
beq $12,$25,JumpZone2
nop
JumpOut2:
beq $27,$4,JumpOut3
nop
JumpOut3:
ori $19,$0,12
lw $28,132($19)
lui $21,56
ori $21,$10,217
sub $10,$11,$11
lui $14,52
add $28,$8,$21
ori $13,$31,85
ori $26,$0,16
sw $23,76($26)
ori $6,$0,12
sw $13,116($6)
add $4,$26,$18
ori $22,$15,194
ori $17,$0,4
sw $21,44($17)
sub $18,$7,$15
ori $15,$0,12
sw $13,20($15)
sub $25,$4,$20
ori $24,$2,332
ori $25,$0,20
sw $20,80($25)
lui $3,271
ori $25,$0,24
lw $27,64($25)
nop
add $15,$10,$25
add $30,$3,$0
ori $21,$17,36
add $22,$22,$20
lui $28,204
ori $24,$0,8
sw $26,84($24)
ori $26,$0,4
sw $4,124($26)
sub $8,$28,$29
add $15,$28,$12
ori $14,$5,178
beq $20,$12,JumpOut5
nop
JumpOut4:
nop
lui $22,172
ori $18,$6,110
ori $5,$18,163
ori $17,$25,176
ori $16,$17,386
lui $5,423
nop
add $30,$24,$6
ori $26,$0,16
sw $11,92($26)
ori $30,$24,68
add $23,$28,$14
add $8,$16,$8
lui $13,145
sub $16,$12,$25
ori $22,$18,88
lui $18,192
add $13,$29,$30
add $5,$15,$3
nop
add $6,$29,$17
nop
sub $13,$13,$6
add $9,$14,$21
lui $21,402
sub $17,$0,$11
ori $19,$2,279
nop
beq $29,$7,JumpOut5
nop
JumpOut5:
ori $4,$17,104
ori $6,$26,130
ori $15,$0,8
lw $11,48($15)
ori $15,$1,196
ori $16,$27,32
ori $6,$0,12
lw $3,20($6)
nop
lui $19,96
ori $19,$0,8
lw $16,28($19)
ori $4,$22,44
sub $19,$24,$1
ori $1,$0,16
sw $18,104($1)
add $20,$19,$22
nop
nop
ori $23,$0,12
lw $20,76($23)
nop
ori $24,$0,8
lw $31,96($24)
sub $19,$9,$2
ori $28,$6,4
ori $28,$0,24
lw $31,32($28)
ori $17,$7,250
ori $20,$0,24
lw $2,116($20)
ori $8,$0,4
lw $14,116($8)
nop
lui $25,95
sub $17,$0,$28
beq $19,$25,JumpOut6
nop
JumpOut6:
ori $24,$0,4
lw $24,108($24)
nop
nop
add $29,$16,$27
ori $26,$0,12
lw $1,32($26)
lui $13,82
nop
ori $11,$0,4
sw $18,128($11)
ori $12,$14,340
ori $22,$0,4
sw $2,136($22)
ori $26,$0,24
lw $30,148($26)
sub $22,$18,$18
ori $28,$0,16
lw $24,80($28)
add $27,$15,$30
lui $20,194
ori $23,$0,24
sw $31,144($23)
ori $12,$0,8
sw $13,32($12)
lui $29,156
ori $28,$25,326
ori $5,$30,340
ori $7,$0,12
lw $31,148($7)
add $1,$3,$4
add $15,$6,$7
ori $1,$0,8
lw $5,16($1)
ori $15,$0,13
sub $25,$2,$31
ori $21,$0,24
sw $3,52($21)
ori $24,$0,4
sw $15,64($24)
ori $11,$3,166
ori $18,$0,24
sw $8,108($18)
beq $25,$12,JumpOut7
nop
JumpOut7:
ori $16,$6,197
sub $2,$7,$15
sub $19,$25,$20
ori $7,$0,16
sw $21,136($7)
nop
ori $15,$0,24
sw $25,56($15)
nop
add $11,$3,$10
nop
lui $11,297
lui $6,444
sub $10,$25,$6
ori $23,$0,24
lw $29,132($23)
ori $21,$20,341
ori $17,$0,8
sw $30,52($17)
lui $11,304
nop
ori $25,$0,24
sw $20,52($25)
ori $4,$0,12
sw $25,140($4)
sub $23,$2,$7
add $18,$26,$26
nop
sub $2,$7,$4
nop
lui $6,155
add $22,$20,$4
ori $14,$0,24
sw $11,116($14)
ori $6,$0,20
lw $12,100($6)
ori $19,$5,426
beq $17,$12,JumpOut8
nop
JumpOut8:
sub $13,$11,$26
lui $3,364
lui $1,304
lui $23,393
sub $19,$24,$13
sub $8,$0,$23
ori $22,$0,8
lw $1,60($22)
sub $21,$10,$14
ori $8,$0,8
lw $29,0($8)
ori $21,$0,4
lw $27,24($21)
ori $15,$0,20
lw $22,112($15)
ori $19,$0,4
lw $15,124($19)
sw $10,144($0)
nop
sub $28,$2,$4
nop
ori $20,$0,8
lw $26,16($20)
lui $15,228
ori $14,$0,8
lw $6,124($14)
ori $27,$0,16
lw $21,88($27)
add $12,$24,$6
nop
lui $11,280
ori $9,$8,407
add $21,$7,$4
ori $27,$15,263
beq $7,$21,JumpOut9
nop
JumpOut9:
add $12,$23,$21
add $21,$15,$15
ori $28,$14,310
lui $19,45
ori $26,$19,215
ori $6,$0,4
lw $25,44($6)
ori $20,$0,24
sw $5,12($20)
sub $30,$30,$20
add $30,$6,$15
sub $5,$2,$0
lui $20,306
nop
ori $29,$0,4
lw $2,160($29)
nop
ori $31,$3,318
sub $1,$8,$4
lui $23,31
add $4,$6,$17
sub $4,$9,$24
ori $27,$0,8
lw $15,52($27)
nop
add $17,$16,$1
ori $6,$0,20
lw $18,156($6)
ori $1,$25,87
add $10,$21,$19
ori $25,$0,12
lw $16,56($25)
lui $2,127
ori $1,$16,58
add $21,$13,$30
nop
beq $2,$6,JumpOut10
nop
JumpOut10:
nop
sub $17,$1,$18
nop
lui $6,100
sub $4,$3,$28
lui $8,350
ori $19,$0,24
lw $16,40($19)
ori $8,$7,309
nop
ori $31,$0,20
sw $21,84($31)
ori $8,$0,12
lw $20,16($8)
lui $31,166
ori $21,$0,16
sw $8,108($21)
add $3,$19,$29
ori $28,$18,70
sub $5,$15,$0
add $26,$26,$14
nop
add $25,$23,$5
lui $21,388
ori $1,$13,283
lui $29,358
ori $27,$26,303
ori $25,$0,24
sw $6,140($25)
add $31,$16,$28
nop
beq $17,$23,JumpOut11
nop
JumpOut11:
lui $22,19
sub $7,$14,$8
add $25,$13,$7
ori $16,$25,364
nop
ori $23,$0,8
sw $26,4($23)
ori $15,$0,24
sw $13,36($15)
ori $11,$7,246
sub $16,$1,$22
sub $29,$11,$15
ori $23,$0,8
sw $1,156($23)
ori $12,$20,3
nop
ori $1,$0,16
lw $1,140($1)
add $3,$26,$27
ori $6,$0,8
lw $19,84($6)
ori $17,$30,409
ori $13,$0,16
lw $15,24($13)
add $7,$31,$11
ori $6,$0,24
lw $8,132($6)
add $4,$17,$7
ori $11,$0,8
lw $22,112($11)
ori $26,$20,346
ori $21,$29,31
lui $7,98
ori $10,$0,16
sw $29,52($10)
lui $1,52
ori $5,$0,24
lw $6,0($5)
lui $15,95
lui $10,325
beq $18,$30,JumpOut12
nop
JumpOut12:
lui $3,9
lui $25,69
ori $3,$0,8
lw $14,148($3)
nop
sub $14,$18,$20
add $24,$5,$14
add $16,$19,$1
sub $18,$21,$9
lui $21,311
sub $4,$19,$24
sub $2,$23,$13
sub $1,$30,$25
nop
sub $19,$31,$20
nop
ori $10,$21,282
nop
ori $29,$19,160
lui $8,372
sub $9,$16,$3
lui $9,382
sub $5,$19,$26
nop
lui $22,378
sub $25,$13,$30
lui $22,148
nop
ori $30,$9,85
lui $17,435
ori $28,$4,374
beq $6,$0,JumpOut13
nop
JumpOut13:
nop
ori $16,$25,307
ori $14,$0,24
sw $8,144($14)
lui $31,204
ori $22,$0,4
sw $21,96($22)
sub $16,$1,$17
ori $12,$0,16
lw $17,140($12)
nop
ori $19,$3,337
