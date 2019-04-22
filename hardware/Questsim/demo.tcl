quit -sim


#工程所需要的文件
vlog -sv -incr ../RTL/*.sv

vsim -t ps -voptargs="+acc"  work.soc_top_tb

log -r /*
radix 16

do wave.do

run 20us
