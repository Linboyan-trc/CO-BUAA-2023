module mips(
    input clk,                    // 时钟信号
    input reset,                  // 同步复位信号
    input interrupt,              // 外部中断信号
    output [31:0] macroscopic_pc, // 宏观 PC

    output [31:0] i_inst_addr,    // IM 读取地址（取指 PC）
    input  [31:0] i_inst_rdata,   // IM 读取数据

    output [31:0] m_data_addr,    // DM 读写地址
    input  [31:0] m_data_rdata,   // DM 读取数据
    output [31:0] m_data_wdata,   // DM 待写入数据
    output [3 :0] m_data_byteen,  // DM 字节使能信号

    output [31:0] m_int_addr,     // 中断发生器待写入地址
    output [3 :0] m_int_byteen,   // 中断发生器字节使能信号

    output [31:0] m_inst_addr,    // M 级 PC

    output        w_grf_we,       // GRF 写使能信号
    output [4 :0] w_grf_addr,     // GRF 待写入寄存器编号
    output [31:0] w_grf_wdata,    // GRF 待写入数据

    output [31:0] w_inst_addr     // W 级 PC
);
// 1.输出线路信号声明 ***********************************************************

    // CPU *************************
    wire [31:0] macroscopic_pc_cpu;
    wire [31:0] i_inst_addr_cpu;
    wire [31:0] m_data_addr_cpu;
    wire [31:0] m_data_wdata_cpu;
    wire [3:0]  m_data_byteen_cpu;
    wire [31:0] m_inst_addr_cpu;
    wire        w_grf_we_cpu;
    wire [4:0]  w_grf_addr_cpu;
    wire [31:0] w_grf_wdata_cpu;
    wire [31:0] w_inst_addr_cpu;

    // Bridge ***********************
    wire [31:0] m_data_addr_bridge,     TC0_Addr_bridge,    TC1_Addr_bridge,    m_int_addr_bridge;
    wire [31:0] m_data_wdata_bridge,    TC0_Din_bridge,     TC1_Din_bridge;
    wire [3:0]  m_data_byteen_bridge,   m_int_byteen_bridge;
    wire        TC0_WE_bridge,          TC1_WE_bridge;
    wire [31:0] m_data_rdata_bridge;

    //TC0 TC1 ***********************
    wire [31:0] TC0_DOut,   TC1_DOut;
    wire        TC0_IRQ,    TC1_IRQ;

// 2.连接tb *******************************************************************
    assign macroscopic_pc   = macroscopic_pc_cpu;

    assign i_inst_addr      = i_inst_addr_cpu;

    assign m_data_addr      = m_data_addr_bridge;
    assign m_data_wdata     = m_data_wdata_bridge;
    assign m_data_byteen    = m_data_byteen_bridge;

    assign m_int_addr       = m_int_addr_bridge;
    assign m_int_byteen     = m_int_byteen_bridge;

    assign m_inst_addr      = m_inst_addr_cpu;

    assign w_grf_we         = w_grf_we_cpu;
    assign w_grf_addr       = w_grf_addr_cpu;
    assign w_grf_wdata      = w_grf_wdata_cpu;
    assign w_inst_addr      = w_inst_addr_cpu;

// 3.连接模块 ******************************************************************
    //////////////////// CPU ////////////////////
    wire [5:0] HWInt;
    assign HWInt = {3'b0, interrupt, TC1_IRQ, TC0_IRQ};
    CPU u_CPU (
        .clk            ( clk ),
        .reset          ( reset ),
        .HWInt          ( HWInt ),

        /////////////// 宏PC ///////////////
        .macroscopic_pc (   macroscopic_pc_cpu ),

        /////////////// IM ////////////////
        .i_inst_addr    ( i_inst_addr_cpu ),
        .i_inst_rdata   ( i_inst_rdata ),

        /////////////// DM ////////////////
        .m_data_addr    ( m_data_addr_cpu ),
        .m_data_wdata   ( m_data_wdata_cpu ),
        .m_data_byteen  ( m_data_byteen_cpu ),
        .m_data_rdata   ( m_data_rdata_bridge ),
        .m_inst_addr    ( m_inst_addr_cpu ),

        ////////////// GRF ////////////////
        .w_grf_we       ( w_grf_we_cpu ),
        .w_grf_addr     ( w_grf_addr_cpu ),
        .w_grf_wdata    ( w_grf_wdata_cpu ),
        .w_inst_addr    ( w_inst_addr_cpu )
    );   

    /////////////////// Bridge ///////////////////
    Bridge u_Bridge (
        .m_data_addr_1      ( m_data_addr_cpu       ),
        .m_data_wdata_1     ( m_data_wdata_cpu      ),
        .m_data_byteen_1    ( m_data_byteen_cpu     ),

        // output: addr in DM TC0 TC1 IntGenerator
        .m_data_addr        ( m_data_addr_bridge    ),
        .TC0_Addr           ( TC0_Addr_bridge       ),
        .TC1_Addr           ( TC1_Addr_bridge       ),
        .m_int_addr         ( m_int_addr_bridge     ),

        // output: wdata in DM TC0 TC1
        .m_data_wdata       ( m_data_wdata_bridge   ),
        .TC0_Din            ( TC0_Din_bridge        ),
        .TC1_Din            ( TC1_Din_bridge        ),

        // output: byteen or WE in DM TC0 TC1 IntGenerator
        .m_data_byteen      ( m_data_byteen_bridge  ),
        .TC0_WE             ( TC0_WE_bridge         ),
        .TC1_WE             ( TC1_WE_bridge         ),
        .m_int_byteen       ( m_int_byteen_bridge   ),

        // input 
        .m_data_rdata       ( m_data_rdata          ),
        .TC0_DOut           ( TC0_DOut              ),
        .TC1_DOut           ( TC1_DOut              ),

        // output: rdata selected for CPU
        .m_data_rdata_1     ( m_data_rdata_bridge   )
    );

    //////////////////// TC0 ////////////////////
    TC u_TC0 (
        .clk    (clk),
        .reset  (reset),
        .Addr   (TC0_Addr_bridge[31:2]),
        .Din    (TC0_Din_bridge),
        .WE     (TC0_WE_bridge),

        .Dout   (TC0_DOut),
        .IRQ    (TC0_IRQ)
    );

    //////////////////// TC1 ////////////////////
    TC u_TC1 (
        .clk    (clk),
        .reset  (reset),
        .Addr   (TC1_Addr_bridge[31:2]),
        .Din    (TC1_Din_bridge),
        .WE     (TC1_WE_bridge),

        .Dout   (TC1_DOut),
        .IRQ    (TC1_IRQ)
    );
    
endmodule //mips
