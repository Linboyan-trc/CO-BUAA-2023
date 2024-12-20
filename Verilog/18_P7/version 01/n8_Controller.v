module Controller(
//输入**********************************
    input [31:0]    ins,
//Decode**********************************
    output          NPC_isJr_01,
    output          NPC_isJ_02,
    output          NPC_isBranch_03,
    output          CMP_Select,
    output          isMDFT,
    output          OutSelect_D,
    output [4:0]    A3_D,
    output [1:0]    Tuse_Rs_D,
    output [1:0]    Tuse_Rt_D,
    output [1:0]    Tnew_D,
    output          BD,
    output          RI,
    output          isSyscall,
//Execute**********************************
    output          ALU_B_01,
    output          ALU_immExt_02,
    output [3:0]    ALU_Op_03,
    output          MDU_Start_01,
    output [2:0]    MDU_Op_02,
    output          MDU_HI_Write_03,
    output          MDU_LO_Write_04,
    output [1:0]    OutSelect_E,
    output          Ov_E,
    output          Ld_E,
    output          St_E,
//Memory***********************************
    output          DM_WE_01,
    output [1:0]    DM_Width_02,
    output [1:0]    OutSelect_M,
    output          Ld_M,
    output          St_M,
    output          CP0_WE,
    output          isEret,
//WB**********************************

//IsRead****************************
    output          isRead_Rs,
    output          isRead_Rt
);

//1.识别指令****************************************************************

    //1.op和func
    wire [5:0]  op      =   ins[31:26];
    wire [5:0]  func    =   ins[5:0];
    wire [4:0]  Rs      =   ins[25:21];
    wire [4:0]  Rt      =   ins[20:16];
    wire [4:0]  Rd      =   ins[15:11];
    
    //2.根据op和func判断指令
    wire R;
    wire add,sub,and_,or_,slt,sltu;
    wire mult,multu,div,divu;
    wire mfhi,mflo,mthi,mtlo;
    wire jr,jalr;
    wire syscall;

    wire addi,andi,ori,lui;
    wire beq,bne;
    wire lw,lh,lb;
    wire sw,sh,sb;

    wire j,jal;

    wire CP0;
    wire mfc0,mtc0,eret;

    wire nop;

        //R
        assign R    = (op==6'b000000);
        ////////////// isCal_r //////////////
        assign add      = (R)&(func==6'b100_000);
        assign sub      = (R)&(func==6'b100_010);
        assign and_     = (R)&(func==6'b100_100);
        assign or_      = (R)&(func==6'b100_101);
        assign slt      = (R)&(func==6'b101_010);
        assign sltu     = (R)&(func==6'b101_011);
        ///////////// mult-div //////////////
        assign mult     = (R)&(func==6'b011_000);
        assign multu    = (R)&(func==6'b011_001);
        assign div      = (R)&(func==6'b011_010);
        assign divu     = (R)&(func==6'b011_011);
        assign mfhi     = (R)&(func==6'b010_000);
        assign mflo     = (R)&(func==6'b010_010);
        assign mthi     = (R)&(func==6'b010_001);
        assign mtlo     = (R)&(func==6'b010_011);
        /////////////// JReg ///////////////
        assign jr       = (R)&(func==6'b001_000);
        assign jalr     = (R)&(func==6'b001_001);
        ///////////// Syscall //////////////
        assign syscall  = (R)&(func==6'b001_100);

        //I
        /////////// isCal_i ///////////
        assign addi     = (op==6'b001_000);
        assign andi     = (op==6'b001_100);
        assign ori      = (op==6'b001_101);
        assign lui      = (op==6'b001_111);
        ////////// isBranch ///////////
        assign beq      = (op==6'b000_100);
        assign bne      = (op==6'b000_101);
        /////////// isLoad ///////////
        assign lw       = (op==6'b100_011);
        assign lh       = (op==6'b100_001);
        assign lb       = (op==6'b100_000);
        /////////// isStore ///////////
        assign sw       = (op==6'b101_011);
        assign sh       = (op==6'b101_001);
        assign sb       = (op==6'b101_000);

        //CP0
        assign CP0      = (op==6'b010_000);
        assign mfc0     = (CP0)&(Rs==5'b00000);
        assign mtc0     = (CP0)&(Rs==5'b00100);
        assign eret     = (CP0)&(func==6'b011_000);

        //J
        assign j        = (op==6'b000_010);
        assign jal      = (op==6'b000_011);
        //nop
        assign nop      = (ins==32'h0000_0000);

//2.指令分类****************************************************************

    wire isCal_r,isMd,isMf,isMt,isJReg;
    wire isCal_i,isBranch,isLoad,isStore;
    wire isLink,isJ;

    //R
    assign isCal_r  =   (add||sub||and_||or_||slt||sltu);
    assign isMd     =   (mult||multu||div||divu);
    assign isMf     =   (mfhi||mflo);
    assign isMt     =   (mthi||mtlo);
    assign isJReg   =   (jr||jalr);
    //I
    assign isCal_i  =   (addi||andi||ori||lui);
    assign isBranch =   (beq||bne);
    assign isLoad   =   (lw||lh||lb);
    assign isStore  =   (sw||sh||sb);
    //J
    assign isLink   =   (jal||jalr);
    assign isJ      =   (j||jal);

//3.给输出赋值*************************************************************

    //Decode
        ///////////////////////// NPC /////////////////////////////////
        assign NPC_isJr_01      =   isJReg;
        assign NPC_isJ_02       =   isJ;
        assign NPC_isBranch_03  =   isBranch;
        ///////////////////////// CMP /////////////////////////////////
        assign CMP_Select       =   (beq)? 0:1;
        //////////////////////// Hazard ///////////////////////////////
        assign isMDFT           = (isMd||isMf||isMt);
        ///////////////////// OutSelect D-stage ///////////////////////
        assign OutSelect_D      =   isLink;
        ///////////////////// Hazard Forward //////////////////////////
        assign A3_D = 
            (isCal_r||isMf)?        Rd:
            (isCal_i||isLoad||mfc0)?Rt:
            (isLink)?               5'd31:
                                    5'd0;
        assign Tuse_Rs_D = 
            (isJReg||isBranch)?                                 2'd0:
            (isCal_r||isMd||isMt||isCal_i||isLoad||isStore)?    2'd1:
                                                                2'd3;
        assign Tuse_Rt_D = 
            (isBranch)?         2'd0:
            (isCal_r||isMd)?    2'd1:
            (isStore||mtc0)?    2'd2:
                                2'd3;
        assign Tnew_D = 
            (isLoad||mfc0)?             2'd3:
            (isCal_r||isMf||isCal_i)?   2'd2:
            (isLink)?                   2'd1:
                                        2'd0;
        ///////////////////////// Exc ///////////////////////////                                
        assign BD = (isJ || isJReg || isBranch);
        assign RI = !(
                    isCal_r||isMd||isMf||isMt||isJReg
                ||  isCal_i||isBranch||isLoad||isStore
                ||  isJ
                ||  syscall
                ||  mfc0||mtc0||eret
                ||  nop    
                    );
        assign isSyscall = syscall;

    //Execute
        ////////////////////// ALU //////////////////////////
        assign ALU_B_01         = (isCal_i||isLoad||isStore);
        assign ALU_immExt_02    = (addi||isLoad||isStore);
        assign ALU_Op_03        = 
            (add||addi||isLoad||isStore)?   4'd0:
            (sub)?                          4'd1:
            (and_||andi)?                   4'd2:
            (or_||ori)?                     4'd3:
            (lui)?                          4'd4:
            (slt)?                          4'd5:
            (sltu)?                         4'd6:
                                            4'd0;
        ////////////////////// MDU //////////////////////////
        assign MDU_Start_01 = (isMd);
        assign MDU_Op_02    = 
            (divu)?     3'd3:
            (div)?      3'd2:
            (multu)?    3'd1:
                        3'd0;
        assign MDU_HI_Write_03 = mthi;
        assign MDU_LO_Write_04 = mtlo;
        /////////////// OutSelect E-stage ///////////////////
        assign OutSelect_E      = 
            (mflo)?                 2'd3:
            (mfhi)?                 2'd2:
            (isCal_r||isCal_i)?     2'd1:
                                    2'd0;
        ////////////////////// Exc //////////////////////////
        assign Ov_E = (add||sub||addi);
        assign Ld_E = (isLoad);
        assign St_E = (isStore);

    //Memory
        ////////////////////// DM //////////////////////////
        assign DM_WE_01     = isStore;
        assign DM_Width_02  = 
            (sb||lb)?   2'd2:
            (sh||lh)?   2'd1:
                        2'd0;
        assign OutSelect_M  = 
            (mfc0)?     2'd2:
            (isLoad)?   2'd1:
                        2'd0;
        ///////////////////// CP0 /////////////////////////
        assign Ld_M     = isLoad;
        assign St_M     = isStore;
        assign CP0_WE   = mtc0;
        assign isEret   = eret;

    //WB
        /*无*/

    //IsRead
        assign isRead_Rs = (isCal_r||isMd||isMt||isJReg||isCal_i||isBranch||isLoad||isStore);
        assign isRead_Rt = (isCal_r||isMd||isBranch||isStore||mtc0);

endmodule //Controller
