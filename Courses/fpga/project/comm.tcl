cd projects
vlib work

vlog counter_tb.v

eval vsim -coverage -novopt counter_tb

add wave -position insertpoint \
sim:/counter_tb/clk \
sim:/counter_tb/reset \
sim:/counter_tb/out \
sim:/counter_tb/up_down \

run 80

#coverage report -file CovReport.txt -select