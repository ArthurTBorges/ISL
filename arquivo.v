module maquina(clk, res, entrada, saida, ax);
    
 input wire clk, res;
 input wire [7:0]entrada;
 output reg [3:0]saida;
 output ax;
 reg res2;
 reg[3:0]state;

 parameter  
     inic = 4'b0000, //cod dos estados 
     est1 = 4'b0001, 
     est2 = 4'b0010, 
     est3 = 4'b0011, 
     est4 = 4'b0100, 
     est5 = 4'b0101, 
     fals = 4'b1000, 
     acao = 4'b1001, 
     hora = 4'b1010;
 
 parameter
     c1: 8'b10010000,
     c2: 8'b10100100,
     c3: 8'b10000010,
     c4: 8'b11000111,
     c5: 8'b10111010,
     c6: 8'b10011110, //ação
     c7: 8'b10101001, //flaso
     c8: 8'b10001101; //hora

 initial begin
     state <= inic;
 end

 always @ (posedge clk, posedge res) begin
     res2 = res;
     if(res2 = 1'b1) begin
         state <= inic;
         res2 <= 1'b0;
     end
     else begin
         case(state)
             inic: begin
                 case (entrada)
                      c1: state <= est1;
                      c2: state <= est2;
                      c3: state <= est3;
                      c4: state <= est4;
                      c5: state <= est5;
                 endcase
             end

             est1: begin
                 case(entrada)
                     c1: state <= est1;
                     c2: state <= est2;
                     c6: state <= acao;
                     default: <= fals;
                 endcase
             end

             est2: begin
                 case(entrada)
                     c1: state <= est1;
                     c2: state <= est2;
                     c3: state <= est3;
                     c6: state <= acao;
                     default: <= fals;
                 endcase
             end

             est3: begin
                 case(entrada)
                     c2: state <= est2;
                     c3: state <= est3;
                     c4: state <= est4;
                     c6: state <= acao;
                     default: <= fals;
                 endcase 
             end

             est4: begin
                 case(entrada)
                     c3: state <= est3;
                     c4: state <= est4;
                     c5: state <= est5;
                     c8: state <= hora;
                     default: <= fals;
                 endcase
             end

             est5: begin
                 case(entrada)
                     c4: state <= est4;
                     c5: state <= est5;
                     c8: state <= hora;
                     default: <= fals;
                 endcase
         endcase
     end
 end

 always @ (state) begin
     case(state)
         inic: saida = 4'b0000; 
         est1: saida = 4'b0001; 
         est2: saida = 4'b0010; 
         est3: saida = 4'b0011; 
         est4: saida = 4'b0100; 
         est5: saida = 4'b0101; 
         acao: saida = 4'b1001; 
         fals: saida = 4'b1000; 
         hora: saida = 4'b1010;
     endcase
 end

 assign ax = res2;

endmodule
