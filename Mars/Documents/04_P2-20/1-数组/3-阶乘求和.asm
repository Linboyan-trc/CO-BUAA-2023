#   /*
#   1.C语言
#       int n;
#       int main(){
#           scanf("%d",&n);
#           int sum=0;
#           for(int i=1;i<=n;i++){
#               int temp=1;
#               for(int j=1;j<=i;j++){
#                   temp*=j;
#               }
#               sum+=temp;
#           }
#           printf("%d",sum);
#           return 0;
#       }
#   2.转汇编
#       int main(){
#           1.scanf("%d",&n);
#               读int
#           2.int sum=0;
#               s4作sm
#           3.循环
#               循环i 
#                   temp置1
#                   循环j
#                   相乘
#                   到temp
#               sum加上
#   
#               for(int i=1;i<=n;i++){
#                   int temp=1;
#                   for(int j=1;j<=i;j++){
#                       temp*=j;
#                   }
#                   sum+=temp;
#               }
#           4.printf("%d",sum);
#               打印
#           return 0;
#       }
#   3.写宏
#   4.寄存器用途
#   #   v0:     a0:     t0:     s0:n
#   #   v1:     a1:     t1:     s1:循环i
#   #           a2:     t2:     s2:循环j
#   #           a3:     t3:     s3:temp
#   #           a4:     t4:     s4:sum
#   #           a5:     t5:     s5:i+1
#   #           a6:     t6:     s6:
#   #           a7:     t7:     s7:
#    */
.data

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

.text
# 读n
    getInt($s0)
# 置sum
    li $s4,0
# 循环
    li $s1,1
    addi $s0,$s0,1
    for1:
    beq $s1,$s0,end1
            li $s3,1
            li $s2,1
            addi $s5,$s1,1
            for2:
            beq $s2,$s5,end2
                mult $s3,$s2
                mflo $s3
                addi $s2,$s2,1
                j for2
            end2:
            add $s4,$s4,$s3
        addi $s1,$s1,1
        j for1
    end1:
        prtInt($s4)
        end