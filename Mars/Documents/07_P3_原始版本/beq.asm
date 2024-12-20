# 测试目标:正跳转
lui $1,0x0001
lui $2,0x0001
beq $1,$2,label1
lui $1,0x0000
label1:
lui $1,0x1111
# 测试结果:通过

# 测试目标:负跳转
lui $8,0x0001
lui $1,0x0000
label2:
add $1,$1,$8
lui $2,0x0001
beq $1,$2,label2
# 测试结果:通过

