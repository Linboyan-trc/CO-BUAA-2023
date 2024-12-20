#   /*
#   1.c语言
#   2.c语言转汇编
#   3.写宏
#   4.规定寄存器用途
#    */
#   /*
#   1.c语言
#       int a[10][10];//存迷宫
#       int f[10][10];//访问标记
#       int m,n;
#       int tx,ty,px,py;
#       int cnt=0;
#       int dx[]={0,0,1,-1};//方向改变
#       int dy[]={1,-1,0,0};
#   
#       void DFS(int x,int y)
#       {
#           if(x==px&&y==py){
#               cnt++;
#               return;
#           }
#           int i;
#           for(i=0;i<4;i++){
#               int xx=x+dx[i];//0
#               int yy=y+dy[i];//1
#               if(xx>=0&&xx<n&&yy>=0&&yy<m&&f[xx][yy]==0&&a[xx][yy]==0){
#                   f[xx][yy]=1;
#                   DFS(xx,yy);
#                   f[xx][yy]=0;
#               }
#           }
#       }
#   
#       int main()
#       {
#           scanf("%d %d",&n,&m);
#           int i,j;
#           for(i=0;i<n;i++){
#               for(j=0;j<m;j++){
#                   scanf("%d",&a[i][j]);
#               }
#           }
#           scanf("%d %d",&tx,&ty);
#           scanf("%d %d",&px,&py);
#           tx--;ty--;
#           px--;py--; 
#           f[tx][ty]=1;
#           DFS(tx,ty);
#           printf("%d\n",cnt);
#           return 0;
#       } 
#   2.c语言转汇编
#       1.数组
#           int a[10][10];//存迷宫
#           int f[10][10];//访问标记
#           int m,n;
#           int tx,ty,px,py;
#           int cnt=0;
#           int dx[]={0,0,1,-1};//方向改变
#           int dy[]={1,-1,0,0};
#           迷宫、标记、方向数组1、方向数组2
#           n、m
#           tx、ty、px、py
#           cnt
#       2.
#       void DFS(int x,int y)
#       {
#           1.判断是否到达终点
#               存在t6中
#               到了cnt就要++
#               if(x==px&&y==py){
#                   cnt++;
#                   return;
#               }
#           2.循环
#               循环
#                   层主拷贝
#                   判断
#                   计算下标
#                   取出
#                       置1
#                       调用
#                       复位
#               for(i=0;i<4;i++){
#                   int xx=x+dx[i];//0
#                   int yy=y+dy[i];//1
#                   if(xx>=0&&xx<n&&yy>=0&&yy<m&&f[xx][yy]==0&&a[xx][yy]==0){
#                       f[xx][yy]=1;
#                       DFS(xx,yy);
#                       f[xx][yy]=0;
#                   }
#               }
#       }
#       3.
#       int main(){
#           1.scanf("%d %d",&n,&m);
#               读n、m
#           2.两层循环读进数组a
#               读进s7
#               计算数组下标
#               存进数组
#               int i,j;
#               for(i=0;i<n;i++){
#                   for(j=0;j<m;j++){
#                       scanf("%d",&a[i][j]);
#                   }
#               }
#           3.读tx、ty、px、py
#               读进来之后
#               全部--
#               数组也都0有效
#               scanf("%d %d",&tx,&ty);
#               scanf("%d %d",&px,&py);
#               tx--;ty--;
#               px--;py--;
#           4.起点置1 
#               获取地址
#               存1进去
#               f[tx][ty]=1;
#           5.调用
#               DFS(tx,ty);
#               传参a0
#               调用
#           6.打印
#               printf("%d\n",cnt);
#               return 0;
#       } 
#   3.写宏
#       1.结束
#       2.读int
#       3.打印int
#       4.入栈
#       5.出栈
#       6.计算下标
#   4.规定寄存器用途
#   v0: a0:传参 t0:层主             s0:n
#   v1: a1:传参 t1:层主             s1:m
#       a2:     t2:层主拷贝         s2:cnt
#       a3:     t3:层主拷贝         s3:取出tx，ty，px，py专用
#               t4:方向             s4:
#               t5:方向             s5:存数组下标,存数字地址
#               t6:判断取出          s6:
#               t7:1专用            s7:读数
#               t8:循环i
#               t9:循环j;i的4倍作为方向数组地址
#   5.递归调用函数
#       a0,a1传参
#       调用
#       打印
#       结束
#   入栈
#   移到t0,t1
#       for循环
#           调用
#           复位
#       结束
#           出栈
#           jr回
#   6.入栈流程
#    */
.data
    migong: .space 256
    marking: .space 256
    tx: .space 4
    ty: .space 4
    px: .space 4
    py: .space 4
    dx: .word 0 0 1 -1
    dy: .word 1 -1 0 0

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

.macro calIndex(%hang,%lie)
    sll $s5,%hang,3
    add $s5,$s5,%lie
    sll $s5,$s5,2
.end_macro

.text
# 读n、m
    getInt($s0)
    getInt($s1)
# 存数组
    # 循环
        # 进s7
        # 计算下标
        # 存进数组
    li $t8,0
    for11:
    beq $t8,$s0,end11
        li $t9,0
        for12:
        beq $t9,$s1,end12
            getInt($s7)
            calIndex($t8,$t9)
            sw $s7,migong($s5) 
            addi $t9,$t9,1
            j for12
        end12:
        addi $t8,$t8,1
        j for11
    end11:
# 读起点终点
    # 重复四次
        # 读进s7
        # 读进后--
        # 存进对应位置
        getInt($s7)
        subi $s7,$s7,1
        la $s5,tx
        sw $s7,0($s5)

        getInt($s7)
        subi $s7,$s7,1
        la $s5,ty
        sw $s7,0($s5)

        getInt($s7)
        subi $s7,$s7,1
        la $s5,px
        sw $s7,0($s5)

        getInt($s7)
        subi $s7,$s7,1
        la $s5,py
        sw $s7,0($s5)
    # 结束后征用t0、t1
        # 取tx到t0
        # 取ty到t1
        # 计算下标
        # 置1
        la $s5,tx
        lw $t0,0($s5)
        la $s5,ty
        lw $t1,0($s5)
        calIndex($t0,$t1)
        li $t7,1
        sw $t7,marking($s5)
# 对s2置0
# 递归
       # a0,a1传参
       # 调用
       li $s2,0
       move $a0,$t0
       move $a1,$t1
       jal dfs
# 打印结束
        prtInt($s2)
        end



   # 入栈
   # ra、t0、
   #  移到t0,t1
   dfs:
        push($ra)
        push($t0)
        push($t1)
        push($t8)
        push($s5)
        move $t0,$a0
        move $t1,$a1
        # 判断是否到终点
            # 征用t8、t9存px,py
            # 如果t0,t1和t8,t9分别相等
            # 就对s2++
            la $s5,px
            lw $t8,0($s5)
            la $s5,py
            lw $t9,0($s5)
            bne $t0,$t8,jump1
            bne $t1,$t9,jump2
                addi $s2,$s2,1
            jump1:
            jump2:
        #for循环
            # 取出方向i到t4
            # 取出方向i到t5
            # 层主+方向到t2
            # 层主+方向到t3
            li $t8,0
            sll $t9,$t8,2
            for21:
            beq $t8,4,end21
                lw $t4,dx($t9)
                lw $t5,dy($t9)
                add $t2,$t0,$t4
                add $t3,$t1,$t5
                    bge $t2,0,if1
                    else1:
                        j endif
                    if1:
                        blt $t2,$s0,if2
                        else2:
                            j endif
                        if2:
                            bge $t3,0,if3
                            else3:
                                j endif
                            if3:
                            blt $t3,$s1,if4
                            else4:
                                j endif
                            if4:
                                calIndex($t2,$t3)
                                lw $t6,marking($s5)
                                beq $t6,0,if5
                                else5:
                                    j endif
                                if5:
                                    lw $t6,migong($s5)
                                    beq $t6,0,if6
                                    else6:
                                        j endif
                                    if6:
                                        li $t7,1
                                        sw $t7,marking($s5)
                                        move $a0,$t2
                                        move $a1,$t3
                                        jal dfs
                                        sw $zero,marking($s5)
                endif:
            
                addi $t8,$t8,1
                sll $t9,$t8,2
                j for21
            end21:
                pop($s5)
                pop($t8)
                pop($t1)
                pop($t0)
                pop($ra)
                jr $ra
            # 层主在横标，层主在纵标内；4个beq
            # 计算下标
            # 取出到t6
            # 计算下标
            # 取出到t6
            # 2个beq后进入
                # 计算下标
                # 存入1
                # 调用
                # 复位
        # 结束
            # 出栈
            # jr回
