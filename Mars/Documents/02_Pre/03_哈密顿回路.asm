.data
graph: .space 256   # 一共8*8=64字，a0弃用
vised: .space 32    # 一共8字，标记点是否已经访问，a0弃用
ans:  .space 4     # 记录是否有密路

.macro end
    li $v0,10
    syscall
.end_macro

.macro getInt(%des)
    li $v0,5
    syscall
    move %des,$v0
.end_macro

.macro getIndex(%ans, %i, %j)
    sll %ans, %i, 3             # %ans = %i * 8
    add %ans, %ans, %j          # %ans = %ans + %j
    sll %ans, %ans, 2           # %ans = %ans * 4
.end_macro

.macro linkTwoPoint(%doc1,%doc2)
    getIndex($s4,%doc1,%doc2)
    sw $s6,graph($s4)
    getIndex($s4,%doc2,%doc1)
    sw $s6,graph($s4)
.end_macro

.macro printInt0()
    li $v0,1
    li $a0,0
    syscall
.end_macro

.macro printInt1()
    li $v0,1
    li $a0,1
    syscall
.end_macro

.macro push(%src)
    sw %src,0($sp)
    subi $sp,$sp,4
.end_macro

.macro pop(%des)
    addi $sp,$sp,4
    lw %des,0($sp)
.end_macro

.text
main:
    getInt($s0)
    getInt($s1)
    li $s5,0
    li $s6,1
loop:
    getInt($s2)
    getInt($s3)
    linkTwoPoint($s2,$s3)
    addi $s5,$s5,1
    bne $s5,$s1,loop
# 调用dfs
    li $t0,1
    move $a0,$t0
    jal dfs
    printInt0
    end
success:
    printInt1
    end

dfs:
    push($ra)
    push($t0)
    push($s5)
    move $t0,$a0
    sll $t1,$t0,2
    sw $s6,vised($t1)   #标记访问

    li $s5,1 
    li $s7,1
    isAllTraveled:
        move $t1,$s5
        sll $t1,$t1,2
        lw $t1,vised($t1)
        and $s7,$s7,$t1
        addi $s5,$s5,1
        ble $s5,$s0,isAllTraveled
    
    getIndex($t2,$t0,$s6)
    lw $t2,graph($t2)   # t2存储了graph[t0][1]是否连通
    and $s7,$s7,$t2     # 与之后为1，就存在哈密
    beq $s7,$s6,success

    li $s5,1
search:
    # 是否已经访问
    sll $t5,$s5,2
    lw $t3,vised($t5)
    xori $t3,$t3,1
    # graph[t0][s5]是否连通
    getIndex($t5,$t0,$s5)
    lw $t4,graph($t5)
    # t6决定，如果连通且没访问，就dfs；否则继续遍历
    and $t6,$t3,$t4
    bne $t6,1,else
    if:
        move $t7,$s5
        move $a0,$t7
        jal dfs
    else:
    addi $s5,$s5,1
    ble $s5,$s0,search
    # 全部都不成立，返回上一层
    if_end:
        sll $t1,$t0,2
        sw $zero,vised($t1)
        pop($s5)
        pop($t0)
        pop($ra)
        jr $ra





