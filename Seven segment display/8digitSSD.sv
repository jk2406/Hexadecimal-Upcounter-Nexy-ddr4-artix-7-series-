import hexaDisplay::*;
module NDigitDisplay #(
    parameter N_DIGITS=8
)(
    input  logic        clk,
    input  logic        rstn,  
    output logic [7:0]  an,
    output logic [6:0]  seg
);
    logic [3:0]  digit0;
    logic [3:0]  digit1;
    logic [3:0]  digit2;
    logic [3:0]  digit3;
    logic [3:0]  digit4;
    logic [3:0]  digit5;
    logic [3:0]  digit6;
    logic [3:0]  digit7;
    CounterSSD_NDigits NdigitCounter(
        .clk        (clk),
        .rstn       (rstn),
        .digit0    (digit0),
        .digit1    (digit1),
        .digit2    (digit2),
        .digit3    (digit3),
        .digit4    (digit4),
        .digit5    (digit5),
        .digit6    (digit6),
        .digit7    (digit7)
    );

    // Per second refreshes i.e. refreshes count
    localparam int refresh_cnt = 1000;
    // On time for each digit (based on 100 MHz clock, your original formula)
    localparam int ON_TIME = 100_000_000 / (refresh_cnt * N_DIGITS);
    localparam int CW = $clog2((ON_TIME > 1) ? ON_TIME : 2)+1;

    logic [CW-1:0] cnt;
    int index;

    always_ff @(posedge clk or negedge rstn) begin : ClockBlock
        if (!rstn) begin
            cnt   <= '0;
            index <= 0;
            an    <= 8'b11111110;   // all off except first
            seg   <= 7'b1111111;    // all segments off
        end
        else begin : MainLogicBlock
            if (cnt == CW'(ON_TIME - 1)) begin
                cnt <= '0;

                an[index]      <= 1'b1;  // disable current
                an[(index==8)?0:index+1] <= 1'b0;  // enable next
                index          <= (index==8)?0:index+1;
            end
            else begin
                cnt <= cnt + 1;          // Increment hold-time counter
            end

            // Display Logic
            case (index)
                0: seg <= Order(digit0);
                1: seg <= Order(digit1);
                2: seg <= Order(digit2);
                3: seg <= Order(digit3);
                4: seg <= Order(digit4);
                5: seg <= Order(digit5);
                6: seg <= Order(digit6);
                7: seg <= Order(digit7);
                default: seg <= Order(digit0);
            endcase
        
        end : MainLogicBlock
    end : ClockBlock
endmodule
