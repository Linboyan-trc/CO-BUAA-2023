#   /*
#   1.写c代码
#   2.c代码转汇编
#   3.写宏
#   4.规定寄存器用途
#   v0:     a0:     t0:     s0:
#   v1:     a1:     t1:     s1:
#           a2:     t2:     s2:
#           a3:     t3:     s3:
#           a4:     t4:     s4:
#           a5:     t5:     s5:
#           a6:     t6:     s6:
#           a7:     t7:     s7:
#    */
#   
#    /*
#   1.写c代码
#       1.读取m1,n1;m2,n2
#       2.读取矩阵1
#           for(int i=0;i<m1;i++){
#               for(int j=0;j<n1;j++){
#                   a[i][j]=输入的数
#               }
#           }
#       3.读取矩阵2
#           for(int i=0;i<m2;i++){
#               for(int j=0;j<n2;j++){
#                   b[i][j]=输入的数
#               }
#           }
#       4.计算卷积
#           for(int i=0;i<m1-m2+1;i++){
#               for(int j=0;j<n1-n2+1;j++){
#                   // 计算卷积
#                   for(int k=0;k<m2;k++){
#                       for(int r=0;r<n2;r++){
#                           c[i][j]+=a[i+k][j+r]*b[k][r]
#                       }
#                   }
#                   print(c[i][j] + " ")
#               }
#               print("\n")
#           }
#   2.c代码转汇编
#       1.读取m1,n1;m2,n2
#           getInt宏
#       2.读取矩阵1
#           for(int i=0;i<m1;i++){
#               for(int j=0;j<n1;j++){
#                   a[i][j]=输入的数
#                   读取到a0
#                   计算在数组中的位置
#                   存在数组中
#               }
#           }
#       3.读取矩阵2
#           for(int i=0;i<m2;i++){
#               for(int j=0;j<n2;j++){
#                   b[i][j]=输入的数
#               }
#           }
#       4.计算卷积
#           for(int i=0;i<m1-m2+1;i++){
#               for(int j=0;j<n1-n2+1;j++){
#                   // 计算卷积
#                   for(int k=0;k<m2;k++){
#                       for(int r=0;r<n2;r++){
#                           c[i][j]+=a[i+k][j+r]*b[k][r]
#                           计算a[i+k][j+r]位置
#                           取出a[i+k][j+r]
#                           计算b[k][r]位置
#                           取出b[k][r]
#                           计算乘积
#                           加在c[i][j]
#                       }
#                   }
#                   print(c[i][j] + " ")
#               }
#               print("\n")
#           }
#   3.写宏
#       1.结束
#       2.读int
#       3.计算下标地址时乘以四
#       4.打印空格
#       5.打印换行
#   4.规定寄存器用途
#   v0:     a0:读数      t0:循环i            s0:m1
#   v1:     a1:存i+k     t1:循环j            s1:n1
#           a2:存j+r     t2:循环k            s2:m2
#           a3:         t3:循环r            s3:n2
#           a4:         t4:存a[i+k][j+r]    s4:存进数组的下标计算量
#           a5:         t5:存b[k][r]        s5:m1-m2+1
#           a6:         t6:乘积             s6:n1-n2+1
#           a7:         t7:累加             s7:
#    */

.data
    mu: .space 512
    he: .space 512
    kong: .asciiz " "
    huan: .asciiz "\n"

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

.macro calIndex(%hang,%lie,%base)
    mult %hang,%base
    mflo $s4
    add $s4,$s4,%lie
    sll $s4,$s4,2
.end_macro

.macro printKong
    li $v0,4
    la $a0,kong
    syscall
.end_macro

.macro printHuan
    li $v0,4
    la $a0,huan
    syscall
.end_macro

.text
# 读取4个整数
    getInt($s0)
    getInt($s1)
    getInt($s2)
    getInt($s3)
# 读取矩阵1
li $t0,0
aloop1:
beq $t0,$s0,aend1
    li $t1,0
    aloop2:
    beq $t1,$s1,aend2
        getInt($a0)
        calIndex($t0,$t1,$s0)
        sw $a0,mu($s4)
        addi $t1,$t1,1
        j aloop2
    aend2:
    addi $t0,$t0,1
    j aloop1
aend1:
# 读取矩阵2
li $t0,0
bloop1:
beq $t0,$s2,bend1
    li $t1,0
    bloop2:
    beq $t1,$s3,bend2
        getInt($a0)
        calIndex($t0,$t1,$s2)
        sw $a0,he($s4)
        addi $t1,$t1,1
        j bloop2
    bend2:
    addi $t0,$t0,1
    j bloop1
bend1:
# 计算卷积
    # 四层循环，先计算出前两层的m1-m2+1,n1-n2+1
    # 计算a[i+k][j+r]位置
    # 取出a[i+k][j+r]
    # 计算b[k][r]位置
    # 取出b[k][r]
    # 计算乘积
    # 加在c[i][j] 
sub $s5,$s0,$s2
addi $s5,$s5,1
sub $s6,$s1,$s3
addi $s6,$s6,1
li $t0,0
cloop1:
beq $t0,$s5,cend1

    li $t1,0
    cloop2:
    beq $t1,$s6,cend2

        li $t2,0
        li $t7,0
        cloop3:
        beq $t2,$s2,cend3

            li $t3,0
            cloop4:
            beq $t3,$s3,cend4
            # 计算a[i+k][j+r]位置
            # 取出a[i+k][j+r]
            # 计算b[k][r]位置
            # 取出b[k][r]
            # 计算乘积
            # 加在c[i][j] 
            add $a1,$t0,$t2
            add $a2,$t1,$t3
            calIndex($a1,$a2,$s0)
            lw $t4,mu($s4)
            calIndex($t2,$t3,$s2)
            lw $t5,he($s4)
            mult $t4,$t5
            mflo $t6
            add $t7,$t7,$t6

                addi $t3,$t3,1
                j cloop4
            cend4:

            addi $t2,$t2,1
            j cloop3
        cend3:
        printInt($t7)
        printKong

        addi $t1,$t1,1
        j cloop2
    cend2:
    printHuan

    addi $t0,$t0,1
    j cloop1
cend1:

end