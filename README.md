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

![tt_1](https://user-images.githubusercontent.com/63381455/158332570-50ecbde6-b595-418a-8fa5-56c026311dd9.png)


![ff_1](https://user-images.githubusercontent.com/63381455/158239272-855ca5d7-896f-4b01-aee0-eb3dd14c7e2e.png)
![ff_2](https://user-images.githubusercontent.com/63381455/158239295-1cfd6e34-9ee8-43e3-a24e-5bac35a567d1.png)
![ff_3](https://user-images.githubusercontent.com/63381455/158239400-3623104d-d870-4287-8d30-1b2b28e71089.png)


![ss_1](https://user-images.githubusercontent.com/63381455/158239460-df3f5db9-5453-4955-83cf-10619b01ed3d.png)
![ss_2](https://user-images.githubusercontent.com/63381455/158239488-8589fd72-4af6-4f50-b142-9d4560003b98.png)
![ss_3](https://user-images.githubusercontent.com/63381455/158239518-8f125841-18fe-4231-ae96-1329d0643caf.png)
![ss_4](https://user-images.githubusercontent.com/63381455/158239556-9ef751f0-b0b6-474e-bf11-6a87d3beda94.png)

Based on the openSTA analysis, a graph showing the delay of NAND gate for different PVT corners is included in the snapshot below.

![Cell_delay_NAND](https://user-images.githubusercontent.com/63381455/158380081-310389ea-b6b0-4d3f-9163-476c93d0e5d7.JPG)


!






