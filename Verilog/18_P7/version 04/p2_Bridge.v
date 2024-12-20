module Bridge(
    input [31:0]    m_data_addr_1,
    input [31:0]    m_data_wdata_1,
    input [3:0]     m_data_byteen_1,

    //////////// addr //////////////////
    output [31:0]   m_data_addr,
    output [31:0]   TC0_Addr,
    output [31:0]   TC1_Addr,
    output [31:0]   m_int_addr,
    //////////// wdata /////////////////
    output [31:0]   m_data_wdata,
    output [31:0]   TC0_Din,
    output [31:0]   TC1_Din,
    //////////// byteen ////////////////
    output [3:0]    m_data_byteen,
    output          TC0_WE,
    output          TC1_WE,
    output [3:0]    m_int_byteen,

    input [31:0]    m_data_rdata,
    input [31:0]    TC0_DOut,
    input [31:0]    TC1_DOut,

    output [31:0]   m_data_rdata_1
);
//////////////// 1.对DM,IntGenerator,TC0,TC1的地址选择 /////////////
    assign m_data_addr  = m_data_addr_1;
    assign TC0_Addr     = m_data_addr_1;
    assign TC1_Addr     = m_data_addr_1;
    assign m_int_addr   = m_data_addr_1;

///////////////////////// 2.写入数据选择 ///////////////////////////
    assign m_data_wdata = m_data_wdata_1;
    assign TC0_Din      = m_data_wdata_1;
    assign TC1_Din      = m_data_wdata_1;

///////////////////////// 3.的使能选择 ////////////////////////////
    assign m_int_byteen     = (withinIntGenerator)?  m_data_byteen_1 : 4'd0;
    assign m_data_byteen    = (withinDM)?            m_data_byteen_1 : 4'd0;
    assign TC0_WE           = (withinTC0)?          (|(m_data_byteen_1)) : 1'd0;     
    assign TC1_WE           = (withinTC1)?          (|(m_data_byteen_1)) : 1'd0;     
    wire withinDM,   withinTC0,   withinTC1,   withinIntGenerator;
    assign withinDM             = (m_data_addr_1 >= 32'h0000_0000) & (m_data_addr_1 <= 32'h0000_2fff);
    assign withinTC0            = (m_data_addr_1 >= 32'h0000_7f00) & (m_data_addr_1 <= 32'h0000_7f0b);
    assign withinTC1            = (m_data_addr_1 >= 32'h0000_7f10) & (m_data_addr_1 <= 32'h0000_7f1b);
    assign withinIntGenerator   = (m_data_addr_1 >= 32'h0000_7f20) & (m_data_addr_1 <= 332'h0000_7f23);

/////////////////// 4.对于返回CPU中DM_RD的选择 /////////////////////
    assign m_data_rdata_1   =
        (withinDM)?     m_data_rdata:
        (withinTC0)?    TC0_Din:
        (withinTC1)?    TC1_Din:
                        32'd0;

endmodule //Bridge
