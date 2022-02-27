# STA analysis using OpenSTA

# Overview

STA timing analysis verifies that the functionality of a design(chip) is intact across various conditions. The analysis consists of three parts timing checks, constraints and libraries. Timing checks includes the setup/hold timing checks – combination of various types of valid timing checks, to ensure the design specifications/constrains are met. A number of STA analysis tools both commercial and open source  are available for analysis of the design. In this repository the STA timing analysis of a simple design as per [VSD course](https://www.vlsisystemdesign.com/vsd-static-timing-analysis-ii/) is  done using the open source OpenSTA too along with the timing library provided by the Google/Skywater 130 nm PDK4]. It also uses TCL command interpreter to read the design, specify timing onstraints and print timing report. Here, the STA analysis using even corners – TT, SS and FF with fix volatge (1.8V) and temperature (25*C)  for the design is performed. OpenSTA tool being a standalone executable uses the standard design format for its analysis. 

- Operating Conditions: PVT – TT, 1.8V, 25℃
- Library - sky130_fd_sc_hd__tt_025C_1v80
- Tool - OpenSTA

## Some important terms

Arrival time: The time taken by a signal to reach the end point. Calculated at the end point.

Required time: defines the system defination eg 1GHz frequency or 1ns time period.

Hold slack: It is the differnce between the data arrival time and data required time.

Setup slack: It is the differnce between the data required time and data arrival time.

![HS_slack](https://user-images.githubusercontent.com/63381455/155879967-560a00e1-58fb-431a-ba93-86f43912dc9c.png)

Types of hold/setup analysis

 - reg2reg
 - in2reg
 - reg2out
 - in2out
 - clock gating
 - recovery/removal
 - data2data
 - latch (time borrow/time given)

Slew transistion analysis
 - Data(max/min)
 - Clock(max/min)

Load analysis
 - Fanout(max/min)
 - Capacitance(max/min)

Clock analysis
 - Skew
 - Pulse width

## Analysis of a basic design

Based on the design specification the given figure is analysed. The first step is to write a verilog program for the design and the program can be found [here]

![main_fig](https://user-images.githubusercontent.com/63381455/155880106-37238762-9551-4e05-9270-50b4c80167fa.JPG)

