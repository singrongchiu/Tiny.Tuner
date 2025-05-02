# 18624 Final Project

This is my final project for 18624: Open Source Chip Design! 
Personal Repository: https://github.com/singrongchiu/TinyTuner 

**If you want to directly flash onto the FPGA, the above repo contains a bitstream.bit file**

## TinyTuner
A small device that can tell you the dominant frequency. Code is used with a PDM microphone and a 7segment display. 

Here is a video of the module flashed onto an FPGA: 
https://youtu.be/xEocxD9gWbU 

## IO

An IO table listing all of your inputs and outputs and their function, like the one below:

| Input/Output | Description|																
|-------------|--------------------------------------------------|
| io_in[0]    | pdm microphone data input                        |
| io_in[11:1] | unused                                           |
| io_out[6:0] | seven segment output                             |
| io_out[7]   | pdm microphone clk output (needed to drive mic)  |

## How to Test

A short description of how to test the design post-tapeout:  
The sampling frequency is 5000 Hz, and so to test each bin, we can use frequencies:  

BIN 0 : 0 - 625 Hz 
BIN 1 : 625 - 1250 Hz
BIN 2 : 1250 - 1875 Hz
BIN 3 : 1875 - 2500 Hz
BIN 4 : 2500 - 3125 Hz
BIN 5 : 3125 - 3750 Hz
BIN 6 : 3750 - 4375 Hz
BIN 7 : 4375 - 5000 Hz

Play the sine wave frequency next to the microphone, and see the bin change!  

However, since the sampling frequency is relatively low, and there are only 8 bins in this FFT, there is a lot of aliasing that happens and at times it can flicker between bins. 

## Design Choices
### Hardware
I chose to use a PDM microphone, which allows for audio to be processed digitally. I also decided to output the dominant FFT bin on a 7segment display.  

### Pipelining
I decided to pipeline the FFT by stage (which would make it slower than pipelineing by sample input like in (https://www.sciencedirect.com/science/article/pii/S2213138821008729), since I don't need a tuner to show the dominant frequency faster than my human eye can see the difference on the screen, and we wouldn't have to worry about delay as much or timing the number of clock cycles through the entire system. Our PDM microphone takes in many digital mic input cycles within one fft stage cycle, resulting in a more accurate audio sample. However, the downside is that there is more hardware associated with every stage.   

### Number of Samples
I was only able to fit an N = 8 point FFT on my FPGA board due to limited hardware resources. When we have 8 points for an FFT, we divide the sampling frequency into 8 bins. This which wouldn't allow us to tell the exact note because in lower frequencies, notes can be only differentiated by a few tens of Hz.   

### FFT Implementation
I decided to implement the version of Radix-2 FFT that does bit reversing at the end, instead of having to change the indices of my mic inputs at the start for easier implementation and faster logic. The FFT is done iteratively through log2(N) stages and butterfly operations that occur at every stage.   

## Testing
N = 64 point FFT working shown in the following testbench: 
https://www.edaplayground.com/x/M8Zf

N = 8 point FFT working shown in the following testbench (stages are rolled out):
https://edaplayground.com/x/B7y7

The output is verifiable by comparing it to an online FFT calculator like this one (https://scistatcalc.blogspot.com/2013/12/fft-calculator.html). Input the stage_real0 output into the real values list, and the outputs should match. Note that the output indices from that FFT are not bit reversed.

This is an example of how to reverse index bits in the output for N = 8.  
output 000 -> bin 000  
output 001 -> bin 100  
output 010 -> bin 010  
output 011 -> bin 110  
output 100 -> bin 001  
output 101 -> bin 101  
output 110 -> bin 011  
output 111 -> bin 111  

## Acknowledgements
Butterfly operations based on:
https://arishalreja.github.io/projects/fftprocessor/

