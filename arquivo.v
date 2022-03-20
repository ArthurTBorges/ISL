module maquina (clk, res, entrada, saida, ctrl); 
   
  input [6:0] entrada; 
  input clk, res, ctrl; 
  output [3:0] saida; 
  reg [3:0] estado; //Registrar os estados 
 
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
 
  initial begin 
     estado <= inic; 
  end 
 
  always @(negedge res, negedge clk) begin 
     if(res == 1'b1) estado <= inic; 
     else begin 
         case(estado) 
             inic: begin //Estado inicial 
                 if(ctrl == 1'b1) 
                     case(entrada) 
                         7'b0010000: estado <= est1; 
                         7'b0100100: estado <= est2; 
                         7'b0000010: estado <= est3; 
                         7'b1000111: estado <= est4; 
                         7'b0111010: estado <= est5; 
                         default: estado <= inic; 
                      endcase 
                 else estado <= inic; 
             end 
 
             est1: begin //Estado 1 
                 if(ctrl == 1) 
                     case(entrada) 
                         7'b0100100: estado <= est2; 
                         7'b0101001: estado <= fals; //c7 
                         default: estado <= acao; //c6 
                     endcase 
                 else estado <= est1; 
             end 
 
             est2: begin //Estado 2 
                 if(ctrl == 1) 
                     case(entrada) 
                         7'b0010000: estado <= est1; 
                         7'b0000010: estado <= est3; 
                         7'b0101001: estado <= fals; 
                         default: estado <= acao; 
                     endcase 
                 else estado <= est2; 
             end 
 
             est3: begin //Estado 3 
                 if(ctrl == 1) 
                     case(entrada) 
                         7'b0100100: estado <= est2; 
                         7'b1000111: estado <= est4; 
                         7'b0101001: estado <= fals; 
                         default: estado <= acao; 
                     endcase 
                 else estado <= est3; 
             end 
 
             est4: begin //Estado 4 
                 if(ctrl == 1) 
                     case(entrada) 
                         7'b0000010: estado <= est3; 
                         7'b0111010: estado <= est5; 
                         7'b0101001: estado <= fals; 
                         default: estado <= hora; //c8 
                     endcase 
                 else estado <= est4; 
             end 
 
             est5: begin //Estado 5 
                 if(ctrl == 1) 
                     case(entrada) 
                         7'b1000111: estado <= est4; 
                         7'b0101001: estado <= fals; 
                         default: estado <= hora; //c8 
                     endcase 
                 else estado <= est5; 
             end 
 
             acao: begin // ação/c6 
                 estado <= acao; 
             end 
 
             fals: begin // falso/c7 
                 estado <= fals; 
             end 
 
             hora: begin // hora/c8 
                 estado <= hora; 
             end 
         endcase 
     end 
  end 
 
  always @(estado) begin 
     case(estado) 
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
 
endmodule
