/*c语言版本
    #include <stdio.h>
    int G[8][8];    // 采用邻接矩阵存储图中的边
    int book[8];    // 用于记录每个点是否已经走过
    int m, n, ans;

    void dfs(int x) {
        book[x] = 1;
        int flag = 1, i;
        // 判断是否经过了所有的点
        for (i = 0; i < n; i++) {
            flag &= book[i];
        }
        // 判断是否形成一条哈密顿回路
        if (flag && G[x][0]) {
            ans = 1;
            return;
        }
        // 搜索与之相邻且未经过的边
        for (i = 0; i < n; i++) {
            if (!book[i] && G[x][i]) {
                dfs(i);
            }
        }
        book[x] = 0;
    }

    int main() {
        scanf("%d%d", &n, &m);
        int i, x, y;
        for (i = 0; i < m; i++) {
            scanf("%d%d", &x, &y);
            G[x - 1][y - 1] = 1;
            G[y - 1][x - 1] = 1;
        }
        // 从第0个点（编号为1）开始深搜
        dfs(0);
        printf("%d", ans);
        return 0;
    }
 */
 /*常用宏
    1.结束程序
    2.读取整数int+获取下标+连接两个点
    3.打印1和打印0
    4.sp入栈
    5.sp出栈
  */
#   v0:     a0:作为形参     t0:子函数用     s0:点数量n
#   v1:     a1:     t1:当前点地址;遍历点地址     s1:边数量m
#           a2:     t2:看看尾点是否和开头连接     s2:读取边1
#           a3:     t3:当前i是否已经访问     s3:读取边2
#           a4:     t4:当前i和层主是否连通     s4:
#           a5:     t5:当前i地址     s5:循环i;循环i
#           a6:     t6:t3和t4取与     s6:1专用
#           a7:     t7:     s7:flag看看是否已经经过了所有点;是否遍历成功