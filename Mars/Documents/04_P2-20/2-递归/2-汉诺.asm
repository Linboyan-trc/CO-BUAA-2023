#   /*
#   1.C语言
#       void move(int n,char a,char c){
#           printf("move %d from %c to %c\n",n,a,c);
#           return;
#       }
#       void hannuo(int n,char A,char B,char C){
#           if(n==1){
#                   move(1,A,C);
#           return;
#           }
#   
#           hannuo(n-1,a,c,b);
#           move(n,a,c);
#           hannuo(n-1,b,a,c);
#           return;
#       }
#       int main(){
#           int n;
#           scanf("%d",&n);
#           hannuo(n,A,B,C);
#           return 0;
#       }
#   2.转汇编
#       void move(int n,char a,char c){
#           printf("move %d from %c to %c\n",n,a,c);
#           return;
#       }
#       2.void hannuo(int n,char A,char B,char C){
#           1.  如果a0移到t0
#               t0==1
#               打印这么些
#               退栈
#               返回
#               if(n==1){
#                       move(1,A,C);
#               return;
#               }
#           2.  调用
#               移动
#               调用
#               退栈
#               返回
#           hannuo(n-1,a,c,b);
#           move(n,a,c);
#           hannuo(n-1,b,a,c);
#           return;
#       }
#       1.int main(){
#           1.  int n;
#               scanf("%d",&n);
#               读n
#           2.  hannuo(n,A,B,C);
#               return 0;
#               move给a0
#               调用
#               结束
#       }
#   3.写宏
#       1.结束
#       2.读int，打int
#       3.打字母
#       .macro prtA
#           li $v0,4
#           la $s1,ca
#           syscall
#       .end_macro
#   4.寄存器用途
#   #   v0:     a0:n     t0:n     s0:n
#   #   v1:     a1:塔     t1:塔     s1:读字母专用
#   #           a2:塔     t2:塔     s2:prtSent参数1
#   #           a3:塔     t3:塔     s3:prtSent参数2
#   #                   t4:n-1     s4:prtSent参数3
#   #                   t5:     s5:
#   #                   t6:     s6:
#   #                   t7:     s7:
#   5.子函数
#       move a0
#       调用
#       end
#   入栈
#   move a0
#   循环
#   结束
#       退栈
#       jr回去
#   6.入栈顺序
#       t0 t1 t2 t3
#    */
.data
    ca: .asciiz "A"
    cb: .asciiz "B"
    cc: .asciiz "C"
    kong: .asciiz " "
    huan: .asciiz "\n"
    move: .asciiz "move"
    from: .asciiz "from"
    to: .asciiz "to"

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

.macro prtA
    li $v0,4
    la $a0,ca
    syscall
.end_macro

.macro prtB
    li $v0,4
    la $a0,cb
    syscall
.end_macro

.macro prtC
    li $v0,4
    la $a0,cc
    syscall
.end_macro

.macro prtSel(%src)
    beq %src,1,case1
    beq %src,2,case2
    beq %src,3,case3
    case1:
        prtA
        j endcase
    case2:
        prtB
        j endcase
    case3:
        prtC
        j endcase
    endcase:
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

.macro printMove
    li $v0,4
    la $a0,move
    syscall
.end_macro

.macro printFrom
    li $v0,4
    la $a0,from
    syscall
.end_macro

.macro printTo
    li $v0,4
    la $a0,to
    syscall
.end_macro

.macro prtSent(%src1,%src2,%src3)
    printMove

    printKong
    prtInt(%src1)
    printKong

    printFrom

    printKong
    prtSel(%src2)
    printKong

    printTo

    printKong
    prtSel(%src3)
    printHuan
.end_macro

.text
# 读n
    getInt($s0)
# 递归
    move $t0,$s0
    li $t1,1
    li $t2,2
    li $t3,3
    move $a0,$t0
    move $a1,$t1
    move $a2,$t2
    move $a3,$t3
    jal hannuo
    end

hannuo:
    push($ra)
    push($t0)
    push($t1)
    push($t2)
    push($t3)
    push($t4)
    move $t0,$a0
    move $t1,$a1
    move $t2,$a2
    move $t3,$a3
    beq $t0,1,case01
    j case02
    case01:
        li $s1,1
        move $s2,$t1
        move $s3,$t3
        prtSent($s1,$s2,$s3)
        pop($t4)
        pop($t3)
        pop($t2)
        pop($t1)
        pop($t0)
        pop($ra)
        jr $ra
    case02:
        subi $t4,$t0,1
        move $a0,$t4
        move $a1,$t1
        move $a2,$t3
        move $a3,$t2
        jal hannuo
        prtSent($t0,$t1,$t3)
        move $a0,$t4
        move $a1,$t2
        move $a2,$t1
        move $a3,$t3
        jal hannuo
    pop($t4)
    pop($t3)
    pop($t2)
    pop($t1)
    pop($t0)
    pop($ra)
    jr $ra