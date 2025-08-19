

package hexaDisplay;
    function bit[6:0] Order(input logic[3:0] index);
        begin
            case(index)
            0: Order=  7'b1000000;
            1: Order=  7'b1111001;
            2: Order=  7'b0100100;
            3: Order=  7'b0110000;
            4: Order=  7'b0011001;
            5: Order=  7'b0010010;
            6: Order=  7'b0000010;
            7: Order=  7'b1111000;
            8: Order=  7'b0000000;
            9: Order=  7'b0010000;
            'hA:Order= 7'b0001000;
            'hB: Order=7'b0000011;
            'hC: Order=7'b1000110;
            'hD: Order=7'b0100001;
            'hE: Order=7'b0000110;
            'hF: Order=7'b0001110;
            default: Order = 7'b1000000; // 0
            endcase
        end

        
    endfunction
    

endpackage

