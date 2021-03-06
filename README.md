# Performance characterization for VSDBabySoC comprising of RISC-V core, PLL and DAC

STA timing analysis verifies that the functionality of a design(chip) is intact across various conditions. The analysis consists of three parts timing checks, constraints and libraries. Timing checks includes the setup/hold timing checks – combination of various types of valid timing checks, to ensure the design specifications/constrains are met and libraries which defines the delay model. A number of STA analysis tools both commercial and open source are available for analysis of the design. The main aim here is the performance characterization of an SOC named VSDBaby SOC comprising of RISC-V core, PLL and DAC across different even PVT corners available in The main aim here is the performance characterization of VSDBabySoc using skywater ss and ff for 1.8V and 25C. Initially the STA of a design from [VSD STA course](https://www.vlsisystemdesign.com/vsd-static-timing-analysis-ii/) is studied across different PVT corners available in skywater130 pdk. Following that the STA  of RISC-V core is done and slack values (setup and hold) is observe at each stages of openLANE viz post synthesis, post cts and post layout for the different PVT corners available in sky130 PDK. Based on the findings from the observation of the previous design and the RISC-V core the best and worse corner in skywater130 is ssn40C1v28 and ff100C1v95.

## Some important terms

Timing path: The path between the start and end point. In case of STA, the start point is the flip flop clk pin/input port and the end point is the flip flop D pin/output port.

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
 ![setup_hold](https://user-images.githubusercontent.com/63381455/167811344-83b0a620-d0b3-404c-9940-61f985c8270c.PNG)

Slew transistion analysis
 - Data(max/min)
 - Clock(max/min)

Load analysis
 - Fanout(max/min)
 - Capacitance(max/min)

Clock analysis
 - Skew
 - Pulse width

![others](https://user-images.githubusercontent.com/63381455/167811402-ee8d9c68-8184-4a90-8a0e-dfee07cf9cf3.PNG)


## Tools required

- Linux operating system
- OpenLANE : OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII. 
OpenROAD app has the OpenSTA included among its various tools and modules. For installing OpenLANE a free course is provided by VSD and here is the [link](https://www.udemy.com/course/vsd-a-complete-guide-to-install-openlane-and-sky130nm-pdk/learn/lecture/21989810?start=0#overview) also you can visit this [repository](https://github.com/nickson-jose/openlane_build_script)
- ngspice: An open source spice simulator for electronic circuits. For installation in Windows and Linux platform visit this [link](http://ngspice.sourceforge.net/download.html). 
 
All the necessary files and libraries is included in the repository.

## Delay table of CMOS inverter

CMOS inverter being the basic building block in designing its delay table for the even corners using skywater PDK is generated below. As per the delay value, the ss(worse) corner have highest delay and ff(best) corner has the least delay for the same inverter. The details of the same can be obained in this [repository](https://github.com/Geetima2021/CMOS-Circuit-Design-and-SPICE-Simulation-using-SKY130-Technology).

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

Based on the design specification the given figure is analysed. The first step is to write a verilog program for the design and it is located [here](https://github.com/Geetima2021/vsdpcvrd/tree/main/resources/files). This verilog file is linked with the skywater timing library for analysis. The timing libraries use in the analysis is available [here](https://github.com/Geetima2021/vsdpcvrd/tree/main/resources/timing_libs). In this case after generation of yosys synthesis netlist the openSTA tool is used for STA analysis.

Note: The location of timimg library inside OpenLANE is ``${PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/lib/``.


![main_fig](https://user-images.githubusercontent.com/63381455/155880106-37238762-9551-4e05-9270-50b4c80167fa.JPG)

Prior to STA the systhesized netlist is generated using the yosys sythesis tool and the script for same is included in the snapshot below.

![SD](https://user-images.githubusercontent.com/63381455/167897478-8c38d441-2cf4-44a4-98c3-056c7a6fa76b.png)

The STA is done using open source tool OpenSTA and the snapshot of the tcl file use for timing analysis for a single PVT corner along with the necessary commands is as shown below.

![SD_conf](https://user-images.githubusercontent.com/63381455/167903969-c8dd9cc9-757e-4868-8c26-5c6f8caf5f04.png)

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

## Performance characterization of RISCV core using sky130 and openSTA

Here we started off by generation of synthesized netlist using the standard script of yosys tool. The verilog file for STA analysis of RISCV core is taken from this [repository](https://github.com/shivanishah269/risc-v-core/tree/master/FPGA_Implementation/verilog).The obtained netlist is used for timing analysis and based on the result we observe that the generated output report has huge fanout which results in high negative slack. The snapshot below shows the worst set up and hold slack with respect to different PVT corners.

![res_10ns](https://user-images.githubusercontent.com/63381455/170959322-b3c3cedd-1df8-4567-99d3-e905f9bdc393.png)

As seen from the above table the basis rvmyth netlist result in negative slack as it does not do high fanout synthesis and hence next OpenLANE is used for further analysis and the slack (setup and hold) is observed. OpenLANE flow provides an added advantage of sta analysis at different stages of the PnR flow - post synthesis, post CTS and post layout as the netlist are generated and available for analysis. The tt corner library (tt025C1v80) is used as synthesis library. Also the extracted the gate delays are mapped with the sky130 libraries and the values are mapped as shown in table below. The snapshot below  shows the ssn40C1v35 mapping of the generated setup slack during the synthesis stage. We observe the values of the input slew and capacitance to verify the obtained gate delays. Based on the observation we see that the delays are approximately equal and the capacitance and input slew in the libraries are considered for range of values.

![lib_mapping](https://user-images.githubusercontent.com/63381455/170966980-13a799bb-7f36-47d5-adfa-930f123910fa.png)

The flow diagram of the process is shown in figure below. We started with the openLANE flow and after completion of the physical design flow the generated netlist across different stages is used for our analysis. In our case we use the same min and max library for sta analysis outside openLANE flow. 

All the netlist are available along this path inside openlane_working_dir``${OPENLANE_ROOT}/designs/rvmyth/tt025C1v80/results/synthesis/``. 
The openLANE sta results is available in the following path of the openlane_working_dir``${OPENLANE_ROOT}/designs/rvmyth/tt025C1v80/reports/synthesis/``.
 
For more infomation on the OpenLANE flow process visit this [repository](https://gitlab.com/gab13c/openlane-workshop). For information on the step by step procedure of the openLANE interactive flow visit this [page](https://github.com/The-OpenROAD-Project/OpenLane/blob/master/docs/source/advanced_readme.md) in openlane repository. 

Note: OpenLANE does sta analysis for a set of min max libraries. 


![flow_diag](https://user-images.githubusercontent.com/63381455/168047327-4a523a98-f580-4f1f-ba10-c71ff7a9ee2f.PNG)

The figure belows shows the standalone OpenSTA flow.


![STA_flow](https://user-images.githubusercontent.com/63381455/168652915-c63946a2-e07d-4ace-86b3-2eb755c487ee.PNG)


Understanding the generated timing report is important for the analysis of a given design. Below is the example snapshot of the pre and post CTS timing report. Both the reports are ideally the same except that post CTS the clock network is propagated otherwise its ideal.

![post_syn](https://user-images.githubusercontent.com/63381455/168085768-2ae0aabe-c771-4718-9ccf-30e7cf7fe959.PNG)

![post_cts](https://user-images.githubusercontent.com/63381455/168085286-f186aec0-ac3b-4a24-8e27-43fe7234c74a.PNG)

The clock network propagated is a balanced H tree and the snapshot of H-Tree based figure for a single PVT corner showing the launch and the capture flop path of the worse seup and hold is included below. The textual format generated in the report of a setup launch and capture flop is also included. To view the clock network an additional switch ``-format full_clock_expanded `` is added to the ``report_checks`` command.

![htree_final_1](https://user-images.githubusercontent.com/63381455/170118809-4030298b-b095-4af2-9c18-739210509f3f.PNG)


![clk_net](https://user-images.githubusercontent.com/63381455/168092135-f5f4562c-3256-4489-ba58-b3371d740c2d.PNG)

### STA at different stages of PnR flow

The setup slack and hold slack along with the start and end point of the different PVT corners are tabulated for the different stages of the OpenLANE flow. At each stage - post synthesis pre CTS, post CTS and Post CTS post layout graph is generated between hold slack/setup slack and PVT corners. From the table and generated graph the best and the worse corner of skywater130 timimg library is observed. In our study same PVT corner is considered for min and max delay calculation.   

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

### On-chip variation based static timing analysis

On-chip variation (OCV) is an un-avoidable issue which occurs during the fabrication process. It gives a more realistic and conservative analysis of a design. The variation percentage is termed as OCV derates. In standard industrial process different process corners are used for min and max delay calculation which accounts for ocv in a design. Clock network is mostly preferred for ocv and the tools automatically includes the network as per the PVT corners considered for min and max delay calculation.  Four possible combinations is possible for data required time (DRT) and data arrival time (DAT) calculation in the clock network where the delays are either increase or reduce with certain OCV derates %tage [increase DAT/DRT: increase DAT, reduce DRT: reduce DAT, increase DRT:reduce DAT/DRT]. OCV results in pessimism and its removal is essential for slack calculation.

There are terms associated with the increase and reduce derates. 

- When the DRT/DAT in the clock path (delays) is reduced by the OCV variation it is called as clock pull in.
- When the DAT/DRT in the clock path (delays) is increased by the OCV variation it is called as clock push out 

Considering the clock network, the figure below shows the commom clock section for the ocv setup and hold analysis (post layout). In case of ocv setup timing analysis the max delay is use in the data path and min delay is use in the clock path and vice versa in case of hold timing analysis. From the common clock section as shown in figure below and it is observe that the delay value of the of the cell is different which results in pessimism as no two cells can have different delay at the same time instance. This pessimism is termed as additional pessismism or clock reconvergence pessimism or clock path pessimism and removal of the pessimism is essential. For removal of the pessimism we can either add/remove the extra pessimism from DAT or DRT part and then compute the required slack. This method of pessimism removal is known as additional pessismism removal orclock reconvergence pessimism removal or clock path pessimism removal (CPPR).

![cppr](https://user-images.githubusercontent.com/63381455/167178818-268481a7-3482-4997-a7dd-f8ebc3346936.PNG)

The snapshot below shows portion of the post layout timing analysis using ff100C1v95 and ss100C1v60 obtained from OpenSTA tool. The detailed timing reports are included [here](https://github.com/Geetima2021/vsdpcvrd/tree/main/resources/timing_reports).

![ocv](https://user-images.githubusercontent.com/63381455/167260863-cf3a3c58-616a-436d-a56a-38866a5b3065.png)

In OpenSTA timing there are few variables use for pessimism removal

- sta_crpr_enabled - it has to be enabled for activation of clock reconvergence pessimism removal and with either `0/1` value, `1` is the default value.

- sta_crpr_mode - it has two values ```same_pin``` and ```same_transition```. The default value use by OpenSTA is ```same_pin``` where pessimism is removed irrespective of the path rise/fall transition value and ```same_transition``` pessimism is only removed if the path rise/fall transitions are the same.

<!--- crpr_threshold ---> 

## Conclusion

- A delay table of an inverter for ss, ff and tt corner using sky130 technology is generated based on ngspice simulation result. 
- STA of a simple design using Yosys synthesis and openSTA tool across different PVT corners. Analysis of the cell delay and input slew of NAND gate, obtained from setup and hold slack showed the trend of the PVT corners
- STA of RISCV core using openLANE and OpenSTA using 15 PVT corners available in sky130 PDK 
- Same min and max library is used for STA and as per the observe results the ssn40C1v28(slow process, is the worse and ff100C1v95 is the best corner in sky130 PDK
- Post layout result gives a setup slack of +3.68ns(154MHz) for tt025C1v80 corner for a clock of 10ns. Worse setup slack across ssn401v28 corner is -47.93ns and ff100C1v95 shows a setup slack of 6.29ns. Hold slack is worse across the ff corner and best at ss corner with the tt corner giving a hold slack is 0.17ns 
- The analysis is based on the setup and hold reg2reg analysis
- Analysis using different PVT corner and observation of the clock network delay defines the crpr of the design

## Future work

- STA for all the other checks
- Multi mode multi corner analysis
- Optimizing the input tcl file for OpenSTA
- Study about timing violations and ECO
- Performance characterisation of VSDBabySOC

## Reference

- [Shivani Shah, risc-v-core](https://github.com/shivanishah269)
- [Grant Brown, OpenLANE Workshop](https://gitlab.com/gab13c/openlane-workshop)
- [Geetima Kachari, Circuit-Design-and-SPICE-Simulation-using-SKY130-Technology](https://github.com/Geetima2021/CMOS-Circuit-Design-and-SPICE-Simulation-using-SKY130-Technology)


## Acknowledgement

- [Kunal Ghosh](https://github.com/kunalg123), Co-founder, VSD Corp. Pvt. Ltd.
- [Tim Edwards](https://github.com/RTimothyEdwards),Senior Vice President of Analog and Design, Efabless Corporation
- [Shivani Shah](https://github.com/shivanishah269),TA VSD Corp. Pvt. Ltd.
- [Anagha Ghosh](https://www.linkedin.com/in/anagha-ghosh-vlsisystemdesign-com-a4394936), Founder, VSD Corp. Pvt. Ltd.






