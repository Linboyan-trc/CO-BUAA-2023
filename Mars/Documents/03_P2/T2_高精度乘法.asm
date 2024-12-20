#   /*
#   1.c转汇编
#       1.int n;
#   
#       2.int ans[2000];
#   
#       3.int main(){
#   
#           1.ans[0]=1;
#               存1
#   
#           2.循环
#           for(int i=2;i<=n;i++){
#               hi=19;
#               while(ans[hi]==0)hi--;
#               计算地址
#               取出
#               判断
#   
#               for(int j=0;j<=hi;j++){
#                   ans[j]=ans[j]*i;
#               }
#               循环
#               相乘
#   
#               for(int j=0;j<=hi;j++){
#                   ans[j+1]+=ans[j]/10;
#                   ans[j]%=10;
#               }
#               循环
#               商
#               余数
#           }
#   
#           hi=19;
#           while(ans[hi]==0)hi--;
#           for(int i=hi;i>=0;i--){
#               printf("%d",ans[i]);
#           }
#           return 0;
#       }
#   2.宏
#       1.结束
#       2.读int
#       3.出int
#   3.寄存器用途
#   #   v0:     a0:     t0:     s0:n
#   #   v1:     a1:     t1:     s1:hi
#   #           a2:     t2:     s2:循环i
#   #           a3:     t3:     s3:循环j
#   #                   t4:地址     s4:地址
#   #                   t5:ans+1取出     s5:ans取出
#   #                   t6:商     s6:
#   #                   t7:10专用     s7:1专用
#   */
.data
    ans: .space 4000

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
    getInt($s0)
    li $s7,1
    li $t7,10
    sw $s7,ans($zero)

    li $s2,2
    addi $s0,$s0,1
    for1:
    beq $s2,$s0,end1
        li $s1,999
        for2:
        sll $s4,$s1,2
        lw $s5,ans($s4)
        bne $s5,0,end2
            subi $s1,$s1,1
            j for2
        end2:

        li $s3,0
        addi $s1,$s1,1
        for3:
        beq $s3,$s1,end3
            sll $s4,$s3,2
            lw $s5,ans($s4)
            mult $s5,$s2
            mflo $s5
            sw $s5,ans($s4)
            addi $s3,$s3,1
            j for3
        end3:

        li $s3,0
        for4:
        beq $s3,$s1,end4
            sll $s4,$s3,2
            lw $s5,ans($s4)
            div $s5,$t7
            addi $t4,$s3,1
            sll $t4,$t4,2
            lw $t5,ans($t4)
            mflo $t6
            add $t5,$t5,$t6
            sw $t5,ans($t4)
            mfhi $s5
            sw $s5,ans($s4)
            addi $s3,$s3,1
            j for4
        end4:

        addi $s2,$s2,1
        j for1
    end1:
        li $s1,999
        for21:
        sll $s4,$s1,2
        lw $s5,ans($s4)
        bne $s5,0,end21
            subi $s1,$s1,1
            j for21
        end21:
        
        for31:
        bgez $s1,if31
        else31:
            j end31
        if31:
            sll $s4,$s1,2
            lw $s5,ans($s4)
            prtInt($s5)
            subi $s1,$s1,1
            j for31
        end31:
            end