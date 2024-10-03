module MorraCinese(
  input reg clk,
  input reg[1:0] Primo,
  input reg[1:0] Secondo,
  input reg Inizia, 
  output reg [1:0] Manche,
  output reg [1:0] Partita
);
  
  //FSM 
  reg [2:0] status = 3'b000;
  reg [2:0] nextstatus = 3'b000;
  
  //DATAPATH
  reg [4:0] MinManche = 5'b00100;
  reg [4:0] Count = 5'b00000;
  reg [0:0] MinM = 1'b0; 
  reg [0:0] MaxM = 1'b0;
  reg [1:0] VantaggioP = 2'b00;
  reg [1:0] VantaggioS = 2'b00;

  
  always @(posedge clk) begin: Updatefsm   

    if(Inizia == 1) begin 
      status = 3'b000;
      Partita = 2'b00;
    end else begin
      status = nextstatus;
      Partita = Partita;
      
    end
  end
  
  //FSM
  always @(Manche, status, MaxM, MinM, Partita) begin: FSM 
    
    if (Manche == 2'b00) begin 
      nextstatus = status;
    end else begin 

      if (MinM == 1'b1) begin
        if (nextstatus == 3'b001 && MaxM == 1'b1)begin
          Partita = 2'b11;
        end else if (nextstatus == 3'b010 && MaxM == 1'b1)begin
          Partita = 2'b01;
        end else if (nextstatus == 3'b011 ) begin 
          Partita = 2'b01; 
        end else if (nextstatus == 3'b100 ) begin 
          Partita = 2'b01;
        end else if (nextstatus == 3'b101 && MaxM == 1'b1)begin
          Partita = 2'b10;
        end else if (nextstatus == 3'b110 ) begin 
          Partita = 2'b10; 
        end else if (nextstatus == 3'b111 ) begin 
          Partita = 2'b10;
        end
      end
      
      case(status)
        3'b000: begin
          
          if(Manche == 2'b01) begin
              nextstatus = 3'b010;
          end else if (Manche == 2'b10) begin
              nextstatus = 3'b101;
          end else if (Manche == 2'b11) begin
              nextstatus = 3'b001;
          end
        end 
          
        3'b001: begin
          if(Manche == 2'b01) begin
              nextstatus = 3'b010;
          end else if(Manche == 2'b10) begin
              nextstatus = 3'b101;
          end else if(Manche == 2'b11) begin
              nextstatus = 3'b001;
          end
        end 
        
        3'b010: begin
          
          if(Manche == 2'b01) begin
              nextstatus = 3'b011;
          end else if(Manche == 2'b10) begin
              nextstatus = 3'b001;
          end else if(Manche == 2'b11) begin
              nextstatus = 3'b010;
          end
        end
          
        3'b011: begin
          if(Manche == 2'b01) begin
            nextstatus = 3'b100;
          end else if(Manche == 2'b10) begin
            nextstatus = 3'b010;
          end else if(Manche == 2'b11) begin
            nextstatus = 3'b011;
          end
        end  
        
        3'b100: begin
          if(Manche == 2'b01) begin
              nextstatus = 3'b100;
          end else if(Manche == 2'b10) begin
              nextstatus = 3'b011;
          end else if(Manche == 2'b11) begin
            nextstatus = 3'b100;
          end
        end
          
        3'b101: begin
          
          if(Manche == 2'b01) begin
              nextstatus = 3'b001;
          end else if(Manche == 2'b10) begin
              nextstatus = 3'b110;
          end else if(Manche == 2'b11) begin
              nextstatus = 3'b101;
          end
        end
        
        3'b110 : begin 
          
          if(Manche == 2'b01) begin
            nextstatus = 3'b101;
          end else if(Manche == 2'b10) begin
            nextstatus = 3'b111;
          end else if(Manche == 2'b11) begin
            nextstatus = 3'b110;
          end
        end
        
        3'b111 : begin
          
          if(Manche == 2'b01) begin
            nextstatus = 3'b110;
          end else if(Manche == 2'b10) begin
              nextstatus = 3'b111;
          end else if(Manche == 2'b11) begin
              nextstatus = 3'b111;
          end
        end
      endcase
    end  
  end  
  
  always @(Count) begin
    
    if (Count == MinManche) begin
      MaxM = 1'b1;
    end 

    if (Count == 5'b00100) begin
      MinM = 1'b1;
    end 

  end

  always @(posedge clk) begin: Datapath
    if (Inizia) begin
      Manche = 2'b00;
      MinM = 1'b0;
      MaxM = 1'b0;
      Count = 5'b00000;
      VantaggioP = 2'b00;
      VantaggioS = 2'b00;
      MinManche = 5'b00100 + {Primo,Secondo};
    end else begin 
      
      if(Primo == VantaggioP || Secondo == VantaggioS || Primo == 2'b00 || Secondo == 2'b00) begin
        Manche = 2'b00;
      end else begin
        Count++;
        if( Primo == 2'b01 && Secondo == 2'b11 )begin
          Manche = 2'b01;
          VantaggioP = 2'b01;
          VantaggioS = 2'b00;
        end else if ( Primo == 2'b11 && Secondo == 2'b01 ) begin
          Manche = 2'b10;
          VantaggioS = 2'b01;
          VantaggioP = 2'b00;
        end else if ( Primo == 2'b11 && Secondo == 2'b10 ) begin
          VantaggioS = 2'b00;
          Manche = 2'b01;
          VantaggioP = 2'b11;
        end else if ( Primo == 2'b10 && Secondo == 2'b11 ) begin
          VantaggioP = 2'b00;
          Manche = 2'b10;
          VantaggioS = 2'b11;
        end else if ( Primo == 2'b10 && Secondo == 2'b01 ) begin
          VantaggioS = 2'b00;
          Manche = 2'b01;
          VantaggioP = 2'b10;
        end else if ( Primo == 2'b01 && Secondo == 2'b10 ) begin
          VantaggioP = 2'b00;
          Manche = 2'b10;
          VantaggioS = 2'b10;
        end else if( Primo == Secondo ) begin
          Manche = 2'b11;
          VantaggioP = 2'b00;
          VantaggioS = 2'b00;
        end
      end
    end
  end
endmodule  


