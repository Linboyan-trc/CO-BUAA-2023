`include "const.v"

module _SU (
    input [31:0] D_instr,
    input [31:0] E_instr,
    input [31:0] M_instr,
    input E_HILObusy,
    output stall
);
    /////////////////////// StageD
    wire D_calc_r, D_calc_i, D_load, D_store, D_shiftS, D_j_r, D_j_noreg, D_branch, D_mt, D_mf, D_md;
    wire [4:0] D_rs_addr, D_rt_addr;
    wire [31:0] D_type;
    _CU _DInterp (
        .instr(D_instr),
        .rs_addr(D_rs_addr),
        .rt_addr(D_rt_addr),
        .calc_r(D_calc_r),
        .calc_i(D_calc_i),
        .load(D_load),
        .store(D_store),
        .j_r(D_j_r),
        .shiftS(D_shiftS),
        .branch(D_branch),
        .md(D_md),
        .mt(D_mt),
        .mf(D_mf)
    );

    wire [2:0] TuseRS =     (D_branch | D_j_r) ? 3'd0 :
                            ((D_calc_r & !D_shiftS) | D_calc_i | D_load | D_store | D_md | D_mt) ? 3'd1 :
                            3'd3;
    wire [2:0] TuseRT =     D_branch ? 3'd0 :
                            (D_calc_r | D_md) ? 3'd1 :
                            D_store  ? 3'd2 :
                            3'd3;

     /////////////////////// StageE
    wire [31:0] E_type;
    wire E_calc_r, E_calc_i, E_load, E_mf;
    wire [4:0] E_RFDst;
    _CU _EInterp (
        .instr(E_instr),
        .calc_r(E_calc_r),
        .calc_i(E_calc_i),
        .load(E_load),
        .RFDst(E_RFDst),
        .mf(E_mf)
    );

    wire [2:0] TnewE =  E_calc_r | E_calc_i | E_mf ? 3'd1 :
                        E_load ? 3'd2 :
                        3'd0;

     /////////////////////// StageM
    wire [31:0] M_type;
    wire M_load, M_calc_r, M_calc_i;
    wire [4:0] M_RFDst;
    _CU _MInterp (
        .instr(M_instr),
        .load(M_load),
        .calc_r(M_calc_r),
        .calc_i(M_calc_i),
        .RFDst(M_RFDst)
    );

    wire [2:0] TnewM =  M_load ? 3'd1 :
                        3'd0;

    // Tuse < Tnew
    wire stall_rs_e = (TuseRS < TnewE) && (D_rs_addr && D_rs_addr == E_RFDst);
    wire stall_rs_m = (TuseRS < TnewM) && (D_rs_addr && D_rs_addr == M_RFDst);
    wire stall_rs = stall_rs_e | stall_rs_m;

    wire stall_rt_e = (TuseRT < TnewE) && (D_rt_addr && D_rt_addr == E_RFDst);
    wire stall_rt_m = (TuseRT < TnewM) && (D_rt_addr && D_rt_addr == M_RFDst);
    wire stall_rt = stall_rt_e | stall_rt_m;

    wire stall_HILO = E_HILObusy & (D_md | D_mt | D_mf);

    assign stall = stall_rs | stall_rt | stall_HILO;

endmodule