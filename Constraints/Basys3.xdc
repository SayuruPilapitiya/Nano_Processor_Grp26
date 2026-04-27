# =============================================================================
# Basys 3 Master Constraints File for NanoProcessor
# =============================================================================

# -------------------- Clock (100 MHz) --------------------
set_property PACKAGE_PIN W5 [get_ports Clk_100MHz]
set_property IOSTANDARD LVCMOS33 [get_ports Clk_100MHz]
create_clock -period 10.000 -name sys_clk -waveform {0.000 5.000} [get_ports Clk_100MHz]

# -------------------- Reset Button (BTNC - Center Button) --------------------
set_property PACKAGE_PIN U18 [get_ports Reset_Btn]
set_property IOSTANDARD LVCMOS33 [get_ports Reset_Btn]

# -------------------- LEDs: R7 Value (LD3-LD0) --------------------
# R7[3] - LD3
set_property PACKAGE_PIN T24 [get_ports {LED_Output[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_Output[3]}]
# R7[2] - LD2
set_property PACKAGE_PIN T25 [get_ports {LED_Output[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_Output[2]}]
# R7[1] - LD1
set_property PACKAGE_PIN W25 [get_ports {LED_Output[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_Output[1]}]
# R7[0] - LD0
set_property PACKAGE_PIN W26 [get_ports {LED_Output[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_Output[0]}]

# -------------------- Flag LEDs --------------------
# Zero Flag - LD15
set_property PACKAGE_PIN G17 [get_ports Zero_LED]
set_property IOSTANDARD LVCMOS33 [get_ports Zero_LED]

# Carry Flag - LD14
set_property PACKAGE_PIN J17 [get_ports Carry_LED]
set_property IOSTANDARD LVCMOS33 [get_ports Carry_LED]

# Overflow Flag - LD13
set_property PACKAGE_PIN H17 [get_ports Overflow_LED]
set_property IOSTANDARD LVCMOS33 [get_ports Overflow_LED]

# -------------------- 7-Segment Display: Common Anodes --------------------
# AN3 (leftmost)
set_property PACKAGE_PIN U2 [get_ports {Anode_Out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Out[0]}]
# AN2
set_property PACKAGE_PIN U4 [get_ports {Anode_Out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Out[1]}]
# AN1
set_property PACKAGE_PIN V4 [get_ports {Anode_Out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Out[2]}]
# AN0 (rightmost)
set_property PACKAGE_PIN W4 [get_ports {Anode_Out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Out[3]}]

# -------------------- 7-Segment Display: Cathodes --------------------
# CA (segment a)
set_property PACKAGE_PIN W7 [get_ports {Seg_Out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_Out[0]}]
# CB (segment b)
set_property PACKAGE_PIN W6 [get_ports {Seg_Out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_Out[1]}]
# CC (segment c)
set_property PACKAGE_PIN U8 [get_ports {Seg_Out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_Out[2]}]
# CD (segment d)
set_property PACKAGE_PIN V8 [get_ports {Seg_Out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_Out[3]}]
# CE (segment e)
set_property PACKAGE_PIN U5 [get_ports {Seg_Out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_Out[4]}]
# CF (segment f)
set_property PACKAGE_PIN V5 [get_ports {Seg_Out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_Out[5]}]
# CG (segment g)
set_property PACKAGE_PIN U7 [get_ports {Seg_Out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_Out[6]}]

# =============================================================================
# End of Constraints
# =============================================================================