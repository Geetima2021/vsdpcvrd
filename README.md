# Performance characterization for VSDBabySoC comprising of RISC-V core, PLL and DAC

STA timing analysis verifies that the functionality of a design(chip) is intact across various conditions. The analysis consists of three parts timing checks, constraints and libraries. Timing checks includes the setup/hold timing checks – combination of various types of valid timing checks, to ensure the design specifications/constrains are met. A number of STA analysis tools both commercial and open source  are available for analysis of the design. In this repository VSDBabySoC comprising of RISC-V core, PLL and DAC is analysed across different even PVT corners. Initially a design as per [VSD course](https://www.vlsisystemdesign.com/vsd-static-timing-analysis-ii/) is  done using the open source OpenSTA too along with the timing library provided by the Google/Skywater 130 nm PDK]. It also uses TCL command interpreter to read the design, specify timing onstraints and print timing report. Here, the STA analysis using even corners – TT, SS and FF is performed. OpenSTA tool being a standalone executable uses the standard design format for its analysis. 

## Some important terms

Arrival time: The time taken by a signal to reach the end point.

Required time: defines the system specification eg 1GHz frequency or 1ns time period.

Hold slack: It is the differnce between the data arrival time and data required time.

Setup slack: It is the differnce between the data required time and data arrival time.

![hold_setup_slack](https://user-images.githubusercontent.com/63381455/158803543-dcfd8986-a5e2-4440-9fd8-57cb2fc95a4a.png)


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

## Tools required

- Linux operating system
- OpenSTA : a stand alone executable for sta analysis. [This](https://github.com/The-OpenROAD-Project/OpenSTA) repository contains the information on OpenSTA tool along with its installation process
- ngspice: An open source spice simulator for electronic circuits. For installation in Windows and Linux platform visit http://ngspice.sourceforge.net/download.html . 
 
All the necessary files and libraries is included in the repository.

## Delay table of CMOS inverter

CMOS inverter being the basic building block in designing its delay table for the even corners using skywater PDK is generated below. The details of the same can be obained in [CMOS-Circuit-Design-and-SPICE-Simulation-using-SKY130-Technology](https://github.com/Geetima2021/CMOS-Circuit-Design-and-SPICE-Simulation-using-SKY130-Technology) repository.

Table1: Delay table using sky130 tt corner

| **wp/lp** | **x.wn/ln** | **Rise delay (ps)** | **Fall delay(ps)** | **Switching threshold (V)** |
|-----------|-------------|---------------------|--------------------|----------------------------
| wp/lp     | 1(wn/ln)    |         149        |         73       |   0.831765   |  
| wp/lp     | 2(wn/ln)     |         88        |         75        |   0.889839   |  
| wp/lp     | 2.5(wn/ln)   |         73        |         75        |  0.895161    |
| wp/lp     | 3(wn/ln )    |         69         |         76       |   0.895161   |       
| wp/lp     | 4(wn/ln)     |         59         |         78       |    0.916129  |     
| wp/lp     | 5(wn/ln)     |         52         |         80        |   0.929032  |      

Table2: Delay table using sky130 ff corner

| **wp/lp** | **x.wn/ln** | **Rise delay (ps)** | **Fall delay(ps)** | **switching threshold (V)** |
|-----------|-------------|---------------------|--------------------|-----------------------------|
| wp/lp     | 1(wn/ln)    |         114         |         60         | 0.809677                    |
| wp/lp     | 2(wn/ln)    |         69          |         62         | 0.877419                    |
| wp/lp     | 2.5(wn/ln)  |          60         |         62         | 0.887097                    |
| wp/lp     | 3(wn/ln)    |         54          |         62         | 0.891935                    |
| wp/lp     | 4(wn/ln)    |          48         |         64         | 0.914516                    |
| wp/lp     | 5(wn/ln)    |          42         |         65         | 0.935484                    |

Table3: Delay table using sky130 ss corner

| **wp/lp** | **x.wn/ln** | **Rise delay (ps)** | **Fall delay(ps)** | **switching threshold (V)** |
|-----------|-------------|---------------------|--------------------|-----------------------------|
| wp/lp     | 1(wn/ln)    |         226         |         93         |             0.85            |
| wp/lp     | 2(wn/ln)    |         122         |         96         |           0.906452          |
| wp/lp     | 2.5(wn/ln)  |         103         |         97         |           0.908065          |
| wp/lp     | 3(wn/ln)    |          95         |         98         |           0.903226          |
| wp/lp     | 4(wn/ln)    |          76         |         100        |           0.922581          |
| wp/lp     | 5(wn/ln)    |          64         |         102        |           0.935484          

## Analysis of a basic design

Based on the design specification the given figure is analysed. The first step is to write a verilog program for the design and it is located [here](https://github.com/Geetima2021/vsdpcvrd/tree/main/resources/files). This  verilog file is linked with the skywater timing library for analysis.

![main_fig](https://user-images.githubusercontent.com/63381455/155880106-37238762-9551-4e05-9270-50b4c80167fa.JPG)

The analysis of the above design is done using a 15 different PVT corners and the trend on the cell delay and the input slew is observed. 

1. Inorder to invoke the openSTA tool - the terminal has to be at the path where the necessary files for the design are available. 
2. Type``sta <tcl>`` for report generation
3. The verilog file ```netlist.v``` is linked to the ```sky130_fd_sc_hd__tt_025C_1v80``` library using ``` link_design <module_name>```. For the initial analysis the clock period is define as mentioned [here](https://github.com/Geetima2021/vsdpcvrd/blob/main/resources/files/my_run.tcl). 

The following command shows the setup and hold report of the design

```bash
report_checks <switch1> <switch2> switch3>
```
- The worst slack both setup and hold report can be viewed by using a single switch `-path_delay <min_max>` with the `report_checks` command.
- The worst setup slack report can be generated by just the ``report_checks`` command or else using the following switches with ``-path_delay <max>``. 
- Worst hold slack report is generated by adding ``-path_delay <min>`` to the `report_checks` command.
-  Additional switches can be used for more detail description viz `digits` number of digits after the decimal point to report. The default value is the variable default_significant_digits. List of capacitance|slew|input_pins|nets|fanout can be viewed using`-fields` switch. 

-  Detail description of the command available in openSTA can be viwed by typing ```help``` within the sta environment.

The snapshot of the setup and hold report of a PVT corner (TT,1.8V,25℃) as obtained from the OpenSTA tool and its pictorial representation is included below. It shows the worst slack report for setup and hold condition.

![SH_horizontal](https://user-images.githubusercontent.com/63381455/158808585-51225aa8-2137-4e8e-8a8e-e3b9d8a07544.png)

![set_hold_worst](https://user-images.githubusercontent.com/63381455/158806716-c6ab740d-dc11-426c-98dd-22e9ed0d42fe.png)

STA analysis of different PVT corners is performed and the report generated for each corner is included [here](https://github.com/Geetima2021/vsdpcvrd/tree/main/resources/images/OpenSTA_setup_hold). Based on the setup and hold report generated a table is created containing all the information of each PVT corner as obatined from the OpenSTA tool and the concern library. The details of the same can be found [here](https://github.com/Geetima2021/vsdpcvrd/tree/main/resources/images). We have use the NAND gate report for our analysis and observe the trend on cell delay and input slew.

![setup_hold_cd_ip](https://user-images.githubusercontent.com/63381455/165096309-20767a0f-5131-483d-bfae-4768f2ff9c6e.JPG)

The variation of the cell delay and input slew with respect to the PVT corner on NAND gate is plotted in the above graph. It shows that the input slew and the cell delay for the NAND gate follows similar trend. Both increases as we move from best case to the worst case scenario which should be the trend. The analysis holds true both for worst setup and hold NAND report as observe in the above graph.

## STA analysis of RISCV core

The verilog file for STA analysis of RISCV core is taken from this [repository](https://github.com/shivanishah269/risc-v-core/tree/master/FPGA_Implementation/verilog). Openlane is used for further analysis and the slack (setup and hold) is observed at different stages - post synthesis, post CTS and post layout. The analysis is based on the tt corner netlist across all the timing libraries. Based on the observe results a report is generated as shown in the tables and graph below. As seen from the results it is observe that the setup slacks are worse across the ss, -40c corners and the hold slack has the worse values across the ff corner. The tt corner 25C gives +3.68ns setup slack for clock of 10ns (158MHz) after clock tree propagated -post layout. It is observe that  the worse and the best corner is ssn40C1v28 and ff100C1v95 corner which is the main aim of the study.


Static timing analysis – Post sythesis pre CTS 

| **Sl No.** | **Start/end point(setup)** | **Start/end point(hold)** | **PVT corners** | **Setup slack ** | **Hold slack** |
|------------|----------------------------|---------------------------|-----------------|------------------|----------------|
| 1          | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | ff100C1v95      | 6.56             | 0.22           |
| 2          | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | ffn40C1v95      | 6.4              | 0.21           |
| 3          | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | ffn40C1v76      | 5.53             | 0.24           |
| 4          | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | ff100C1v65      | 5.54             | 0.27           |
| 5          | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | ffn40C1v65      | 4.75             | 0.28           |
| 6          | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | ffn40C1v56      | 3.85             | 0.31           |
| 7          | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | tt025C1v80      | 4.12             | 0.34           |
| 8          | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | ssn401v76       | -0.45            | 0.55           |
| 9          | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | ss1001v60       | -1.47            | 0.69           |
| 10         | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | ssn401v60       | -4.82            | 0.74           |
| 11         | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | ss1001v40       | -7.08            | 0.98           |
| 12         |  \_19483\_/ \_19715\_      | \_19561\_ / \_19560\_     | ssn401v44       | -14.56           | 1.14           |
| 13         | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | ssn401v40       | -18.84           | 1.3            |
| 14         |  \_19483\_/ \_19715\_      | \_19561\_ / \_19560\_     | ssn401v35       | -26.51           | 1.56           |
| 15         | \_19483\_ / \_19843\_      | \_19561\_ / \_19560\_     | ssn401v28       | -44.99           | 2.16           |

![post_synthesis](https://user-images.githubusercontent.com/63381455/166108491-6d3c6400-d1b8-4584-9f95-1b1288313ec0.JPG)

Static timing analysis - Post CTS

| **Sl No.** | **Start/end point(setup)** | **Start/end point(hold)** | **PVT corners** | **Setup slack ** | **Hold slack** |
|------------|----------------------------|---------------------------|-----------------|------------------|----------------|
| 1          | \_19483\_/\_20163\_        | \_19446\_/\_19445\_       | ff100C1v95      | 6.53             | 0.19           |
| 2          | \_19483\_/\_20163\_        | \_19446\_/\_19445\_       | ffn40C1v95      | 6.36             | 0.18           |
| 3          | \_19483\_/\_20163\_        | \_19446\_/\_19445\_       | ffn40C1v76      | 5.5              | 0.22           |
| 4          | \_19483\_/\_20163\_        | \_19446\_/\_19445\_       | ff100C1v65      | 5.51             | 0.24           |
| 5          | \_19483\_/\_20163\_        | \_19446\_/\_19445\_       | ffn40C1v65      | 4.72             | 0.24           |
| 6          | \_19483\_/\_20163\_        | \_19446\_/\_19445\_       | ffn40C1v56      | 3.81             | 0.27           |
| 7          | \_19483\_/\_20163\_        | \_19446\_/\_19445\_       | tt025C1v80      | 4.08             | 0.3            |
| 8          | \_19483\_/\_20163\_        | \_19446\_/\_19445\_       | ssn401v76       | -0.49            | 0.46           |
| 9          | \_19483\_/\_20163\_        | \_19446\_/\_19445\_       | ss1001v60       | -1.54            | 0.62           |
| 10         | \_19483\_/\_20163\_        | \_19446\_/\_19445\_       | ssn401v60       | -4.9             | 0.64           |
| 11         | \_19483\_/\_20163\_        | \_19446\_/\_19445\_       | ss1001v40       | -7.18            | 0.88           |
| 12         | \_19483\_/\_20003\_        | \_19683\_/\_19613\_       | ssn401v44       | -14.66           | 0.95           |
| 13         | \_19483\_/\_20163\_        | \_19446\_/\_19445\_       | ssn401v40       | -18.98           | 1.09           |
| 14         | \_19483\_/\_20003\_        | \_19446\_/\_19445\_       | ssn401v35       | -26.67           | 1.31           |
| 15         | \_19483\_/\_20163\_        | \_19683\_/\_19613\_       | ssn401v28       | -45.12           | 1.77           |

![post_cts](https://user-images.githubusercontent.com/63381455/166108663-8f6f496d-3f37-41f1-a3a9-4202ec86c9b8.JPG)

Static timing analysis –Post CTS post layout


| **Sl No.** | **Start/end point(setup)** | **Start/end point(hold)** | **PVT corners** | **Setup slack ** | **Hold slack** |
|------------|----------------------------|---------------------------|-----------------|------------------|----------------|
| 1          | \_19515\_/\_20291\_        | \_19491\_/\_19459\_       | ff100C1v95      | 6.29             | 0.11           |
| 2          | \_19515\_/\_20291\_        | \_19491\_/\_19459\_       | ffn40C1v95      | 6.1              | 0.1            |
| 3          | \_19515\_/\_20291\_        | \_19450\_/\_20772\_       | ffn40C1v76      | 5.17             | 0.11           |
| 4          | \_19515\_/\_20291\_        | \_19491\_/\_19459\_       | ff100C1v65      | 5.2              | 0.14           |
| 5          | \_19515\_/\_20291\_        | \_19450\_/\_20772\_       | ffn40C1v65      | 4.33             | 0.11           |
| 6          | \_19515\_/\_20291\_        | \_19450\_/\_20772\_       | ffn40C1v56      | 3.36             | 0.11           |
| 7          | \_19515\_/\_20291\_        | \_19450\_/\_20772\_       | tt025C1v80      | 3.68             | 0.17           |
| 8          | \_19515\_/\_20451\_        | \_19450\_/\_20772\_       | ssn401v76       | -1.2             | 0.16           |
| 9          | \_19515\_/\_20291\_        | \_19491\_/\_19459\_       | ss1001v60       | -2.22            | 0.42           |
| 10         | \_19515\_/\_20291\_        | \_19450\_/\_20772\_       | ssn401v60       | -5.89            | 0.2            |
| 11         | \_19515\_/\_20451\_        | \_19491\_/\_19459\_       | ss1001v40       | -8.13            | 0.59           |
| 12         | \_19515\_/\_20291\_        | \_19450\_/\_20772\_       | ssn401v44       | -16.18           | 0.24           |
| 13         | \_19515\_/\_20291\_        | \_19450\_/\_20772\_       | ssn401v40       | -20.7            | 0.25           |
| 14         | \_19515\_/\_20451\_        | \_19450\_/\_20772\_       | ssn401v35       | -28.74           | 0.28           |
| 15         | \_19515\_/\_20291\_        | \_19450\_/\_20772\_       | ssn401v28       | -47.93           | 0.45           |

![post_lay](https://user-images.githubusercontent.com/63381455/166108554-3ba8b388-e805-435d-9f62-888ba1de35ca.JPG)

#### On-chip variation based static timing analysis

On-chip variation (OCV) is an un-avoidable issue which occurs during the fabrication process. On chip variation results in OCV derates %tage [best and worst range] which has to be accounted during the static timing analysis. It gives a more realistic and conservative analysis. Four possible combinations is possible for data required time (DRT) and data arrival time (DAT) calculation in the clock network where the delays are either increase or reduce with certain OCV derates %tage [increase/reduce DAT: increase/reduce DRT: increase/reduce both DAT/DRT: increase DAT/DRT reduce DAT/DRT].

There are terms associated with the increase and reduce derates. 

- When the DRT/DAT in the clock path (delays) is reduced by the OCV derate %tage it is called as clock pull in.
- When the DAT/DRT in the clock path (delays) is increased by the OCV derate %tage it is called as clock push out 

In most of the industrial designs the derating in the clock network is preferable.

![ttmax_final](https://user-images.githubusercontent.com/63381455/166917165-63a77f8e-7731-422d-9447-4a5c74e62d28.PNG)

![ttmin_final](https://user-images.githubusercontent.com/63381455/166933075-4a01fc09-9891-4efe-be1a-f63f27950ef2.PNG)

![Htree](https://user-images.githubusercontent.com/63381455/166916972-83281f36-0be1-495e-8820-1fdc1bb8d3aa.PNG)









