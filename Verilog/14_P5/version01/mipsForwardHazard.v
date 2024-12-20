module ForwardHazard(
    input [31:0]D,E,M,W,

    //PC ID EX MEM WB的暂停
    output enPC,enID,enEX,enMEM,enWB,
    //ID EX MEM WB的清空
    output resetID,resetEX,resetMEM,resetWB,

    //D Jr beq
    output [1:0]D_NPC_Rschoose, //00寄存器，01ALU寄存器，10DM寄存器,11jal的PC+4
    output [1:0]D_CMP_RsChoose, 
    output [1:0]D_CMP_RtChoose,

    //E ALU
    output [1:0]E_ALU_AChoose,   //00寄存器，01ALU寄存器，10DM寄存器，11jal的PC+4
    output [1:0]E_ALU_BChoose,

    //M DM store选自己流过来的rt或者W转发来的rt
    output [1:0]E_DM_RtChoose,   //在M输入选rt 00寄存器 01ALU 10DM 11jal的PC+4
    output [1:0]M_DM_WDChoose    //在M的WD选rt 00寄存器 01DM 10jal的PC+4
);
//****************************************************************************************************
    //转发
    //批次一
        //JReg Rs选择ALU结果，或者DM读出
        assign D_NPC_RsChoose = (D_JReg_E_cal_r || D_JReg_E_cal_i)?  2'b01:
                                (D_JReg_M_load)?                    2'b10:
                                (D_JReg_M_jal)?                     2'b11:
                                2'b00;
        //beq Rs选择ALU结果，或者DM读出
        assign D_CMP_RsChoose = (D_beq_E_cal_r  &&  (isClashValid(D[`rs],E[`rd])==1'b1))?  2'b01:
                                (D_beq_E_cal_i  &&  (isClashValid(D[`rs],E[`rt])==1'b1))?  2'b01:
                                (D_beq_M_load   &&  (isClashValid(D[`rs],M[`rt])==1'b1))?  2'b10:
                                (D_beq_M_jal    &&  (isClashValid(D[`rs],5'd31)==1'b1))?    2'b11:
                                2'b00;
        assign D_CMP_RtChoose = (D_beq_E_cal_r  &&  (isClashValid(D[`rt],E[`rd])==1'b1))?  2'b01:
                                (D_beq_E_cal_i  &&  (isClashValid(D[`rt],E[`rt])==1'b1))?  2'b01:
                                (D_beq_M_load   &&  (isClashValid(D[`rt],M[`rt])==1'b1))?  2'b10:
                                (D_beq_M_jal    &&  (isClashValid(D[`rt],5'd31)==1'b1))?    2'b11:
                                2'b00;
    //批次四
        //写isClash     cal_r Rs选择 
        //不写          cal_i Rs选择 load Rs选择 store Rs选择
        assign E_ALU_AChoose =  (E_cal_r_M_cal_r && (isClashValid(   E[`rs], M[`rd])==1'b1))?    2'b01:
                                (E_cal_r_M_cal_i && (isClashValid(   E[`rs], M[`rt])==1'b1))?    2'b01:
                                (E_cal_r_W_load && (isClashValid(   E[`rs], W[`rt])==1'b1))?    2'b10:
                                (E_cal_r_W_jal  && (isClashValid(   E[`rs], 5'd31)==1'b1))?     2'b11:
                            (E_cal_i_M_cal_r || E_cal_i_M_cal_i )?    2'b01:
                            (E_cal_i_W_load )?    2'b10:
                            (E_cal_i_W_jal)?      2'b11:
                                (E_load_M_cal_r || E_load_M_cal_i )?    2'b01:
                                (E_load_W_load )?    2'b10:
                                (E_load_W_jal)?      2'b11:
                            (E_store_M_cal_r || E_store_M_cal_i )?    2'b01:
                            (E_store_W_load )?    2'b10:
                            (E_store_W_jal)?      2'b11:
                            2'b00;

        //cal_r Rt选择
        assign E_ALU_BChoose =  (E_cal_r_M_cal_r && (isClashValid(   E[`rt], M[`rd])==1'b1))?    2'b01:
                                (E_cal_r_M_cal_i && (isClashValid(   E[`rt], M[`rt])==1'b1))?    2'b01:
                                (E_cal_r_W_load && (isClashValid(   E[`rt], W[`rt])==1'b1))?    2'b10:
                                (E_cal_r_W_jal  && (isClashValid(   E[`rt], 5'd31)==1'b1))?     2'b11:
                                2'b00;

    //store的rt选择
        assign E_DM_RtChoose =  (E_store_M_cal_r    ||E_store_M_cal_i)? 2'b01:
                                (E_store_W_load)?   2'b10:
                                (E_store_W_jal)?    2'b11:
                                2'b00;
        assign M_DM_WDChoose =  (M_store_W_load)?   2'b10:
                                2'b00;                        

//****************************************************************************************************

    //1.指令判断
    //cal_r JReg            000 001
    //cal_i beq load store  010 011 100 101
    //Jal                   110
    //nop                   111
    wire [2:0]DType,EType,MType,WType;
    InsJudge Dins(
        .ins    (D),
        .judge  (DType)
    );
    InsJudge Eins(
        .ins    (E),
        .judge  (EType)
    );
    InsJudge Mins(
        .ins    (M),
        .judge  (MType)
    );
    InsJudge Wins(
        .ins    (W),
        .judge  (WType)
    );
    //cal_r
	`define D_cal_r DType==3'b000
	`define E_cal_r EType==3'b000
	`define M_cal_r MType==3'b000
	`define W_cal_r WType==3'b000
    //JReg
	`define D_JReg DType==3'b001
	`define E_JReg EType==3'b001
	`define M_JReg MType==3'b001
	`define W_JReg WType==3'b001
    //cal_i
	`define D_cal_i DType==3'b010
	`define E_cal_i EType==3'b010
	`define M_cal_i_ MType==3'b010
	`define W_cal_i WType==3'b010
    //beq
	`define D_beq DType==3'b011
	`define E_beq EType==3'b011
	`define M_beq MType==3'b011
	`define W_beq WType==3'b011
    //load
	`define D_load DType==3'b100
	`define E_load EType==3'b100
	`define M_load MType==3'b100
	`define W_load WType==3'b100
    //store
	`define D_store DType==3'b101
	`define E_store EType==3'b101
	`define M_store MType==3'b101
	`define W_store WType==3'b101
    //jal
	`define D_jal DType==3'b110
	`define E_jal EType==3'b110
	`define M_jal MType==3'b110
	`define W_jal WType==3'b110
    //寄存器
    `define rs 25:21
	`define rt 20:16
	`define rd 15:11

    //2.函数
    function isClashValid;
        input [4:0]A,B;
        begin
        isClashValid = (A==B)&&(A!=0);
        end
    endfunction
    
    //3.控制信号
    //批次一:D E 处理JReg和beq
        //JReg 2+2+3+1
        wire D_JReg_E_cal_r,D_JReg_M_cal_r;
        wire D_JReg_E_cal_i,D_JReg_M_cal_i;
        wire D_JReg_E_load,D_JReg_M_load,D_JReg_W_load;
        wire D_JReg_M_jal;

        assign D_JReg_E_cal_r = (`D_JReg)   &&(`E_cal_r)    &&(isClashValid(   D[`rs], E[`rd]  )==1'b1);
        assign D_JReg_M_cal_r = (`D_JReg)   &&(`M_cal_r)    &&(isClashValid(   D[`rs], M[`rd]  )==1'b1);

        assign D_JReg_E_cal_i = (`D_JReg)   &&(`E_cal_i)    &&(isClashValid(   D[`rs], E[`rt]  )==1'b1);
        assign D_JReg_M_cal_i = (`D_JReg)   &&(`M_cal_i)    &&(isClashValid(   D[`rs], M[`rt]  )==1'b1);

        assign D_JReg_E_load = (`D_JReg)    &&(`E_load)     &&(isClashValid(   D[`rs], E[`rt]  )==1'b1);
        assign D_JReg_M_load = (`D_JReg)    &&(`M_load)     &&(isClashValid(   D[`rs], M[`rt]  )==1'b1);
        assign D_JReg_W_load = (`D_JReg)    &&(`W_load)     &&(isClashValid(   D[`rs], W[`rt]  )==1'b1);

        assign D_JReg_M_jal  = (`D_JReg)    &&(`M_jal)      &&(isClashValid(   D[`rs], 5'd31  )==1'b1);

        //beq 2+2+3+1
        wire D_beq_E_cal_r,D_beq_M_cal_r;
        wire D_beq_E_cal_i,D_beq_M_cal_i;
        wire D_beq_E_load,D_beq_M_load,D_beq_W_load;
        wire D_beq_M_jal;

        assign D_beq_E_cal_r= (`D_beq)  &&(`E_cal_r)    &&((isClashValid(    D[`rs], E[`rd] )==1'b1)||   (isClashValid(    D[`rt], E[`rd]    )==1'b1));
        assign D_beq_M_cal_r= (`D_beq)  &&(`M_cal_r)    &&((isClashValid(    D[`rs], M[`rd] )==1'b1)||   (isClashValid(    D[`rt], M[`rd]    )==1'b1));

        assign D_beq_E_cal_i= (`D_beq)  &&(`E_cal_i)    &&((isClashValid(    D[`rs], E[`rt] )==1'b1)||   (isClashValid(    D[`rt], E[`rt]    )==1'b1));
        assign D_beq_M_cal_i= (`D_beq)  &&(`M_cal_i)    &&((isClashValid(    D[`rs], M[`rt] )==1'b1)||   (isClashValid(    D[`rt], M[`rt]    )==1'b1));

        assign D_beq_E_load= (`D_beq)   &&(`E_load)     &&((isClashValid(    D[`rs], E[`rt] )==1'b1)||   (isClashValid(    D[`rt], E[`rt]    )==1'b1));
        assign D_beq_M_load= (`D_beq)   &&(`M_load)     &&((isClashValid(    D[`rs], M[`rt] )==1'b1)||   (isClashValid(    D[`rt], M[`rt]    )==1'b1));
        assign D_beq_W_load= (`D_beq)   &&(`W_load)     &&((isClashValid(    D[`rs], W[`rt] )==1'b1)||   (isClashValid(    D[`rt], W[`rt]    )==1'b1));

        assign D_beq_M_jal= (`D_beq)    &&(`M_jal)      &&((isClashValid(    D[`rs], 5'd31 )==1'b1)||   (isClashValid(    D[`rt], 5'd31    )==1'b1));

    //批次二:D E M 处理JReg和beq 已经在批次一中一起写了

    //批次三:D E M W 处理内部转发 已经在GRF实现

    //批次四:E M 处理cal_r cal_i load store的加法
        //E读cal_r 1 1 2
        wire E_cal_r_M_cal_r;
        wire E_cal_r_M_cal_i;
        wire E_cal_r_M_load,E_cal_r_W_load;

        assign E_cal_r_M_cal_r = (`E_cal_r) &&(`M_cal_r)    &&((isClashValid(   E[`rs], M[`rd])==1'b1)||  (isClashValid(  E[`rt], M[`rd])==1'b1));

        assign E_cal_r_M_cal_i = (`E_cal_r) &&(`M_cal_i)    &&((isClashValid(   E[`rs], M[`rt])==1'b1)||  (isClashValid(  E[`rt], M[`rt])==1'b1));

        assign E_cal_r_M_load = (`E_cal_r) &&(`M_load)      &&((isClashValid(   E[`rs], M[`rt])==1'b1)||  (isClashValid(  E[`rt], M[`rt])==1'b1));
        assign E_cal_r_W_load = (`E_cal_r) &&(`W_load)      &&((isClashValid(   E[`rs], W[`rt])==1'b1)||  (isClashValid(  E[`rt], W[`rt])==1'b1));
        //E读cal_i
        wire E_cal_i_M_cal_r;
        wire E_cal_i_M_cal_i;
        wire E_cal_i_M_load,E_cal_i_W_load;

        assign E_cal_i_M_cal_r = (`E_cal_i) &&(`M_cal_r)    &&(isClashValid(   E[`rs], M[`rd])==1'b1);

        assign E_cal_i_M_cal_i = (`E_cal_i) &&(`M_cal_i)    &&(isClashValid(   E[`rs], M[`rt])==1'b1);

        assign E_cal_i_M_load = (`E_cal_i) &&(`M_load)      &&(isClashValid(   E[`rs], M[`rt])==1'b1);
        assign E_cal_i_W_load = (`E_cal_i) &&(`W_load)      &&(isClashValid(   E[`rs], W[`rt])==1'b1);
        //E读load 1 1 2
        wire E_load_M_cal_r;
        wire E_load_M_cal_i;
        wire E_load_M_load,E_load_W_load;

        assign E_load_M_cal_r = (`E_load) &&(`M_cal_r)    &&(isClashValid(   E[`rs], M[`rd])==1'b1);

        assign E_load_M_cal_i = (`E_load) &&(`M_cal_i)    &&(isClashValid(   E[`rs], M[`rt])==1'b1);

        assign E_load_M_load = (`E_load) &&(`M_load)      &&(isClashValid(   E[`rs], M[`rt])==1'b1);
        assign E_load_W_load = (`E_load) &&(`W_load)      &&(isClashValid(   E[`rs], W[`rt])==1'b1);
        //E读store rs 1 1 2
        wire E_store_M_cal_r;
        wire E_store_M_cal_i;
        wire E_store_M_load,E_store_W_load;

        assign E_store_M_cal_r = (`E_store) &&(`M_cal_r)    &&(isClashValid(   E[`rs], M[`rd])==1'b1);

        assign E_store_M_cal_i = (`E_store) &&(`M_cal_i)    &&(isClashValid(   E[`rs], M[`rt])==1'b1);

        assign E_store_M_load = (`E_store) &&(`M_load)      &&(isClashValid(   E[`rs], M[`rt])==1'b1);
        assign E_store_W_load = (`E_store) &&(`W_load)      &&(isClashValid(   E[`rs], W[`rt])==1'b1);

    //批次五:E M W
        //E读cal_r 1 1 1
        wire E_cal_r_W_cal_r; 
        wire E_cal_r_W_cal_i; 
        wire E_cal_r_W_jal; 
        assign E_cal_r_W_cal_r = (`E_cal_r)   &&(`W_cal_r)    &&((isClashValid(   E[`rs], W[`rd])==1'b1)|| (isClashValid( E[`rt], W[`rd])==1'b1));
        assign E_cal_r_W_cal_i = (`E_cal_r)   &&(`W_cal_i)    &&((isClashValid(   E[`rs], W[`rt])==1'b1)|| (isClashValid( E[`rt], W[`rt])==1'b1));
        assign E_cal_r_W_jal =   (`E_cal_r)   &&(`W_cal_jal)  &&((isClashValid(   E[`rs], 5'd31)==1'b1)|| (isClashValid( E[`rt], 5'd31)==1'b1));
        //E读cal_i 1 1 1
        wire E_cal_i_W_cal_r; 
        wire E_cal_i_W_cal_i; 
        wire E_cal_i_W_jal; 
        assign E_cal_i_W_cal_r = (`E_cal_i)   &&(`W_cal_r)    &&(isClashValid(   E[`rs], W[`rd])==1'b1);
        assign E_cal_i_W_cal_i = (`E_cal_i)   &&(`W_cal_i)    &&(isClashValid(   E[`rs], W[`rt])==1'b1);
        assign E_cal_i_W_jal =   (`E_cal_i)   &&(`W_cal_jal)  &&(isClashValid(   E[`rs], 5'd31)==1'b1); 
        //E读load 1 1 1
        wire E_load_W_cal_r; 
        wire E_load_W_cal_i; 
        wire E_load_W_jal; 
        assign E_load_W_cal_r = (`E_load)   &&(`W_cal_r)    &&(isClashValid(   E[`rs], W[`rd])==1'b1);
        assign E_load_W_cal_i = (`E_load)   &&(`W_cal_i)    &&(isClashValid(   E[`rs], W[`rt])==1'b1);
        assign E_load_W_jal =   (`E_load)   &&(`W_cal_jal)  &&(isClashValid(   E[`rs], 5'd31)==1'b1); 
        //E读store rs 1 1 1
        wire E_store_W_cal_r; 
        wire E_store_W_cal_i; 
        wire E_store_W_jal; 
        assign E_store_W_cal_r = (`E_store)   &&(`W_cal_r)    &&(isClashValid(   M[`rs], W[`rd])==1'b1);
        assign E_store_W_cal_i = (`E_store)   &&(`W_cal_i)    &&(isClashValid(   M[`rs], W[`rt])==1'b1);
        assign E_store_W_jal =   (`E_store)   &&(`W_cal_jal)  &&(isClashValid(   M[`rs], 5'd31)==1'b1); 
        //E读store rt 1 1 1
        wire E_store_W_cal_r; 
        wire E_store_W_cal_i; 
        wire E_store_W_jal; 
        assign E_store_W_cal_r = (`E_store)   &&(`W_cal_r)    &&(isClashValid(   E[`rt], W[`rd])==1'b1);
        assign E_store_W_cal_i = (`E_store)   &&(`W_cal_i)    &&(isClashValid(   E[`rt], W[`rt])==1'b1);
        assign E_store_W_jal =   (`E_store)   &&(`W_cal_jal)  &&(isClashValid(   E[`rt], 5'd31)==1'b1); 


    //批次六:W M
        //M读store rt 1 1 1
        wire M_store_W_cal_r; 
        wire M_store_W_cal_i; 
        wire M_store_W_load; 
        assign M_store_W_cal_r = (`M_store)   &&(`W_cal_r)      &&(isClashValid(   M[`rt],  W[`rd])==1'b1);
        assign M_store_W_cal_i = (`M_store)   &&(`W_cal_i)      &&(isClashValid(   M[`rt],  W[`rt])==1'b1);
        assign M_store_W_load =  (`M_store)   &&(`W_cal_load)   &&(isClashValid(   M[`rt],  W[`rt])==1'b1); 

    //需要暂停:1.pc 2.ID ID+EX 3.EX或者MEM
    assign enPC =   ~((D_JReg_E_cal_r  ||D_JReg_E_cal_r ||D_JReg_E_load
                    ||D_beq_E_cal_r  ||D_beq_E_cal_i  ||D_beq_E_load)  //D E;JReg beq
                    ||(D_JReg_M_load ||D_JReg_M_load)                 //D E M;JReg beq
                    ||(E_cal_r_M_load||E_cal_i_M_load ||E_load_M_load  ||E_store_M_load)); //E M;cal_r cal_i load store'rs

    assign enID =   ~((D_JReg_E_cal_r  ||D_JReg_E_cal_r ||D_JReg_E_load
                    ||D_beq_E_cal_r  ||D_beq_E_cal_i  ||D_beq_E_load)  //D E;JReg beq
                    ||(D_JReg_M_load ||D_JReg_M_load)                 //D E M;JReg beq
                    ||(E_cal_r_M_load||E_cal_i_M_load ||E_load_M_load  ||E_store_M_load)); //E M;cal_r cal_i load store'rs

    assign enEX =   ~((E_cal_r_M_load||E_cal_i_M_load ||E_load_M_load  ||E_store_M_load)); //E M;cal_r cal_i load store'rs

    assign enMEM    = 1;
    assign enWB     = 1;

    assign resetID  = 0;
    assign resetEX  =   (D_JReg_E_cal_r  ||D_JReg_E_cal_r ||D_JReg_E_load
                        ||D_beq_E_cal_r  ||D_beq_E_cal_i  ||D_beq_E_load)  //D E;JReg beq
                        ||(D_JReg_M_load ||D_JReg_M_load);                 //D E M;JReg beq

    assign resetMEM =   (E_cal_r_M_load||E_cal_i_M_load ||E_load_M_load  ||E_store_M_load); //E M;cal_r cal_i load store'rs
    assign resetWB  = 0;

endmodule
