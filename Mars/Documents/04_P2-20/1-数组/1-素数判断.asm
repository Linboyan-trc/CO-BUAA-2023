#   /*
#   1.c代码
#   bool isPrime(int n) {
#       if (n <= 1) {
#           return false;
#       }
#       for (int i = 2; i * i <= n; i++) {
#           if (n % i == 0) {
#               return false;
#           }
#       }
#       return true; 
#   }
#   int main() {
#       int num;
#       printf("输入一个整数：");
#       scanf("%d", &num);
#       if (isPrime(num)) {
#           printf("%d 是素数\n", num);
#       } else {
#           printf("%d 不是素数\n", num);
#       }
#       return 0;
#   }
#   2.转汇编
#       3.bool isPrime(int n) {
#           1.判断
#               if (n <= 1) {
#                   return false;
#               }
#           2.循环
#               乘积
#               移动
#               判断
#                   如果整除
#                   直接v0=0
#                   返回
#               for (int i = 2; i * i <= n; i++) {
#                   if (n % i == 0) {
#                       return false;
#                   }
#               }
#           return true; 
#               v0=1
#               返回
#       }
#       1.int main() {
#           1.读数
#               int num;
#               printf("输入一个整数：");
#               scanf("%d", &num);
#           2.传入参数
#               v0移动到a0
#               返回0就输出false
#               返回1就输出true
#               if (isPrime(num)) {
#                   printf("%d 是素数\n", num);
#               } else {
#                   printf("%d 不是素数\n", num);
#               }
#           return 0;
#       }
#   3.写宏
#   4.寄存器用途
#   #   v0:     a0:     t0:     s0:num
#   #   v1:     a1:     t1:     s1:循环i
#   #           a2:     t2:     s2:i乘积
#   #           a3:     t3:     s3:除法余数
#   #           a4:     t4:     s4:
#   #           a5:     t5:     s5:
#   #           a6:     t6:     s6:
#   #           a7:     t7:     s7:1专用
#    */
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
    move $a0,%src
    li $v0,1
    syscall
.end_macro

.text
# 读数
    getInt($s0)
# 调用
    jal isPrime
    prtInt($v0)
    end

isPrime:
    ble $s0,1,case1
    j case2
    case1:
        li $v0,0
        j endcase
    case2:
        li $s1,2
        for:
        mult $s1,$s1
        mflo $s2
        bgt $s2,$s0,end
                div $s0,$s1
                mfhi $s3
                beq $s3,$zero,case3
                j case4
                case3: 
                    li $v0,0
                    j endcase
                case4:
            addi $s1,$s1,1
            j for
        end:
            li,$v0,1
    endcase:
    jr $ra