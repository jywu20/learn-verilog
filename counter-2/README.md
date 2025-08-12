To run the example just run `make run`.
Opening [`waveform.vcd`](waveform.vcd),
we find the value of `f`, once arriving at the maximal value it can hold,
stays at that value and can't change.
Meanwhile the `overflow` register stays at 1 after the maximal is reached,
while it stays at 0 before that.
Note that because of the architecture,
`overflow` at first is 1, but soon is set to 0.
I say "soon" and not "immediately", because `<=` takes effect at the positive edge,
and the starting point of the simulation is not considered a positive edge?