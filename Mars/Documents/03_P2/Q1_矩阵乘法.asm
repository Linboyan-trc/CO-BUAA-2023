#   /*
#   1.C代码
#   2.C代码转汇编
#   3.写宏
#   4.规定寄存器用途
#   */
#   
#   /*
#   1.C代码
#       1.读入n
#       2.读第一个数组
#           for(int i=0;i<n;i++){
#               for(int j=0;j<n;j++){
#                   a[i][j]=读入
#               }
#           }
#       3.读第二个数组
#           for(int i=0;i<n;i++){
#               for(int j=0;j<n;j++){
#                   b[i][j]=读入
#               }
#           }
#       4.计算乘积
#       for(int i=0;i<n;i++){
#           for(int j=0;j<n;j++){
#               for(int k=0;k<n;k++){
#                   c[i][j]+=a[i][k]*b[k][j]
#               }
#           }
#       }
#   2.C代码转汇编
#       1.读入n
#       5+syscall
#   
#       2.读第一个数组
#           for(int i=0;i<n;i++){
#               for(int j=0;j<n;j++){
#                   读入到a0
#                   计算a[i][j]在m1中的地址
#                   存a0进a[i][j]
#               }
#           }
#       3.读第二个数组
#           for(int i=0;i<n;i++){
#               for(int j=0;j<n;j++){
#                   读入到a0
#                   计算b[i][j]在m1中的地址
#                   存a0进b[i][j]
#               }
#           }
#       4.计算乘积
#       for(int i=0;i<n;i++){
#           for(int j=0;j<n;j++){
#               for(int k=0;k<n;k++){
#                   c[i][j]+=a[i][k]*b[k][j]
#               }
#           }
#       }
#   3.写宏
#       1.结束宏
#       2.读取int宏
#       3.输出int宏
#       4.计算地址宏
#   4.规定寄存器用途
#   v0:     a0:读数  t0:循环i       s0:n
#   v1:     a1:     t1:循环j        s1:存计算index得到的地址
#           a2:     t2:循环k        s2:
#           a3:     t3:取数1        s3:
#                   t4:取数2        s4:
#                   t5:乘积         s5:
#                   t6:累加并且输出   s6:
#                   t7:             s7:
#    */

.data
    m1: .space 256
    m2: .space 256
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

# 输入行列下标，存储到$s1
.macro calIndex(%hang,%lie)
    mult %hang,$s0
    mflo $s2
    add $s2,$s2,%lie
    sll $s1,$s2,2
.end_macro

.text
# 读取n
    getInt($s0)


# 读取矩阵
li $t0,0
firstloop1:
    beq $t0,$s0,firstend1
li $t1,0
firstloop2:
    beq $t1,$s0,firstend2
    # 读数到a0
    # 计算下标
    # 存入数组
    getInt($a0)
    calIndex($t0,$t1)
    sw $a0,m1($s1)
    addi $t1,$t1,1
    j firstloop2
firstend2:
    addi $t0,$t0,1
    j firstloop1
firstend1:

li $t0,0
secondloop1:
    beq $t0,$s0,secondend1
li $t1,0
secondloop2:
    beq $t1,$s0,secondend2
    # 读数到a0
    # 计算下标
    # 存入数组
    getInt($a0)
    calIndex($t0,$t1)
    sw $a0,m2($s1)
    addi $t1,$t1,1
    j secondloop2
secondend2:
    addi $t0,$t0,1
    j secondloop1
secondend1:


# 三重循环计算
li $t0,0
thirdloop1:
    beq $t0,$s0,thirdend1
li $t1,0
thirdloop2:
    beq $t1,$s0,thirdend2
li $t2,0
li $t6,0
thirdloop3:
    beq $t2,$s0,thirdend3
    # 取a[i][k]
    # 取b[k][j]
    # 乘积
    # 累加到t6
    calIndex($t0,$t2)
    lw $t3,m1($s1)
    calIndex($t2,$t1)
    lw $t4,m2($s1)
    mult $t3,$t4
    mflo $t5
    add $t6,$t6,$t5
    # 循环继续
    addi $t2,$t2,1
    j thirdloop3
thirdend3:
    printInt($t6)
    printKong
addi $t1,$t1,1
j thirdloop2
thirdend2:
    printHuan
addi $t0,$t0,1
j thirdloop1
thirdend1:
    end

