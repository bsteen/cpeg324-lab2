# Benjamin Steenkamer and Abraham McIlvaine
# CPEG 324-010
# Lab 2: VHDL Componetns - Makefile
# 4/5/17

GHDL = ./../ghdl/bin/ghdl
COMP = -a --ieee=standard
EXE = -e --ieee=standard
RUN = -r

test-4bit-addsub:
#	Compile the 2 VHDL files
	$(GHDL) $(COMP) ../addsub_4bit.vhdl
	$(GHDL) $(COMP) ../addsub_4bit_tb.vhdl
#	Generate the executable for the test bench
	$(GHDL) $(EXE) addsub_4bit_tb
#	Run the test benchRun the test bench
#	$(GHDL) $(RUN) 4_bit_add_sub_tb

clean:
	rm *.o *.cf *.lst
