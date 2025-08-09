TOP ?= top

compile:
	verilator -Wall $(TOP).v main.cpp --cc --exe --trace --top-module $(TOP)
	make -C obj_dir -f V$(TOP).mk V$(TOP)  

run:compile
	obj_dir/V$(TOP)

clean:
	rm -rf obj_dir
