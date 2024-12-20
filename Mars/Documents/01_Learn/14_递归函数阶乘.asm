.macro end
    li $v0,10
    syscall
.end_macro

.macro getInt(%des)
    li $v0,5
    syscall
    move %des,$v0
.end_macro

.macro printInt(%src)
    li $v0,1
    move $a0,%src
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
    # 1.输入需要阶乘的数n
    getInt($s0)
    # 2.传递参数a0+调用函数+返回值结果存进s1
    move $a0,$s0
    jal factorial
    move $s1,$v0
    # 3.打印结果
    printInt($s1)
    # 4.结束程序
    end

factorial:
    # 1.把ra和t0存进栈
    push($ra)
    push($t0)
    # 2.准备函数实现
    # 参数进入t0+分支控制（递归出口+递归调用）
    move $t0,$a0
    bne $t0,1,else
    if:
        li $v0,1
        j recall
    else:
        subi $t1,$t0,1
        move $a0,$t1
        jal factorial
        mult $t0,$v0
        mflo $v0
    recall:
        pop($t0)
        pop($ra)
        jr $ra

