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
<!---  To view the best hold slack either switch ``min_fall/min_rise`` is used with `report_checks` command depending on the worst slack end point edge
-  To view the best setup slack either switch ``max_fall/max_rise`` is used with `report_checks` command depending on the worst slack end point edge-->
-  Detail description of the command available in openSTA can be viwed by typing ```help``` within the sta environment.

The snapshot of the setup and hold report of a PVT corner (TT,1.8V,25℃) as obtained from the OpenSTA tool and its pictorial representation is included below. It shows the worst slack report for setup and hold condition.

![SH_horizontal](https://user-images.githubusercontent.com/63381455/158808585-51225aa8-2137-4e8e-8a8e-e3b9d8a07544.png)

![set_hold_worst](https://user-images.githubusercontent.com/63381455/158806716-c6ab740d-dc11-426c-98dd-22e9ed0d42fe.png)

STA analysis of different PVT corners is performed and the report generated for each corner is included [here](https://github.com/Geetima2021/vsdpcvrd/tree/main/resources/images/OpenSTA_setup_hold). Based on the setup and hold report generated a table is created containing all the information of each PVT corner as obatined from the OpenSTA tool and the concern library. The details of the same can be found [here](https://github.com/Geetima2021/vsdpcvrd/tree/main/resources/images). We have use the NAND gate report for our analysis and observe the trend on cell delay and input slew.

![setup_hold_cd_ip](https://user-images.githubusercontent.com/63381455/165096309-20767a0f-5131-483d-bfae-4768f2ff9c6e.JPG)


The variation of the cell delay and input slew with respect to the PVT corner on NAND gate is plotted in the above graph. It shows that the input slew and the cell delay for the NAND gate follows similar trend. Both increases as we move from best case to the worst case scenario which should be the trend. The analysis holds true both for worst setup and hold NAND report as observe in the above graph.

## STA analysis of RISCV core

The verilog file for STA analysis of RISCV core is taken from this [repository](https://github.com/shivanishah269/risc-v-core/tree/master/FPGA_Implementation/verilog). Initially the synthesized verilog file is created using yosys. 

Static timing analysis – Post sythesis pre CTS 

| **Sl No.** | **Start/end  point (setup)** | **Start/end  point (hold)** | **PVT corners** | **Setup  slack** | **Hold  slack** |
|:----------:|------------------------------|-----------------------------|-----------------|------------------|-----------------|
|      1     | 19483_ / _19843              | 19561_ / _19560             | ff100C1v95      | 6.56             | 0.22            |
|      2     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v95      | 6.4              | 0.21            |
|      3     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v76      | 5.53             | 0.24            |
|      4     | 19483_ / _19843              | 19561_ / _19560             | ff100C1v65      | 5.54             | 0.27            |
|      5     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v65      | 4.75             | 0.28            |
|      6     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v56      | 3.85             | 0.31            |
|      7     | 19483_ / _19843              | 19561_ / _19560             | tt025C1v80      | 4.12             | 0.34            |
|      8     | 19483_ / _19843              | 19561_ / _19560             | ssn401v76       | -0.45            | 0.55            |
|      9     | 19483_ / _19843              | 19561_ / _19560             | ss1001v60       | -1.47            | 0.69            |
|     10     | 19483_ / _19843              | 19561_ / _19560             | ssn401v60       | -4.82            | 0.74            |
|     11     | 19483_ / _19843              | 19561_ / _19560             | ss1001v40       | -7.08            | 0.98            |
|     12     | 19483_/ _19715               | 19561_ / _19560             | ssn401v44       | -14.56           | 1.14            |
|     13     | 19483_ / _19843              | 19561_ / _19560             | ssn401v40       | -18.84           | 1.3             |
|     14     | 19483_/ _19715               | 19561_ / _19560             | ssn401v35       | -26.51           | 1.56            |
|     15     | 19483_ / _19843              | 19561_ / _19560             | ssn401v28       | -44.99           | 2.16            |


| **Sl No.** | **Start/end  point (setup)** | **Start/end  point (hold)** | **PVT corners** | **Setup  slack** | **Hold  slack** |
|:----------:|------------------------------|-----------------------------|-----------------|------------------|-----------------|
|      1     | 19483_ / _19843              | 19561_ / _19560             | ssn401v44       | -14.56           | 1.14            |
|      2     | 19483_ / _19843              | 19561_ / _19560             | ssn401v35       | -26.51           | 1.56            |

Static timing analysis –Post synthesis post placement pre CTS

| **Sl No.** | **Start/end  point (setup)** | **Start/end  point (hold)** | **PVT corners** | **Setup  slack** | **Hold  slack** |
|:----------:|------------------------------|-----------------------------|-----------------|------------------|-----------------|
|      1     | 19483_ / _19843              | 19561_ / _19560             | ff100C1v95      | 6.56             | 0.22            |
|      2     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v95      | 6.4              | 0.21            |
|      3     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v76      | 5.53             | 0.24            |
|      4     | 19483_ / _19843              | 19561_ / _19560             | ff100C1v65      | 5.54             | 0.27            |
|      5     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v65      | 4.75             | 0.28            |
|      6     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v56      | 3.85             | 0.31            |
|      7     | 19483_ / _19843              | 19561_ / _19560             | tt025C1v80      | 4.12             | 0.34            |
|      8     | 19515_/ _20163               | 19561_ / _19560             | ssn401v76       | 0.39             | 0.55            |
|      9     | 19483_ / _19843              | 19561_ / _19560             | ss1001v60       | -0.5             | 0.69            |
|     10     | 19515_/ _19876               | 19561_ / _19560             | ssn401v60       | -4.57            | 0.74            |
|     11     | 19483_/ _19851               | 19561_ / _19560             | ss1001v40       | -6.06            | 0.98            |
|     12     | 19483_/_19691                | 19561_ / _19560             | ssn401v44       | -13.47           | 1.14            |
|     13     | 19483_/ _19851               | 19561_ / _19560             | ssn401v40       | -17.33           | 1.3             |
|     14     | 19483_/ _19715               | 19561_ / _19560             | ssn401v35       | -24.48           | 1.56            |
|     15     | 19483_/ _19851               | 19561_ / _19560             | ssn401v28       | -41.14           | 2.16            |

Static timing analysis –Post CTS post layout


| **Sl No.** | **Start/end  point (setup)** | **Start/end  point (hold)** | **PVT corners** | **Setup  slack** | **Hold  slack** |
|:----------:|------------------------------|-----------------------------|-----------------|------------------|-----------------|
|      1     | 19515_/_20291                | 19491_/_19459               | ff100C1v95      | 6.29             | 0.11            |
|      2     | 19515_/_20291                | 19491_/_19459               | ffn40C1v95      | 6.1              | 0.1             |
|      3     | 19515_/_20291                | 19450_/_20772               | ffn40C1v76      | 5.17             | 0.11            |
|      4     | 19515_/_20291                | 19491_/_19459               | ff100C1v65      | 5.2              | 0.14            |
|      5     | 19515_/_20291                | 19450_/_20772               | ffn40C1v65      | 4.33             | 0.11            |
|      6     | 19515_/_20291                | 19450_/_20772               | ffn40C1v56      | 3.36             | 0.11            |
|      7     | 19515_/_20291                | 19450_/_20772               | tt025C1v80      | 3.68             | 0.17            |
|      8     | 19515_/_20227                | 20162_/ _19443              | ssn401v76       | -0.82            | 0.15            |
|      9     | 19515_/_19819_               | 19506_/_19474               | ss1001v60       | -1.34            | 0.25            |
|     10     | 19515_/_19876                | 19477_/_20799               | ssn401v60       | -5.57            | -0.1            |
|     11     | 19515_/_20553_               | 20141_/_19422               | ss1001v40       | -8.1             | 0.5             |
|     12     | 19515_/_19787                | 20132_/ _19413              | ssn401v44       | -16.59           | 0.3             |
|     13     | 19483_/_20363                | 20132_/ _19413              | ssn401v40       | -21.14           | 0.06            |
|     14     | 19483_/_20553                | 19678_/_19549               | ssn401v35       | -27.94           | 0.37            |
|     15     | 19483_/_19787                | 19477_/_20767               | ssn401v28       | -48.39           | 0.2             |

Static timing analysis - Post CTS

| **Sl No.** | **Start/end  point (setup)** | **Start/end  point (hold)** | **PVT corners** | **Setup  slack** | **Hold  slack** |
|:----------:|------------------------------|-----------------------------|-----------------|------------------|-----------------|
|      1     | 19483_ / _19843              | 19561_ / _19560             | ff100C1v95      | 6.55             | 0.25            |
|      2     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v95      | 6.39             | 0.24            |
|      3     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v76      | 5.53             | 0.28            |
|      4     | 19483_ / _19843              | 19561_ / _19560             | ff100C1v65      | 5.54             | 0.3             |
|      5     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v65      | 4.75             | 0.32            |
|      6     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v56      | 3.86             | 0.36            |
|      7     | 19483_ / _19843              | 19561_ / _19560             | tt025C1v80      | 4.12             | 0.38            |
|      8     | 19483_ / _19843              | 19561_ / _19560             | ssn401v76       | 0.42             | 0.6             |
|      9     | 19483_ / _19843              | 19561_ / _19560             | ss1001v60       | -0.51            | 0.75            |
|     10     | 19483_ / _19843              | 19561_ / _19560             | ssn401v60       | -3.97            | 0.82            |
|     11     | 19483_ / _19843              | 19561_ / _19560             | ss1001v40       | -6.04            | 1.07            |
|     12     | 19483_ / _19843              | 19561_ / _19560             | ssn401v44       | -13.14           | 1.23            |
|     13     | 19483_ / _19843              | 19561_ / _19560             | ssn401v40       | -17.25           | 1.42            |
|     14     | 19483_ / _19843              | 19561_ / _19560             | ssn401v35       | -24.45           | 1.71            |
|     15     | 19483_ / _19843              | 19561_ / _19560             | ssn401v28       | -40.96           | 2.3             |

Static timing analysis - Post CTS post layout

| **Sl No.** | **Start/end  point (setup)** | **Start/end  point (hold)** | **PVT corners** | **Setup  slack** | **Hold  slack** |
|:----------:|------------------------------|-----------------------------|-----------------|------------------|-----------------|
|      1     | 19483_ / _19843              | 19561_ / _19560             | ff100C1v95      | 6.49             | 0.25            |
|      2     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v95      | 6.32             | 0.24            |
|      3     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v76      | 5.45             | 0.29            |
|      4     | 19483_ / _19843              | 19561_ / _19560             | ff100C1v65      | 5.46             | 0.31            |
|      5     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v65      | 4.65             | 0.33            |
|      6     | 19483_ / _19843              | 19561_ / _19560             | ffn40C1v56      | 3.73             | 0.37            |
|      7     | 19483_ / _19843              | 19561_ / _19560             | tt025C1v80      | 4.01             | 0.38            |
|      8     | 19483_ / _19843              | 19561_ / _19560             | ssn401v76       | -0.1             | 0.6             |
|      9     | 19483_ / _19843              | 19561_ / _19560             | ss1001v60       | -0.69            | 0.76            |
|     10     | 19483_ / _19843              | 19561_ / _19560             | ssn401v60       | -4.16            | 0.84            |
|     11     | 19483_ / _19843              | 19561_ / _19560             | ss1001v40       | -7.3             | 1.07            |
|     12     | 19483_ / _19843              | 19561_ / _19560             | ssn401v44       | -14.58           | 1.24            |
|     13     | 19483_ / _19843              | 19561_ / _19560             | ssn401v40       | -18.26           | 1.42            |
|     14     | 19483_ / _19843              | 19561_ / _19560             | ssn401v35       | -24.6            | 1.71            |
|     15     | 19483_ / _19843              | 19561_ / _19560             | ssn401v28       | -43.22           | 2.31            |

Static timing analysis –Post synthesis post placement pre CTS

| **Sl No.** | **Start/end  point (setup)** | **Start/end  point (hold)** | **PVT corners** | **Setup  slack** | **Hold  slack** |
|:----------:|------------------------------|-----------------------------|-----------------|------------------|-----------------|
|      1     | 19483_ / _19843              | 19561_ / _19560             | ssn401v76       | 0.4              | 0.55            |
|      2     | 19483_ / _19843              | 19561_ / _19560             | ssn401v60       | -3.97            | 0.74            |
|      3     | 19483_ / _19843              | 19561_ / _19560             | ss1001v40       | -6.03            | 0.98            |
|      4     | 19483_ / _19843              | 19561_ / _19560             | ssn401v44       | -13.17           | 1.14            |
|      5     | 19483_ / _19843              | 19561_ / _19560             | ssn401v40       | -17.27           | 1.3             |
|      6     | 19483_ / _19843              | 19561_ / _19560             | ssn401v35       | -24.48           | 1.56            |
|      7     | 19483_ / _19843              | 19561_ / _19560             | ssn401v28       | -41.1            | 2.16            |

