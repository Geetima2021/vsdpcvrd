# Performance characterization for VSDBabySoC comprising of RISC-V core, PLL and DAC


STA timing analysis verifies that the functionality of a design(chip) is intact across various conditions. The analysis consists of three parts timing checks, constraints and libraries. Timing checks includes the setup/hold timing checks – combination of various types of valid timing checks, to ensure the design specifications/constrains are met. A number of STA analysis tools both commercial and open source  are available for analysis of the design. In this repository the STA timing analysis of a simple design as per [VSD course](https://www.vlsisystemdesign.com/vsd-static-timing-analysis-ii/) is  done using the open source OpenSTA too along with the timing library provided by the Google/Skywater 130 nm PDK]. It also uses TCL command interpreter to read the design, specify timing onstraints and print timing report. Here, the STA analysis using even corners – TT, SS and FF is performed. OpenSTA tool being a standalone executable uses the standard design format for its analysis. 

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

Based on the design specification the given figure is analysed. The first step is to write a verilog program for the design and the program can be found [here](https://github.com/Geetima2021/STA-analysis-using-OpenSTA/tree/main/resources).

![main_fig](https://user-images.githubusercontent.com/63381455/155880106-37238762-9551-4e05-9270-50b4c80167fa.JPG)

Now inorder to invoke the openSTA tool - the terminal has to be at the path where the necessary files for the design are available. The verilog file ```netlist.v``` is linked to the ```sky130_fd_sc_hd__tt_025C_1v80``` library using ``` link_design <module_name>```. For the initial analysis the clock period is define as mentioned [here](https://github.com/Geetima2021/STA-analysis-using-OpenSTA/tree/main/resources/1.tcl). The following command shows the set up report of the design.



```bash
report_checks -fields {nets capacitance slew input_pins} -digits {4}
```
The snapshot of the setup report as obtained from the OpenSTA tool and its pictorial representation is included below. It shows the worst set up slack path.

![worst_slack_setup](https://user-images.githubusercontent.com/63381455/155880908-90ff0bc0-becd-49a4-91d9-4f9f5ed21ef6.png)

![worst_path](https://user-images.githubusercontent.com/63381455/155880920-e06a9415-33f6-4038-b8c7-7ef0a7e9960f.JPG)

The analysis of the above design is done using different even PVT corners. A total of 15 PVT corners is used which includes  

 
Based on the OpenSTA analysis, a graph showing the impact of different PVT corners on cell delay and input slew is shown in the snapshot below. 

![CellD_ISLew](https://user-images.githubusercontent.com/63381455/158589744-cfefe907-0720-4596-b98d-4079140821fe.JPG)







