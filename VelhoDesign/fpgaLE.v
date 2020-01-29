module fpgaLE 
	( input [15:0] lut
	, input [3:0][1:0] lutIns
	, input [1:0] northOutputConf
	, input [1:0] eastOutputConf
	, input [1:0] westOutputConf
	, input [1:0] southOutputConf
	
	, input northInput
	, input eastInput
	, input westInput
	, input southInput
	
	, output northOutputLCell
	, output eastOutputLCell
	, output westOutputLCell
	, output southOutputLCell
	);
	
	wire [3:0] inputs;
	wire lutOut;
	wire northOutput, eastOutput, westOutput, southOutput;
	wire [3:0] northOutputs, eastOutputs, westOutputs, southOutputs;
	
	assign inputs = {southInput, westInput, eastInput, northInput};
	assign lutOut = lut[
		{ inputs[lutIns[3]]
		, inputs[lutIns[2]]
		, inputs[lutIns[1]]
		, inputs[lutIns[0]]
		}];
		
	assign northOutputs = {lutOut, southInput, westInput, eastInput};
	assign eastOutputs = {lutOut, southInput, westInput, northInput};
	assign westOutputs = {lutOut, southInput, eastInput, northInput};
	assign southOutputs = {lutOut, westInput, eastInput, northInput};
		
	assign northOutput = northOutputs[northOutputConf];
	assign eastOutput = eastOutputs[eastOutputConf];
	assign westOutput = westOutputs[westOutputConf];
	assign southOutput = southOutputs[southOutputConf];
	
	LCELL lcellN
		( .in(northOutput)
		, .out(northOutputLCell)
		);
		
	LCELL lcellE
		( .in(eastOutput)
		, .out(eastOutputLCell)
		);
		
	LCELL lcellW
		( .in(westOutput)
		, .out(westOutputLCell)
		);
		
	LCELL lcellS
		( .in(southOutput)
		, .out(southOutputLCell)
		);

endmodule