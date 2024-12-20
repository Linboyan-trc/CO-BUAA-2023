#   /*
#   1.c语言
#   2.转汇编
#   3.写宏
#   4.规定寄存器用途
#    */
#   /*
#   1.c语言
#       int symbol[7],myarray[7];
#   
#       void FullArray(int index){
#           if(index==4){
#               for(int i=0;i<4;i++){
#                   printf("%d ",myarray[i]);
#               }
#               printf("\n");
#               return;
#           }
#           for(int i=0;i<4;i++){
#               if(symbol[i]==0){
#                   myarray[index]=i+1;
#                   symbol[i]=1;
#                   FullArray(index+1);
#                   symbol[i]=0;
#               }
#           }
#       }
#   
#       int main(){
#           FullArray(0);
#           return 0;
#       }
#   2.转汇编
#       1.int symbol[7],myarray[7];
#           两个数组存一下
#       2.void FullArray(int index){
#           1.保存ra、t0
#           2.a0移动到t0
#           3.判断t0是否等于s0
#               等于就要打印数组到n
#               打印完要返回
#               if(index==n){
#                   for(int i=0;i<n;i++){
#                       printf("%d ",myarray[i]);
#                   }
#                   printf("\n");
#                   return;
#               }
#           4.
#               循环i
#               找symbol地址
#               取symbol[i]
#                   计算i+1
#                   myarray[index]赋值
#                   symbol[i]赋值
#                   递归
#                   symbol[i]回退
#                   退栈
#               for(int i=0;i<n;i++){
#                   if(symbol[i]==0){
#                       myarray[index]=i+1;
#                       symbol[i]=1;
#                       FullArray(index+1);
#                       symbol[i]=0;
#                   }
#               }
#       }
#   
#       3.int main(){
#           1.读入n
#           2.递归FullArray(0)
#               传参a0为0
#       }
#   3.写宏
#       1.结束宏
#       2.读int宏
#       //3.计算下标地址宏
#       4.入栈宏
#       5.出栈宏
#       6.打印整个array宏
#   4.规定寄存器用途
#   v0:     a0:传参     t0:层主     s0:n
#   v1:     a1:     t1:     s1:循环i
#           a2:     t2:     s2:symbol地址
#           a3:     t3:     s3:myarray地址
#           a4:     t4:     s4:取symbol
#           a5:     t5:取出ary     s5:计算i+1
#           a6:     t6:打印循环i     s6:
#           a7:     t7:打印循环i的地址     s7:1专用
#   5.入栈顺序
#       先ra，再t0，还有遍历i
#    */

 .data
    s: .space 32
    ary: .space 32
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

.macro prtKong
    li $v0,4
    la $a0,kong
    syscall
.end_macro

.macro prtHuan
    li $v0,4
    la $a0,huan
    syscall
.end_macro

.macro prtAry
    li $t6,0
    for:
    beq $t6,$s0,finish
        sll $t7,$t6,2
        lw $t5,ary($t7)
        prtInt($t5)
        prtKong
        addi $t6,$t6,1
        j for
    finish:
        prtHuan
.end_macro

.text
# 读n
# 递归
    # 母
        # 传参
        # 进入递归
        # 递归出口
    # 函数
        # 保存
            # 调用
            # 传参
        # 退栈
# 读n
    getInt($s0)
# 递归
    # 母
        # 传参
        # 进入递归
        # 递归出口
        li $t0,0
        li $s7,1
        move $a0,$t0
        jal fary
        end
    # 函数
        # 保存
            # 调用
            # 传参
        # 退栈
fary:
    push($ra)
    push($t0)
    push($s1)
    push($s2)
    move $t0,$a0
    bne $t0,$s0,else
    if:
        prtAry
    else:
        li $s1,0
        forn:
        beq $s1,$s0,finishn
                sll $s2,$s1,2
                sll $s3,$t0,2
                lw $s4,s($s2)
                bne $s4,0,finishnn
                    addi $s5,$s1,1
                    sw $s5,ary($s3)
                    sw $s7,s($s2)
                    # 调用
                        # 传参
                        move $a0,$t0
                        addi $a0,$a0,1
                        jal fary
                        sw $zero,s($s2)
                finishnn:
            addi $s1,$s1,1
            j forn
        finishn:
            pop($s2)
            pop($s1)
            pop($t0)
            pop($ra)
            jr $ra
