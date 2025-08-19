module CounterSSD_NDigits #(
    parameter N_DIGITS=8
) ( 

    input clk,
    input rstn,
    output  logic [3:0]  digit0,
    output  logic [3:0]  digit1,
    output  logic [3:0]  digit2,
    output  logic [3:0]  digit3,
    output  logic [3:0]  digit4,
    output  logic [3:0]  digit5,
    output  logic [3:0]  digit6,
    output  logic [3:0]  digit7
);

localparam width = $clog2(100_000_00)+1;
logic[width-1:0] divided_clk;
logic [4*N_DIGITS-1:0] MainCounter;

always_ff @( posedge clk or negedge rstn ) begin : CounterLogicBlock
   
    if(!rstn) begin
        MainCounter<= '0;
        divided_clk<='0;
    end
    else begin
        divided_clk<=divided_clk+1;
        if(divided_clk==100_000_00)begin//When the hold time for each digit is reached
            divided_clk<='0;
            if (MainCounter=='1) begin
                MainCounter<='0;
            end
            else MainCounter<=MainCounter+1;
            digit0 <= MainCounter[ 3: 0];
            digit1 <= MainCounter[ 7: 4];
            digit2 <= MainCounter[11: 8];
            digit3 <= MainCounter[15:12];
            digit4 <= MainCounter[19:16];
            digit5 <= MainCounter[23:20];
            digit6 <= MainCounter[27:24];
            digit7 <= MainCounter[31:28];
        end 
    end 

   
end
endmodule
//-----------------Other method of counter----------->
 // if(digit0==4'b1111) begin
    //     digit0<=4'b0000;
    //     digit1<=digit1+1;
    // end
    // else digit0<=digit0+1;
    // if(digit1==4'b1111) begin
    //     digit1<=4'b0000;
    //     digit2<=digit1+1;
    // end
    // if(digit2==4'b1111) begin
    //     digit2<=4'b0000;
    //     digit3<=digit1+1;
    // end
    // if(digit3==4'b1111) begin
    //     digit3<=4'b0000;
    //     digit4<=digit1+1;
    // end
    // if(digit4==4'b1111) begin
    //     digit4<=4'b0000;
    //     digit5<=digit1+1;
    // end
    // if(digit5==4'b1111) begin
    //     digit5<=4'b0000;
    //     digit6<=digit1+1;
    // end
    // if(digit6==4'b1111) begin
    //     digit6<=4'b0000;
    //     digit7<=digit1+1;
    // end
    // if(digit7==4'b1111) begin
    //     digit0<=4'b0000;
    //     digit1<=4'b0000;
    //     digit2<=4'b0000;
    //     digit3<=4'b0000;
    //     digit4<=4'b0000;
    //     digit5<=4'b0000;
    //     digit6<=4'b0000;
    //     digit7<=4'b0000;
    // end