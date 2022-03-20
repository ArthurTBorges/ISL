module maq_est(entra, sai, clk, rst);
    input wire clk;
    input wire rst;
    input wire [7:0]entra;
    output reg [3:0]sai;
    reg [3:0]state;

    parameter st0 = 4'b0000, st1 = 4'b0001, st2 = 4'b0010, st3 = 4'b0011, st4 = 4'b0100, st5 = 4'b0101,
    st6 = 4'b1000, st7 = 4'b1001, st8 = 4'b1010;
    parameter c1 = 8'b10010000,
              c2 = 8'b10100100,
              c3 = 8'b10000010,
              c4 = 8'b11000111,
              c5 = 8'b10111010,
              c6 = 8'b10011110, //fslso
              c7 = 8'b10101001, //acao
              c8 = 8'b10001101; //hora

    initial begin
        state <= st0;
    end
    always @ (posedge clk) begin
        if(rst == 1'b1) begin
             state <= st0;
        end
        else begin
            case (state)
                st0: begin
                    case(entra)
                        c1: begin
                            state <= st1; 
                            sai <= 4'b0001;
                        end
                        c2: begin
                            state <= st2; 
                            sai <= 4'b0010;
                        end
                        c3: begin
                            state <= st3; 
                            sai <= 4'b0011;
                        end
                        c4: begin
                            state <= st4; 
                            sai <= 4'b0100;
                        end
                        c5: begin
                            state <= st5; 
                            sai <= 4'b0101;
                        end
                    endcase
                end

                st1: begin
                    case(entra)
                        c1: begin
                            state <= st1;
                            sai <= 4'b0001;
                        end
                        c2: begin
                            state <= st2; 
                            sai <= 4'b0010; 
                        end
                        c6: begin
                            state <= st7; 
                            sai <= 4'b1001; //acao
                        end
                        default: begin
                            state <= st6; 
                            sai <= 4'b1000;
                        end
                    endcase
                end

                st2: begin
                    case(entra)
                        c1: begin
                            state <= st1; 
                            sai <= 4'b0001;
                        end
                        c2: begin
                            state <= st2; 
                            sai <= 4'b0010;
                        end
                        c3: begin
                           state <= st3; 
                           sai <= 4'b0011;
                        end 
                        c6: begin
                            state <= st7; 
                            sai <= 4'b1001; //acao
                        end
                        default: begin
                            state <= st6; 
                            sai <= 4'b1000;
                        end
                    endcase
                end

                st3: begin
                    case(entra)
                        c2: begin
                            state <= st2; 
                            sai <= 4'b0010;
                        end
                        c3: begin
                            state <= st3; 
                            sai <= 4'b0011;
                        end 
                        c4: begin
                            state <= st4; 
                            sai <= 4'b0100;
                        end
                        c6: begin
                           state <= st7; 
                           sai <= 4'b1001; //acao
                        end
                        default: begin
                            state <= st6; 
                            sai <= 4'b1000;
                        end
                    endcase
                end

                st4: begin
                    case(entra)
                        c3: begin
                            state <= st3; 
                            sai <= 4'b0011;
                        end 
                        c4: begin
                            state <= st4; 
                            sai <= 4'b0100;
                        end
                        c5: begin
                            state <= st5; 
                            sai <= 4'b0101;
                        end
                        c8: begin
                            state <= st8; 
                            sai <= 4'b1010; //hora
                        end
                        default: begin
                          state <= st6; 
                          sai <= 4'b1000;
                        end
                    endcase
                end

                st5: begin
                    case(entra) 
                        c4: begin
                            state <= st4; 
                            sai <= 4'b0100;
                        end
                        c5: begin
                            state <= st5; 
                            sai <= 4'b0101;
                        end
                        c8: begin
                            state <= st8; 
                            sai <= 4'b1010; //hora
                        end
                        default: begin
                            state <= st6; sai <= 4'b1000;
                        end
                    endcase
                end
            endcase
        end
    end

endmodule
