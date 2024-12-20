#   /*
#   1.写C代码
#   2.C代码转汇编
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
#   1.写C代码
#       1.读取n
#       2.读取字符
#           for(int i=0;i<n;i++)存字符到数组中
#       3.双指针判断
#           int flag=1
#           for(int i=0,j=n-1;i<j;i++,j--){
#               if(a[i]!=a[j]){
#                   flag=0;
#                   break;
#               }
#           }
#       4.输出flag
#   2.C代码转汇编
#       1.读取n
#           getInt的宏
#       2.读取字符
#           for(int i=0;i<n;i++)存字符到数组中
#           宏实现，指针自增4
#           读到a0
#           移动到对应位置
#       3.双指针判断
#           int flag=1
#           for(int i=0,j=n-1;i<j;i++,j--){
#               if(a[i]!=a[j]){
#                   flag=0;
#                   break;
#               }
#               1.取出两个字符
#               2.然后比较
#           }
#       4.输出flag
#   3.写宏
#       1.结束
#       2.读int
#       3.读char到指定位置
#       4.打印int
#   4.规定寄存器用途
#   v0:     a0:             t0:循环i     s0:n
#   v1:     a1:存入时的地址   t1:循环j     s1:作flag
#           a2:             t2:存字符1   s2:取字符的计算中间量
#           a3:             t3:存字符2   s3:
#           a4:             t4:         s4:
#           a5:             t5:         s5:
#           a6:             t6:         s6:
#           a7:             t7:         s7:
#     */

.data
    chuan: .space 32

.macro end
    li $v0,10
    syscall
.end_macro

.macro getInt(%des)
    li $v0,5
    syscall
    move %des,$v0
.end_macro

# 输入地址位置
.macro getChar(%des)
    li $v0,12
    syscall
    sw $v0,chuan(%des)
.end_macro

.macro printInt(%src)
    li $v0,1
    move $a0,%src
    syscall
.end_macro

.macro loadChar(%i,%des)
    move $s2,%i
    sll $s2,$s2,2
    lw %des,chuan($s2)
.end_macro

.text
# 读取n
    getInt($s0)
# 读取字符
li $t0,0
li $a1,0
oneloop:
beq $t0,$s0,oneend
    getChar($a1)
    addi $a1,$a1,4
    addi $t0,$t0,1
    j oneloop
oneend:
# 双指针判断
    # 设置flag
    # 双循环，不相等就置0然后break
    li $s1,1
li $t0,0
move $t1,$s0
subi $t1,$t1,1
twoloop1:
bge $t0,$t1,twoend
    loadChar($t0,$t2)
    loadChar($t1,$t3)
    addi $t0,$t0,1
    subi $t1,$t1,1
    beq $t2,$t3,twoloop1
    li $s1,0
    j notHuiwen
twoend:
    printInt($s1)
    end
notHuiwen:
    printInt($s1)
    end

