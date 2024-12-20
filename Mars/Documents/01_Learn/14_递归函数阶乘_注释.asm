/*c语言版本
    #include <stdio.h>

    int factorial(int n)
    {
        if (n == 1) return 1;
        else return n * factorial(n - 1);
    }

    int main()
    {
        printf("%d\n", factorial(5));
        return 0;
    }
*/
/*5个常用宏
    1.结束程序
        .macro end
            li $v0,10
            syscall
        .end_macro
    2.读取一个整数int
        .macro getInt(%des)
            li $v0,5
            syscall
            move %des,$v0
        .end_macro
    3.打印一个整数int
        .macro printInt(%src)
            li $v0,1
            li $a0,%src
            syscall
        .end_macro
    4.sp入栈
        .macro push(%srd)
            sw %src,0($sp)
            subi $sp,$sp,4
        .end_macro
    5.sp出栈
        .macro pop(%des)
            addi $sp,$sp,4
            lw %des,0($sp)
        .end_macro
    【注】push后sp指向栈顶，且为空；所以pop时先对sp=sp-4
*/
/*规定寄存器功能
v0:函数返回值     a0:传递参数    t0:子函数用     s0:输入           sp:栈
                a1:传递参数    t1:子函数用      s1:存储最终结果    sp:栈
                                                              sp:栈
                                                              sp:栈
                                                              sp:栈
*/

/*
    main入口：
        1.输入需要阶乘的数n
        2.传递参数a0+调用函数+返回值结果存进s1
        3.打印结果
        4.结束程序
 */
/*
    factorial函数：
        1.把ra和t0存进栈
        2.准备函数实现
            参数进入t0
            分支控制（递归出口+递归调用）
            bne:成立去else，不成立才进入if；if作为条件出口只会执行一次
            if(条件)...
                返回值进v0
                结束递归：出栈+jr
            else...
                计算n-1
                传递参数a0+调用函数+计算乘积作为返回值保存进v0
 */
