quit -sim

# source files
vlog -sv -incr  tb_soc.sv  ../../RTL/*.sv

vsim -t ps -voptargs="+acc"  work.tb_soc

log -r /*
radix 16

do wave.do

run 20us
