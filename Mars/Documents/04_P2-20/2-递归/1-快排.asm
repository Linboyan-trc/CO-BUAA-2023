#   /*
#   1.c语言
#       2.int a[N];
#       void quick_sort(int a[],int i_n,int j_n){
#           1.入栈
#               移动到t0
#           2.如果
#               退栈
#               返回
#           if(i_n>=j_n)return; 
#   
#           3.指针i和j
#               int i=i_n,j=j_n;
#               直接赋值
#               int pivot=a[i];
#               计算地址
#               取到t4
#   
#               循环
#                   循环
#                       计算地址，取出到t5
#                       比较
#                   循环
#                       计算地址，取出到t6
#                       比较
#                   如果
#                       交换
#               while(i!=j){
#                   while(a[j]>=pivot&&i<j){
#                       j--;
#                   }
#                   while(a[i]<=pivot&&i<j){
#                       i++;
#                   }
#                   if(i<j){
#                       int temp=a[j];
#                       a[j]=a[i];
#                       a[i]=temp;
#                   }
#               }
#   
#               赋值
#               a[i_n]=a[i];
#               a[i]=pivot;
#   
#           调用
#           quick_sort(a,i_n,i-1);
#           quick_sort(a,i+1,j_n);
#
#           返回
#           return;
#       }
#       
#       1.int main(){
#           1.读入n
#           2.读入数组
#               循环i
#               读到s3
#               计算下标地址到s4
#               存入
#   
#               int i=0;
#               while(scanf("%d",&a[i])!=EOF){
#                   i++;
#               }
#   
#           3.调用
#               move到a0
#               move到a1
#               quick_sort(a,0,i-1);
#           
#           4.打印
#               循环
#               计算下标
#               打印数字
#               int j=0;
#               for(j=0;j<i;j++)printf("%d ",a[j]);
#               return 0;
#       }
#   2.转汇编
#   3.写宏
#   4.寄存器用途
#   #   v0:     a0:左     t0:左     s0:n
#   #   v1:     a1:右     t1:右     s1:循环i
#   #           a2:     t2:i     s2:
#   #           a3:     t3:j     s3:读数/取数
#   #           a4:     t4:pivot     s4:地址
#   #           a5:     t5:a[j]     s5:
#   #           a6:     t6:a[i]     s6:
#   #           a7:     t7:temp     s7:
#   5.子函数
#   6.入栈顺序
#       ra t0 t1
#    */
.data
    ary: .space 512
    kong: .asciiz " "

.macro end
    li $v0,10
    syscall
.end_macro

.macro getInt(%des)
    li $v0,5
    syscall
    move %des,$v0
.end_macro

.macro prtInt(%src)
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

.macro calIndex(%xia)
    sll $s4,%xia,2
.end_macro

.macro prtKong
    li $v0,4
    la $a0,kong
    syscall
.end_macro

.text
# 读n
    getInt($s0)
# 读数组
    li $s1,0
    for1:
    beq $s1,$s0,end1
            getInt($s3)
            calIndex($s1)
            sw $s3,ary($s4)
        addi $s1,$s1,1
        j for1
    end1:
# 调用
    subi $s1,$s1,1
    li $t0,0
    move $t1,$s1
    move $a0,$t0
    move $a1,$t1
    jal quis
# 打印
    li $s1,0
    for2:
    beq $s1,$s0,end2
            calIndex($s1)
            lw $s3,ary($s4)
            prtInt($s3)
            prtKong
        addi $s1,$s1,1
        j for2
    end2:
        end
# 子函
quis:
    push($ra)
    push($t0)
    push($t1)
    move $t0,$a0
    move $t1,$a1
    bge $t0,$t1,case1
    j case2
    case1:
        pop($t1)
        pop($t0)
        pop($ra)
        jr $ra
    case2:
        move $t2,$t0
        move $t3,$t1
        calIndex($t2)
        lw $t4,ary($s4)
        for3:
        beq $t2,$t3,end3
                calIndex($t3)
                lw $t5,ary($s4)
                for4:
                bge $t5,$t4,jump1
                    else1:
                        j end4
                    jump1:
                        blt $t2,$t3,jump2
                            else2:
                                j end4
                            jump2:
                                subi $t3,$t3,1
                                calIndex($t3)
                                lw $t5,ary($s4)
                    j for4
                end4:

                calIndex($t2)
                lw $t6,ary($s4)
                for5:
                ble $t6,$t4,jump3
                    else3:
                        j end5
                    jump3:
                        blt $t2,$t3,jump4
                            else4:
                                j end5
                            jump4:
                                addi $t2,$t2,1
                                calIndex($t2)
                                lw $t6,ary($s4)
                    j for5
                end5:

                blt $t2,$t3,jump5
                    else5:
                        j end6
                    jump5:
                        move $t7,$t5
                        calIndex($t3)
                        sw $t6,ary($s4)
                        calIndex($t2)
                        sw $t7,ary($s4)
            end6:
            j for3
        end3:
        calIndex($t0)
        sw $t6,ary($s4)
        calIndex($t2)
        sw $t4,ary($s4)

        move $a0,$t0
        subi $t2,$t2,1
        move $a1,$t2
        jal quis
        addi $t2,$t2,2
        move $a0,$t2
        move $a1,$t1
        jal quis
        pop($t1)
        pop($t0)
        pop($ra)
        jr $ra