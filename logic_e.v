module logic_e(conf_func, conf_ins, all_inputs, leOut);

	input [2:0] conf_func;
	input [11:0] conf_ins;
	input [32:0] all_inputs;
	output leOut;
	
	wire all_funcs[7:0];
    wire post_lcell[7:0];
	
	and func0(all_funcs[0], all_inputs[conf_ins[5:0]], all_inputs[conf_ins[11:6]]);
	or func1(all_funcs[1], all_inputs[conf_ins[5:0]], all_inputs[conf_ins[11:6]]);
	not func2(all_funcs[2], all_inputs[conf_ins[5:0]]);
	xor func3(all_funcs[3], all_inputs[conf_ins[5:0]], all_inputs[conf_ins[11:6]]);
	xnor func4(all_funcs[4], all_inputs[conf_ins[5:0]], all_inputs[conf_ins[11:6]]);
	nand func5(all_funcs[5], all_inputs[conf_ins[5:0]], all_inputs[conf_ins[11:6]]);
	nor func6(all_funcs[6], all_inputs[conf_ins[5:0]], all_inputs[conf_ins[11:6]]);
	buf func7(all_funcs[7], all_inputs[conf_ins[5:0]]);
	
genvar i;
generate for (i = 0; i <= 7; i++)
begin : lcells
    
    LCELL lcell_inst 
        ( .in(all_funcs[i])
        , .out(post_lcell[i])
        );

end
endgenerate

LCELL out_inst
    ( .in(post_lcell[conf_func])
    , .out(leOut)
    );

endmodule