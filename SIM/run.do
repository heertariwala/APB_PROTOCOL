vsim -novopt apb_top  
add wave -position insertpoint sim:/apb_top/inf/*
run -all