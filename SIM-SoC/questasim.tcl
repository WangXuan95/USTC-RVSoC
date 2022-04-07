quit -sim

vlog -sv -incr  tb_soc.sv  ../RTL/*.sv  ../RTL/cpu/*.sv  ../RTL/uart/*.sv

vsim -t ps -voptargs="+acc"  work.tb_soc

log -r /*
radix 16

do wave.do

run 1000us
