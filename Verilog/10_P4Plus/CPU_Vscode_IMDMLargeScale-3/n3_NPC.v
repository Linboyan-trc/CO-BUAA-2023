/*四种地址选择:
    1.PC+4 
    2.jr对应的rs 
    3.beq对应的signedExt(imm[17:2]||2'b00) 
    4.jal对应的PC[31:28]||ins_index||2'b00
*/
/*输入:
    当前PC
    四种选择: rs    imm                         ins_index
    指令判断: isJr  isBranch isBranchSuccess    isJal
    输出:PC+4 NPC
*/
module NPC (
    input [31:0] PC,

    input [31:0] rs,
    input [15:0] imm,
    input [25:0] ins_index,

    input isJr,
    input isBranch,
    input isBranchSuccess,
    input isJal,

    output [31:0] PC4,
    output [31:0] NPC
);
    //输出PC+4
    assign PC4 = PC+4;
    //输出NPC
        //branch过程判断
        wire tempBranch;
        assign tempBranch=isBranch&isBranchSuccess;
    assign NPC =(isJal)?    {PC[31:28],ins_index,2'b00}:
                (tempBranch)?   PC+4+{{14{imm[15]}},imm,2'b00}:
                (isJr)? rs:
                PC+4;
endmodule