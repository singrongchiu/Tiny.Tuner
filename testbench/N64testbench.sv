// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
`default_nettype none

module RangeFinder_test();
  localparam DATA_WIDTH = 16;
  localparam N = 64;
  
  logic clk, rst_n;
  logic in_valid;
  logic signed [DATA_WIDTH-1:0] in_real;
  logic signed [DATA_WIDTH-1:0] in_imag;
  logic signed [DATA_WIDTH-1:0] out_real[N];
  logic signed [DATA_WIDTH-1:0] out_imag[N];
  logic out_valid;
  logic [5:0] highest_bin;
  

  Radix2FFTPipeline mypipeline(.*);
  
  initial begin
    rst_n = 1'b1;
    clk = 1'b0;
    in_valid = 1'b0;
    #1
    clk = 1'b1;
    rst_n = 1'b0;
    #3
    rst_n <= 1'b1;
    forever #1000 clk = ~clk;
  end
  
  initial begin
    @(posedge clk);
    
    for (int i = 0; i < 128; i++) begin
      if (out_valid) begin
//         for (int i = 0; i < N; i++) begin
//           $display($signed(out_real[i]));
//         end
      end
      in_valid = 1;
//       in_real = i;
//       in_imag = i + 1;
      if ((i % 8) < 4) begin
        in_real = 64; 
        in_imag = 0; 
      end else begin
        in_real = 0;
        in_imag = 0;
      end
      @(posedge clk);
      
      /*
      $display("a: %d + %dj", i, i+1);
      $display("b: %d + %dj", i+2, i+3);
      
      $display("X (a + b): %d + %dj", x_out.re, x_out.im);
      $display("Y (a - b): %d - %dj", y_out.re, y_out.im);
      */  
    end
    in_valid = 0;
    @(posedge clk);
    
    
    @(posedge clk);
    @(posedge clk);
    $display("FINISHED");
    $finish();
    
    
  end           

endmodule : RangeFinder_test
