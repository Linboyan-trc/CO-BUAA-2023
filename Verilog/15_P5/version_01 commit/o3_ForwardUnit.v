module ForwardUnit(
    //读
    input       isRead,
    input [4:0] ReadDes,
    input [1:0] Tuse,
    //写
    input       isWrite,
    input [4:0] WriteDes,
    input [1:0] Tnew,

    //转发
    output NeedForward
);
    assign NeedForward = 
        ( isRead & isWrite
        &   (ReadDes==WriteDes) & (ReadDes!=5'd0)
        &   (Tnew==2'b00)
        );
endmodule //ForwardUnit

//读
//写u