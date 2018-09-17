################################################################################
##################
## 
##  
##  Thursday  Mar 08 17:17:20 2018
##  Autor: Sievi
##  Modify: Sievi
##  
################################################################################

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]          
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE Yes [current_design]
#set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN div-2 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullnone [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 2.5 [current_design]

# Set DCI_CASCADE          
set_property slave_banks {32 34} [get_iobanks 33]


# PadFunction: IO_L12P_T1_MRCC_33 
set_property VCCAUX_IO DONTCARE [get_ports {sys_clk_p}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {sys_clk_p}]
set_property PACKAGE_PIN AD12 [get_ports {sys_clk_p}]

# PadFunction: IO_L12N_T1_MRCC_33 
set_property VCCAUX_IO DONTCARE [get_ports {sys_clk_n}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {sys_clk_n}]
set_property PACKAGE_PIN AD11 [get_ports {sys_clk_n}]

set_property PACKAGE_PIN AD23 [get_ports nreset]
set_property PACKAGE_PIN AC9  [get_ports {leds[0]}]
set_property PACKAGE_PIN AB9  [get_ports {leds[1]}]
set_property PACKAGE_PIN Y11  [get_ports {leds[2]}]
set_property PACKAGE_PIN Y10  [get_ports {leds[3]}]
set_property PACKAGE_PIN AB8  [get_ports {switches[0]}]
set_property PACKAGE_PIN AA8  [get_ports {switches[1]}]
set_property PACKAGE_PIN AB12  [get_ports {switches[2]}]
set_property PACKAGE_PIN AA12  [get_ports {switches[3]}]


set_property IOSTANDARD LVCMOS33 [get_ports nreset]
set_property IOSTANDARD LVCMOS15  [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS15  [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS15  [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS15  [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS15  [get_ports {switches[0]}]
set_property IOSTANDARD LVCMOS15  [get_ports {switches[1]}]
set_property IOSTANDARD LVCMOS15  [get_ports {switches[2]}]
set_property IOSTANDARD LVCMOS15  [get_ports {switches[3]}]

##PVO A1
##A1   ###########################################################################
##set tran A1 port
set_property PACKAGE_PIN AA27 [get_ports rec_red[7]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red[7]]

set_property PACKAGE_PIN AD26 [get_ports rec_red[6]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red[6]]

set_property PACKAGE_PIN AB28 [get_ports rec_red[5]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red[5]]

set_property PACKAGE_PIN AC27 [get_ports rec_red[4]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red[4]]

set_property PACKAGE_PIN AD27 [get_ports rec_red[3]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red[3]]

set_property PACKAGE_PIN AK26 [get_ports rec_red[2]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red[2]]

set_property PACKAGE_PIN AJ27 [get_ports rec_red[1]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red[1]]

set_property PACKAGE_PIN AD28 [get_ports rec_red[0]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red[0]]

set_property PACKAGE_PIN AK30 [get_ports rec_green[7]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green[7]]

set_property PACKAGE_PIN AJ29 [get_ports rec_green[6]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green[6]]

set_property PACKAGE_PIN AH30 [get_ports rec_green[5]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green[5]]

set_property PACKAGE_PIN AG30 [get_ports rec_green[4]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green[4]]

set_property PACKAGE_PIN AF30 [get_ports rec_green[3]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green[3]]

set_property PACKAGE_PIN AE29 [get_ports rec_green[2]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green[2]]

set_property PACKAGE_PIN Y28 [get_ports rec_green[1]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green[1]]

set_property PACKAGE_PIN AE30 [get_ports rec_green[0]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green[0]]

set_property PACKAGE_PIN AC30 [get_ports rec_blue[7]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue[7]]

set_property PACKAGE_PIN AB25 [get_ports rec_blue[6]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue[6]]

set_property PACKAGE_PIN W28 [get_ports rec_blue[5]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue[5]]

set_property PACKAGE_PIN AA26 [get_ports rec_blue[4]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue[4]]

set_property PACKAGE_PIN AA28 [get_ports rec_blue[3]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue[3]]

set_property PACKAGE_PIN AA25 [get_ports rec_blue[2]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue[2]]

set_property PACKAGE_PIN AB29 [get_ports rec_blue[1]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue[1]]

set_property PACKAGE_PIN W27 [get_ports rec_blue[0]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue[0]]

set_property PACKAGE_PIN AE28 [get_ports rec_de]
set_property IOSTANDARD LVCMOS33 [get_ports rec_de]

set_property PACKAGE_PIN AH29 [get_ports rec_hsync]
set_property IOSTANDARD LVCMOS33 [get_ports rec_hsync]

set_property PACKAGE_PIN AF28 [get_ports rec_vsync]
set_property IOSTANDARD LVCMOS33 [get_ports rec_vsync]

set_property PACKAGE_PIN AG29 [get_ports rec_clk]
set_property IOSTANDARD LVCMOS33 [get_ports rec_clk]
##################################################################################

##PVI A1
##A1   ###########################################################################
##set receive A1 port
set_property PACKAGE_PIN AB24 [get_ports tra_red[7]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red[7]]

set_property PACKAGE_PIN AB23 [get_ports tra_red[6]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red[6]]

set_property PACKAGE_PIN AC24 [get_ports tra_red[5]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red[5]]

set_property PACKAGE_PIN AD24 [get_ports tra_red[4]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red[4]]

set_property PACKAGE_PIN AD21 [get_ports tra_red[3]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red[3]]

set_property PACKAGE_PIN Y21 [get_ports tra_red[2]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red[2]]

set_property PACKAGE_PIN AD22 [get_ports tra_red[1]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red[1]]

set_property PACKAGE_PIN AA20 [get_ports tra_red[0]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red[0]]

set_property PACKAGE_PIN AA23 [get_ports tra_green[7]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green[7]]

set_property PACKAGE_PIN AC20 [get_ports tra_green[6]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green[6]]

set_property PACKAGE_PIN AB22 [get_ports tra_green[5]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green[5]]

set_property PACKAGE_PIN AC22 [get_ports tra_green[4]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green[4]]

set_property PACKAGE_PIN AC25 [get_ports tra_green[3]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green[3]]

set_property PACKAGE_PIN AE25 [get_ports tra_green[2]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green[2]]

set_property PACKAGE_PIN AF25 [get_ports tra_green[1]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green[1]]

set_property PACKAGE_PIN AG20 [get_ports tra_green[0]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green[0]]

set_property PACKAGE_PIN AH21 [get_ports tra_blue[7]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue[7]]

set_property PACKAGE_PIN AH20 [get_ports tra_blue[6]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue[6]]

set_property PACKAGE_PIN AF20 [get_ports tra_blue[5]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue[5]]

set_property PACKAGE_PIN AH25 [get_ports tra_blue[4]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue[4]]

set_property PACKAGE_PIN AJ22 [get_ports tra_blue[3]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue[3]]

set_property PACKAGE_PIN AJ23 [get_ports tra_blue[2]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue[2]]

set_property PACKAGE_PIN AJ21 [get_ports tra_blue[1]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue[1]]

set_property PACKAGE_PIN AK25 [get_ports tra_blue[0]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue[0]]

set_property PACKAGE_PIN AH24 [get_ports tra_de]
set_property IOSTANDARD LVCMOS33 [get_ports tra_de]

set_property PACKAGE_PIN AG24 [get_ports tra_hsync]
set_property IOSTANDARD LVCMOS33 [get_ports tra_hsync]

set_property PACKAGE_PIN AF22 [get_ports tra_vsync]
set_property IOSTANDARD LVCMOS33 [get_ports tra_vsync]

set_property PACKAGE_PIN AG23 [get_ports tra_clk]
set_property IOSTANDARD LVCMOS33 [get_ports tra_clk]
##################################################################################

##PVO A2
##A2   ###########################################################################
##set tran A2 port
set_property PACKAGE_PIN L17 [get_ports rec_red_a2[7]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red_a2[7]]

set_property PACKAGE_PIN J17 [get_ports rec_red_a2[6]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red_a2[6]]

set_property PACKAGE_PIN H17 [get_ports rec_red_a2[5]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red_a2[5]]

set_property PACKAGE_PIN H19 [get_ports rec_red_a2[4]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red_a2[4]]

set_property PACKAGE_PIN G19 [get_ports rec_red_a2[3]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red_a2[3]]

set_property PACKAGE_PIN G20 [get_ports rec_red_a2[2]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red_a2[2]]

set_property PACKAGE_PIN H20 [get_ports rec_red_a2[1]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red_a2[1]]

set_property PACKAGE_PIN F21 [get_ports rec_red_a2[0]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_red_a2[0]]

set_property PACKAGE_PIN F17 [get_ports rec_green_a2[7]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green_a2[7]]

set_property PACKAGE_PIN C16 [get_ports rec_green_a2[6]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green_a2[6]]

set_property PACKAGE_PIN D16 [get_ports rec_green_a2[5]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green_a2[5]]

set_property PACKAGE_PIN C17 [get_ports rec_green_a2[4]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green_a2[4]]

set_property PACKAGE_PIN A16 [get_ports rec_green_a2[3]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green_a2[3]]

set_property PACKAGE_PIN A17 [get_ports rec_green_a2[2]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green_a2[2]]

set_property PACKAGE_PIN B17 [get_ports rec_green_a2[1]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green_a2[1]]

set_property PACKAGE_PIN B20 [get_ports rec_green_a2[0]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_green_a2[0]]

set_property PACKAGE_PIN C22 [get_ports rec_blue_a2[7]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue_a2[7]]

set_property PACKAGE_PIN G22 [get_ports rec_blue_a2[6]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue_a2[6]]

set_property PACKAGE_PIN H22 [get_ports rec_blue_a2[5]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue_a2[5]]

set_property PACKAGE_PIN H21 [get_ports rec_blue_a2[4]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue_a2[4]]

set_property PACKAGE_PIN K20 [get_ports rec_blue_a2[3]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue_a2[3]]

set_property PACKAGE_PIN J19 [get_ports rec_blue_a2[2]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue_a2[2]]

set_property PACKAGE_PIN F18 [get_ports rec_blue_a2[1]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue_a2[1]]

set_property PACKAGE_PIN G18 [get_ports rec_blue_a2[0]]
set_property IOSTANDARD LVCMOS33 [get_ports rec_blue_a2[0]]

set_property PACKAGE_PIN D18 [get_ports rec_de_a2]
set_property IOSTANDARD LVCMOS33 [get_ports rec_de_a2]

set_property PACKAGE_PIN E19 [get_ports rec_hsync_a2]
set_property IOSTANDARD LVCMOS33 [get_ports rec_hsync_a2]

set_property PACKAGE_PIN D19 [get_ports rec_vsync_a2]
set_property IOSTANDARD LVCMOS33 [get_ports rec_vsync_a2]

set_property PACKAGE_PIN D17 [get_ports rec_clk_a2]
set_property IOSTANDARD LVCMOS33 [get_ports rec_clk_a2]
##################################################################################

##PVI A2
##A2   ###########################################################################
##set receive A2 port
set_property PACKAGE_PIN H24 [get_ports tra_red_a2[7]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red_a2[7]]

set_property PACKAGE_PIN G29 [get_ports tra_red_a2[6]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red_a2[6]]

set_property PACKAGE_PIN H25 [get_ports tra_red_a2[5]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red_a2[5]]

set_property PACKAGE_PIN G27 [get_ports tra_red_a2[4]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red_a2[4]]

set_property PACKAGE_PIN H26 [get_ports tra_red_a2[3]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red_a2[3]]

set_property PACKAGE_PIN F30 [get_ports tra_red_a2[2]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red_a2[2]]

set_property PACKAGE_PIN G28 [get_ports tra_red_a2[1]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red_a2[1]]

set_property PACKAGE_PIN H27 [get_ports tra_red_a2[0]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_red_a2[0]]

set_property PACKAGE_PIN E29 [get_ports tra_green_a2[7]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green_a2[7]]

set_property PACKAGE_PIN F25 [get_ports tra_green_a2[6]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green_a2[6]]

set_property PACKAGE_PIN F28 [get_ports tra_green_a2[5]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green_a2[5]]

set_property PACKAGE_PIN C30 [get_ports tra_green_a2[4]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green_a2[4]]

set_property PACKAGE_PIN C29 [get_ports tra_green_a2[3]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green_a2[3]]

set_property PACKAGE_PIN F26 [get_ports tra_green_a2[2]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green_a2[2]]

set_property PACKAGE_PIN B30 [get_ports tra_green_a2[1]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green_a2[1]]

set_property PACKAGE_PIN D29 [get_ports tra_green_a2[0]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_green_a2[0]]

set_property PACKAGE_PIN E24 [get_ports tra_blue_a2[7]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue_a2[7]]

set_property PACKAGE_PIN B28 [get_ports tra_blue_a2[6]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue_a2[6]]

set_property PACKAGE_PIN E23 [get_ports tra_blue_a2[5]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue_a2[5]]

set_property PACKAGE_PIN A28 [get_ports tra_blue_a2[4]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue_a2[4]]

set_property PACKAGE_PIN D24 [get_ports tra_blue_a2[3]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue_a2[3]]

set_property PACKAGE_PIN B27 [get_ports tra_blue_a2[2]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue_a2[2]]

set_property PACKAGE_PIN C24 [get_ports tra_blue_a2[1]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue_a2[1]]

set_property PACKAGE_PIN A27 [get_ports tra_blue_a2[0]]
set_property IOSTANDARD LVCMOS33 [get_ports tra_blue_a2[0]]

set_property PACKAGE_PIN D27 [get_ports tra_de_a2]
set_property IOSTANDARD LVCMOS33 [get_ports tra_de_a2]

set_property PACKAGE_PIN D28 [get_ports tra_hsync_a2]
set_property IOSTANDARD LVCMOS33 [get_ports tra_hsync_a2]

set_property PACKAGE_PIN E28 [get_ports tra_vsync_a2]
set_property IOSTANDARD LVCMOS33 [get_ports tra_vsync_a2]

set_property PACKAGE_PIN C27 [get_ports tra_clk_a2]
set_property IOSTANDARD LVCMOS33 [get_ports tra_clk_a2]
##################################################################################

#set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets clk_sys_inst/inst/clk_in1_clk_sys]

#NET "clk_200m" TNM_NET = "clk_200m";
#TIMESPEC "TS_clk_200m" = PERIOD "clk_200m" 5 ns HIGH 50%;      