# Benjamin Steenkamer and Abraham McIlvaine
# CPEG 324-010
# Lab 2: VHDL Componetns - Makefile
# 4/5/17

GHDL = ./../ghdl-0.33-x86_64-linux/bin/ghdl
COMP = -a --ieee=standard
EXE = -e --ieee=standard
RUN = -r

make-addsub_4bit:
#	Compile the 2 VHDL files
	$(GHDL) $(COMP) ../addsub_4bit.vhdl
	$(GHDL) $(COMP) ../addsub_4bit_tb.vhdl
#	Generate the executable for the test bench
	$(GHDL) $(EXE) addsub_4bit_tb

test-addsub_4bit: make-addsub_4bit
#	Run the test benchRun the test bench
	$(GHDL) $(RUN) addsub_4bit_tb

test-dump-addsub_4bit: make-addsub_4bit
	$(GHDL) $(RUN) addsub_4bit_tb --vcd=addsub_4bit_tb.vcd

clean:
	rm -f *.o *.cf *.out *.vcd
