# DS-Cable
This is an experimental VHDL implementation of my DS Video Capture device

Oh my goodness, please be gentle with me. This was my very first attempt implementing a somewhat bigger project in VHDL so don't be surprised that the code looks ugly.
I more or less used my brain as a hammer to make things work in the end but I'm still happy enough it actually did work. Seriously, I would need to rewrite a lot of this code, but at this point I don't have enough motivation to do it just because it's so unlikely anyone will ever use this code.

Sadly, this code is for Xilinx FPGAs in Xilinx ISE but it should be pretty simple to port it to an Altera FPGA. The only real platform depenend things I've used are the FIFOs (which I didn't want to write myself).
I'm sure Altera has a similar FIFO generator which should have a similar interface.

One big issue with this design is that the USB data buffer on the FPGA (Xilinx Spartan 6 XC6SLX4-2CPG196, perhaps the smallest Spartan 6 available) is pretty small and doesn't have a lot of BRAM.
USB transmission stability will probably greatly improve with the usage of bigger FIFOs.

A demo video can be found here:
https://www.youtube.com/watch?v=MxQT0u2nWGM
