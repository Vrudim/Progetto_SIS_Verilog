module Testbench();
  
  reg [1:0] Primo,Secondo;
  reg [0:0] Inizia;
  reg clk;
  
  wire [1:0] Manche;
  wire [1:0] Partita;
  

  MorraCinese m(
    .clk(clk),
    .Primo(Primo),
    .Secondo(Secondo),
    .Inizia(Inizia),
    .Manche(Manche),
    .Partita(Partita)
  );
  
  //testbench script 
  integer tb;
  //verilog outputs 
  integer vout;
  
  always #10 clk = ~clk;
  
  initial begin
  
    $dumpfile("dump.vcd");
    $dumpvars(1); 
  
    //genero file
    tb=$fopen("testbench.script", "w");
    vout=$fopen("outputs_verilog", "w");
    $fdisplay(tb,"read_blif FSMD.blif");
                
    /*Moveset:
       sasso = 01
       carta = 10
       forbice = 11   
    */
    
          
    // play 1
    clk = 1'b0;
    Inizia = 1'b1;

    // Manchemax = 4
    Primo = 2'b00;
    Secondo = 2'b00;

    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);

    // sasso vs carta
    Inizia = 1'b0;
    Primo = 2'b01;
    Secondo = 2'b10;
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);

    // forbice vs carta
    Primo = 2'b11;
    Secondo = 2'b10;
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);
    
    // sasso vs forbice
    Primo = 2'b01;
    Secondo = 2'b11;
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);

    // forbice vs forbice
    Primo = 2'b11;
    Secondo = 2'b11;
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);
    
    // sasso vs sasso
    Primo = 2'b01;
    Secondo = 2'b01;    
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);

    // play 2
    Inizia = 1'b1;
    Primo = 2'b00;
    Secondo = 2'b01;
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);

    // carta vs forbice
    Inizia = 1'b0;
    Primo = 2'b10;
    Secondo = 2'b11;      
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);

    // forbice vs sasso
    Primo = 2'b11;
    Secondo = 2'b01;      
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);

    // sasso vs forbici
    Primo = 2'b01;
    Secondo = 2'b11;    
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);
    
    // carta vs sasso
    Primo = 2'b10;
    Secondo = 2'b01;
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);
    
    // sasso vs forbici
    Primo = 2'b01;
    Secondo = 2'b11;
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);
     
    // play 3
    Inizia = 1'b1;
    Primo = 2'b01;
    Secondo = 2'b10;
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);
    
    // forbice vs carta
    Inizia = 1'b0;
    Primo = 2'b11;
    Secondo = 2'b10;  
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);
    
    // carta vs forbice
    Primo = 2'b10;
    Secondo = 2'b11;           
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);
    
    // play 4 interrompendo la play 3
    Inizia = 1'b1;
    Primo = 2'b11;
    Secondo = 2'b11;
    
    #20
    $display("play 4");
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);

    // sasso vs carta
    Inizia = 1'b0;
    Primo = 2'b01;
    Secondo = 2'b10;
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);

    // carta vs forbice
    Inizia = 1'b0;
    Primo = 2'b10;
    Secondo = 2'b11;
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);

    // forbice vs sasso
    Inizia = 1'b0;
    Primo = 2'b11;
    Secondo = 2'b01;
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);

    // sasso vs carta
    Inizia = 1'b0;
    Primo = 2'b01;
    Secondo = 2'b10; 
    #20
    $fdisplay(tb, "simulate %b %b %b %b %b", Primo[1], Primo[0], Secondo[1], Secondo[0],Inizia);
    $fdisplay(vout, "Outputs: %b %b %b %b", Manche[1], Manche[0], Partita[1], Partita[0]);
                
    $fdisplay( tb, "quit");
    $fclose(tb);            
    $fclose(vout);            
    $finish;            
   end             

endmodule
                
                
                
    
