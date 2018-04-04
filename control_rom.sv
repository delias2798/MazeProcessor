import lc3b_types::*;

module control_rom
(
	input lc3b_opcode opcode,
	input lc3b_reg dest_register,
	input logic ir4,
	input logic ir5,
	input logic ir11,
	output lc3b_control_word ctrl
);

always_comb
begin
	/* Default assignments */
	ctrl.opcode = opcode;

	ctrl.load_regfile = 0;
	ctrl.sr2mux_sel = 2'b00;
	ctrl.sr2mux2_sel = 0;
	ctrl.dest_register = dest_register;
	ctrl.load_hazard = 0;

	ctrl.bradd2mux_sel = 0;
	ctrl.aluop = alu_pass;
	ctrl.alumux_sel = 0;

	ctrl.alu_forward = 0;
	ctrl.newpcmux_sel = 2'b00;
	
	ctrl.regfilemux_sel = 3'b000;
	ctrl.load_cc = 0;

	/* Assign control signals based on opcode */
	case(opcode)
		op_add: begin
			/* DR <= SRA + SEXT(IMM5) */
			if (ir5 == 1)
			begin
				ctrl.sr2mux_sel = 2'b10;
				ctrl.sr2mux2_sel = 1;
			end
			/* DR <= SRA + SRB */
			ctrl.aluop = alu_add;
			ctrl.alu_forward = 1;
			ctrl.load_regfile = 1;
			ctrl.load_cc = 1;
		end

		op_and: begin
			/* DR <= SRA & SEXT(IMM5) */
			if (ir5 == 1)
			begin
				ctrl.sr2mux_sel = 2'b10;
				ctrl.sr2mux2_sel = 1;
			end
			/* DR <= SRA & SRB */
			ctrl.aluop = alu_and;
			ctrl.alu_forward = 1;
			ctrl.load_regfile = 1;
			ctrl.load_cc = 1;
		end

		op_not: begin
			/* DR <= NOT(SRA) */
			ctrl.aluop = alu_not;
			ctrl.alu_forward = 1;
			ctrl.load_regfile = 1;
			ctrl.load_cc = 1;
		end

		op_br: begin
			ctrl.newpcmux_sel = 2'b01;
		end

		op_ldr: begin
			/* DR = memWord[BaseR + (SEXT(offset6) << 1)] */
			ctrl.sr2mux2_sel = 1;
			ctrl.aluop = alu_add;
			ctrl.regfilemux_sel = 3'b001;
			ctrl.load_hazard = 1;
			ctrl.load_regfile = 1;
			ctrl.load_cc = 1;
		end

		op_str: begin
			/* memWord[BaseR + (SEXT(offset6) << 1)] = SR */
			ctrl.sr2mux2_sel = 1;
			ctrl.aluop = alu_add;
		end

		op_jmp: begin
			/* PC = BaseR */
			ctrl.bradd2mux_sel = 1;
		end

		op_jsr: begin
			/* R7 <= PC */
			ctrl.dest_register = 3'b111;
			ctrl.regfilemux_sel = 3'b010;
			ctrl.alu_forward = 1;
			ctrl.load_regfile = 1;
			if (ir11 == 0)
				ctrl.bradd2mux_sel = 1; /* PC = BaseR */
		end

		op_ldb: begin
			/* DR = ZEXT(mem[BaseR + SEXT(offset6)]) */
			ctrl.sr2mux_sel = 2'b01;
			ctrl.sr2mux2_sel = 1;
			ctrl.aluop = alu_add;
			ctrl.regfilemux_sel = 3'b100;
			ctrl.load_hazard = 1;
			ctrl.load_regfile = 1;
			ctrl.load_cc = 1;
		end

		op_lea: begin
			/* DR = PC + (SEXT(PCoffset9) << 1) */
			ctrl.regfilemux_sel = 3'b011;
			ctrl.alu_forward = 1;
			ctrl.load_regfile = 1;
			ctrl.load_cc = 1;
		end

		op_shf: begin
			/* DR = SR >> / << imm4 */
			ctrl.sr2mux_sel = 2'b11;
			ctrl.sr2mux2_sel = 1;
			if (ir4 == 0)
				ctrl.aluop = alu_sll;
			else
			begin
				if (ir5 == 0)
					ctrl.aluop = alu_srl;
				else
					ctrl.aluop = alu_sra;
			end
			ctrl.alu_forward = 1;
			ctrl.load_regfile = 1;
			ctrl.load_cc = 1;
		end

		op_stb: begin
			/* mem[BaseR + SEXT(offset6)] = SR[7:0] */
			ctrl.sr2mux_sel = 2'b01;
			ctrl.sr2mux2_sel = 1;
			ctrl.aluop = alu_add;
		end

		op_trap: begin
			/* R7 = PC */
			ctrl.dest_register = 3'b111;
			ctrl.regfilemux_sel = 3'b010;
			ctrl.alu_forward = 1;
			ctrl.load_regfile = 1;
			/* PC = memWord[ZEXT(trapvect8) << 1]; */
			ctrl.alumux_sel = 1;
			ctrl.newpcmux_sel = 2'b10;
		end

		op_ldi: begin
			/* DR = memWord[memWord[BaseR + (SEXT(offset6) << 1)]] */
			ctrl.sr2mux2_sel = 1;
			ctrl.aluop = alu_add;
			ctrl.regfilemux_sel = 3'b001;
			ctrl.load_hazard = 1;
			ctrl.load_regfile = 1;
			ctrl.load_cc = 1;
		end

		op_sti: begin
			/* memWord[memWord[BaseR + (SEXT(offset6) << 1)]] = SR */
			ctrl.sr2mux2_sel = 1;
			ctrl.aluop = alu_add;
		end

		default: begin
			ctrl = 0;   /* Unknown opcode, set control word to zero */
		end
	endcase
end

endmodule : control_rom