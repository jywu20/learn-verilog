#include <verilated.h>		
#include <verilated_vcd_c.h>  	
#include "Vtop.h"		// To be created by Verilator by converting top.v 

#define SIM_TIME_MAX 800 // Twice as much as the number of full clock cycles; see below
vluint64_t sim_time = 0;

int main(int argc, char **argv)
{
    // Note that all signals in the top module are now fields of the Vtop class,
    // and can be traced and set in real time as such.
    Vtop *top = new Vtop();

    // Enable signal tracing 
    Verilated::traceEverOn(true);		
    // Verilator waveform collrection
    VerilatedVcdC *trace = new VerilatedVcdC();	
    
    // Let `trace` to trace the waveform in top.
    // The argument 5 is the maximal depth of signals tracked in the simulation.
    // That's to say, signals in a submodule of a submodule of a submodule of the main module aren't traced.
    top->trace(trace, 3);			
    trace->open("waveform.vcd");
	
    // The simulation loop.
    // The input signals, rst and clk, can be set however we'd like.
    top->rst = 1;
    // We shouldn't do this.
    top->overflow = 1;
    for (sim_time = 0; sim_time < SIM_TIME_MAX; sim_time++) {
        // The unit of sim_time is half the clock period. 
        // Hence the ^= operator swaps top-> clk in the middle of a clock cycle.
        top->clk ^= 1;
        // Unlike the case in Verilog, in C++, assignment to a variable 
        // does not by default emit any event that can be listened to by 
        // an always @ (...) block.
        // Thus, each time an input signal is modified,
        // the `eval` method has to be called to update all other signals.
        top->eval(); 				        
        // Record all signals at `sim_time`.
        // This does not automatically happen, 
        // as you may want to ignore certain cycles.
        trace->dump(sim_time);
        printf("tick=%d, f=%d\n", static_cast<int>(sim_time), top->f);	
    }

    trace->close();
    return 0;
}
