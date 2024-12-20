# CO-BUAA-2023
### 前言
- CO教程和实验内容每一年由课程组进行一定程度的更新，本仓库仅供参考~
- 从无到有设计一份五级流水线CPU的过程中参考了许多学长学姐的博客，学长学姐们的无私帮助鼓励着后来者
- [steve-strange博客链接](https://steve-strange.github.io/)
- [volcaxiao博客链接](http://volcaxiao.top/)
- [hyggge博客链接](https://hyggge.github.io/)
- [flyinglandlord博客链接](https://flyinglandlord.github.io/2021/12/02/BUAA-CO-2021/)
- [roife博客链接](https://roife.github.io/)

### 实验课程内容
- 实验部分包括:Logisim, MIPS, Verilog基础知识, Logisim搭建单周期CPU, Verilog编写五级流水线CPU

### 各目录内容说明
- Logisim
    - 版本: Logisim2.7.1
    - 运行环境: Java
    - 内容包括: Pre课下, P0课下, P3课下-单周期CPU
- Mars
    - 版本: 请根据每年课程组提供的Mars使用最新版, 本目录所提供Mars仅供参考
    - 运行环境: Java
    - 内容包括: Pre课下, P2课下, P3,P4,P5,P6,P7测试数据, P5,P6,P7自制扩展指令
    - `Mars.jar`, 用于MIPS标准指令
    - `MarsPro.jar`, 用于在MIPS标准指令的基础上增加额外自制指令, 本目录下带有已经制作好的额外指令`swc,shl,bds,bezal,movz,bhwal,lwtbi...`
    - `MarsPro.jar`[来自往届学长仓库](https://github.com/Toby-Shi-cloud/Mars-with-BUAA-CO-extension.git)
- Verilog
    - 仿真软件: ISE, VCS
    - 简易仿真方案: Icarus Verilog生成.vcd文件，使用插件WaveTrace查看仿真波形
    - 内容包括: Pre课下, P1课下, P4课下-单周期CPU, P5课下-五级流水线CPU, P6课下-五级流水线CPU, P7课下-MIPS微系统