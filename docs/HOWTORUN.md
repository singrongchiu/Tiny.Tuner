# How to Run

1. Plug or wire the Digilent 7Segment PMOD so that
   AA is connected GP24
   AB is connected to GP23  
   AC is connected to GP22  
   AD is connected to GP21  
   AE is connected to GP17
   AF is connected to GP16
   AG is connected to GP15
   CAT is connected to GP14
   VCC and GND in the right places as needed
   
3. Plug or wire the PDM mic so that
   SEL is grounded
   CLK is connected to GN15
   DATA is connected to GN16
   
5. Create a bitstream file from chip.sv and constraints.lpf / pull from https://github.com/singrongchiu/TinyTuner
