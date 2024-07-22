* Final Project of DIC - Memory 16x8 by G1 (Amirreza Eftekhari, Amirreza Ahmadi)
.INCLUDE "tsmc025.txt"

.GLOBAL Vdd
.GLOBAL Vss 

VS Vdd 0 5v                                     
VGND Vss 0 0v

* Sub-Circuit of an Inverter
.SUBCKT Inverter In Out 
Mn1  Out In Vss MODN W=1u L=1u    
Mp2  Out In Vdd MODP W=1u L=1u
.ENDS Inverter 

* Sub-Circuit of a CMOS Pass transistor
.SUBCKT CmosPass Drain Gate Source INVGATE 
Mn Drain Gate Source MODN W=1u L=1u
Mp Source InvGate Drain MODP W=1u L=1u 
.ENDS CmosPass 

* Sub-Circuit of a Latch with 2 inverters
.SUBCKT Latch2inv Inp Out  
Xinv_1 Inp Out Inverter 
Xinv_2 Out Inp Inverter 
.ENDS Latch2inv 

* Sub-Circuit of a 4-inputs AND gate
.SUBCKT And4inp A B C D Out

MN1 Node1 A Vss MODN W=1u L=1u 
MN2 Node2 B Node1 MODN W=1u L=1u 
MN3 Node3 C Node2 MODN W=1u L=1u 
MN4 InvOut D Node3 MODN W=1u L=1u 
MP1 InvOut A Vdd MODP W=1u L=1u 
MP2 InvOut B Vdd MODP W=1u L=1u 
MP3 InvOut C Vdd MODP W=1u L=1u 
MP4 InvOut D Vdd MODP W=1u L=1u 

XInv InvOut Out Inverter

.ENDS And4inp

* Sub-Circuit of a Decoder4x16 with Inverter-Nand gates
.SUBCKT Decoder4to16 Inp1 Inp2 Inp3 Inp4 Out1 Out2 Out3 Out4 Out5 Out6 Out7 Out8 Out9 Out10 Out11 Out12 Out13 Out14 Out15 Out16

    Xi1 Inp1 InvInp1 Inverter
    Xi2 Inp2 InvInp2 Inverter
    Xi3 Inp3 InvInp3 Inverter
    Xi4 Inp4 InvInp4 Inverter

    Xy1 InvInp1 InvInp2 InvInp3 InvInp4 Out1 And4inp
    Xy2 InvInp1 InvInp2 InvInp3 Inp4 Out2 And4inp
    Xy3 InvInp1 InvInp2 Inp3 InvInp4 Out3 And4inp
    Xy4 InvInp1 InvInp2 Inp3 Inp4 Out4 And4inp
    Xy5 InvInp1 Inp2 InvInp3 InvInp4 Out5 And4inp
    Xy6 InvInp1 Inp2 InvInp3 Inp4 Out6 And4inp
    Xy7 InvInp1 Inp2 Inp3 InvInp4 Out7 And4inp
    Xy8 InvInp1 Inp2 Inp3 Inp4 Out8 And4inp
    Xy9 Inp1 InvInp2 InvInp3 InvInp4 Out9 And4inp
    Xy10 Inp1 InvInp2 InvInp3 Inp4 Out10 And4inp
    Xy11 Inp1 InvInp2 Inp3 InvInp4 Out11 And4inp
    Xy12 Inp1 InvInp2 Inp3 Inp4 Out12 And4inp
    Xy13 Inp1 Inp2 InvInp3 InvInp4 Out13 And4inp
    Xy14 Inp1 Inp2 InvInp3 Inp4 Out14 And4inp
    Xy15 Inp1 Inp2 Inp3 InvInp4 Out15 And4inp
    Xy16 Inp1 Inp2 Inp3 Inp4 Out16 And4inp

.ENDS Decoder4to16

.GLOBAL Clk InvClk
.GLOBAL En_Write InvEnWrtie

XInvClk Clk InvClk Inverter
XInvEnWrtie En_Write InvEnWrtie Inverter

* Sub-Circuit of a Cell
.SUBCKT Cell DataInp InvDataInp DataOutp Addr InvAddr

XSignalWr DataInp En_Write Node1 InvEnWrtie CmosPass
XSignalClk Node1 Clk DataOutp InvClk CmosPass
XSignalAddr DataOutp Addr Inp InvAddr CmosPass

XInvEnWrtie InvDataInp En_Write Node2 InvEnWrtie CmosPass 
XInvClk Node2 Clk InvDataOutp InvClk CmosPass 
XInvAddr InvDataOutp Addr Out InvAddr CmosPass 

XLatch2inv Inp Out Latch2inv

.ENDS Cell

.GLOBAL DataInp0 DataInp1 DataInp2 DataInp3 DataInp4 DataInp5 DataInp6 DataInp7
.GLOBAL InvDataInp0 InvDataInp1 InvDataInp2 InvDataInp3 InvDataInp4 InvDataInp5 InvDataInp6 InvDataInp7
.Global DataOutp0 DataOutp1 DataOutp2 DataOutp3 DataOutp4 DataOutp5 DataOutp6 DataOutp7

XInvDin0 DataInp0 InvDataInp0 Inverter
XInvDin1 DataInp1 InvDataInp1 Inverter 
XInvDin2 DataInp2 InvDataInp2 Inverter
XInvDin3 DataInp3 InvDataInp3 Inverter 
XInvDin4 DataInp4 InvDataInp4 Inverter  
XInvDin5 DataInp5 InvDataInp5 Inverter 
XInvDin6 DataInp6 InvDataInp6 Inverter
XInvDin7 DataInp7 InvDataInp7 Inverter 

* Sub-Circuit of 8 Cells in a row
.SUBCKT Cell8 Addr InvAddr 
XCell0 DataInp0 InvDataInp0 DataOutp0 Addr InvAddr Cell
XCell1 DataInp1 InvDataInp1 DataOutp1 Addr InvAddr Cell
XCell2 DataInp2 InvDataInp2 DataOutp2 Addr InvAddr Cell
XCell3 DataInp3 InvDataInp3 DataOutp3 Addr InvAddr Cell
XCell4 DataInp4 InvDataInp4 DataOutp4 Addr InvAddr Cell
XCell5 DataInp5 InvDataInp5 DataOutp5 Addr InvAddr Cell
XCell6 DataInp6 InvDataInp6 DataOutp6 Addr InvAddr Cell
XCell7 DataInp7 InvDataInp7 DataOutp7 Addr InvAddr Cell
.ENDS Cell8


.GLOBAL Addr1 Addr2 Addr3 Addr4 Addr5 Addr6 Addr7 Addr8 
XInvAddr1 Addr1 InvAddr1 Inverter
XInvAddr2 Addr2 InvAddr2 Inverter
XInvAddr3 Addr3 InvAddr3 Inverter
XInvAddr4 Addr4 InvAddr4 Inverter
XInvAddr5 Addr5 InvAddr5 Inverter
XInvAddr6 Addr6 InvAddr6 Inverter
XInvAddr7 Addr7 InvAddr7 Inverter
XInvAddr8 Addr8 InvAddr8 Inverter

XCell8_1 Addr1 InvAddr1 Cell8
XCell8_2 Addr2 InvAddr2 Cell8  
XCell8_3 Addr3 InvAddr3 Cell8  
XCell8_4 Addr4 InvAddr4 Cell8  
XCell8_5 Addr5 InvAddr5 Cell8  
XCell8_6 Addr6 InvAddr6 Cell8  
XCell8_7 Addr7 InvAddr7 Cell8  
XCell8_8 Addr8 InvAddr8 Cell8  

.GLOBAL Addr9 Addr10 Addr11 Addr12 Addr13 Addr14 Addr15 Addr16
XInvAddr9 Addr9 InvAddr9 Inverter
XInvAddr10 Addr10 InvAddr10 Inverter
XInvAddr11 Addr11 InvAddr11 Inverter
XInvAddr12 Addr12 InvAddr12 Inverter
XInvAddr13 Addr13 InvAddr13 Inverter
XInvAddr14 Addr14 InvAddr14 Inverter
XInvAddr15 Addr15 InvAddr15 Inverter
XInvAddr16 Addr16 InvAddr16 Inverter

XCell8_9 Addr9 InvAddr9 Cell8  
XCell8_10 Addr10 InvAddr10 Cell8
XCell8_11 Addr11 InvAddr11 Cell8
XCell8_12 Addr12 InvAddr12 Cell8
XCell8_13 Addr13 InvAddr13 Cell8
XCell8_14 Addr14 InvAddr14 Cell8
XCell8_15 Addr15 InvAddr15 Cell8
XCell8_16 Addr16 InvAddr16 Cell8

.GLOBAL A1 A2 A3 A4

Xdecoder4x16 A1 A2 A3 A4 Addr1 Addr2 Addr3 Addr4 Addr5 Addr6 Addr7 Addr8 Addr9 Addr10 Addr11 Addr12 Addr13 Addr14 Addr15 Addr16 Decoder4to16

VA1 A1 Vss 0v
VA2 A2 Vss 0v
VA3 A3 Vss 0v
VA4 A4 Vss 5v

* VA1 A1 0 PWL(1ps 0v, 9ns 0v,
* +  10ns 0v, 19ns 0v,
* +  20ns 0v, 29ns 0v,
* +  30ns 0v, 39ns 0v,
* +  40ns 5v, 49ns 5v,
* +   50ns 5v, 59ns 5v,
* +   60ns 5v, 69ns 5v,
* +   70ns 5v, 79ns 5v,
* +   80ns 5v, 89ns 5v,
* +   90ns 5v, 99ns 5v,)

* VA2 A2 0 PWL(1ps 5v, 9ns 5v,
* +  10ns 0v, 19ns 0v,
* +  20ns 0v, 29ns 0v,
* +  30ns 5v, 39ns 5v,
* +  40ns 0v, 49ns 0v,
* +   50ns 0v, 59ns 0v,
* +   60ns 0v, 69ns 0v,
* +   70ns 0v, 79ns 0v,
* +   80ns 0v, 89ns 0v,
* +   90ns 0v, 99ns 0v,)

* VA3 A3 0 PWL(1ps 0v, 9ns 0v,
* +  10ns 0v, 19ns 0v,
* +  20ns 5v, 29ns 5v,
* +  30ns 0v, 39ns 0v,
* +  40ns 0v, 49ns 0v,
* +   50ns 5v, 59ns 5v,
* +   60ns 5v, 69ns 5v,
* +   70ns 0v, 79ns 0v,
* +   80ns 0v, 89ns 0v,
* +   90ns 5v, 99ns 5v,)

* VA4 A4 0 PWL(1ps 0v, 9ns 0v,
* +  10ns 0v, 19ns 0v,
* +  20ns 0v, 29ns 0v,
* +  30ns 5v, 39ns 5v,)
* +  40ns 5v, 49ns 5v,
* +   50ns 0v, 59ns 0v,
* +   60ns 0v, 69ns 0v,
* +   70ns 0v, 79ns 0v,
* +   80ns 0v, 89ns 0v,
* +   90ns 0v, 99ns 0v,)

VDinp3 DataInp3 0 PWL(1ps 0v, 9ns 0v,
+  10ns 0v, 19ns 0v,
+  20ns 0v, 29ns 0v,
+  30ns 5v, 39ns 5v,
+  40ns 5v, 49ns 5v,
+   50ns 0v, 59ns 0v,
+   60ns 0v, 69ns 0v,
+   70ns 0v, 79ns 0v,
+   80ns 5v, 89ns 5v,
+   90ns 5v, 99ns 5v,)

VClk Clk 0 PWL(1ps 0v, 9ns 0v,
+  10ns 5v, 19ns 5v,
+  20ns 0v, 29ns 0v,
+  30ns 5v, 39ns 5v,
+  40ns 0v, 49ns 0v,
+   50ns 5v, 59ns 5v,
+   60ns 0v, 69ns 0v,
+   70ns 5v, 79ns 5v,
+   80ns 0v, 89ns 0v,
+   90ns 5v, 99ns 5v,)

VWrite En_Write 0 PWL(1ps 0v, 9ns 0v,
+  10ns 5v, 19ns 5v,
+  20ns 5v, 29ns 5v,
+  30ns 5v, 39ns 5v,
+  40ns 0v, 49ns 0v,
+   50ns 0v, 59ns 0v,
+   60ns 5v, 69ns 5v,
+   70ns 0v, 79ns 0v,
+   80ns 0v, 89ns 0v,
+   90ns 5v, 99ns 5v,)

.MEASURE tpdf TRIG V(Clk) VAL=1.73.3V RISE=1 TARG V(DataOutp3) VAL=1.73.3V FALL=1
.MEASURE tpdr TRIG V(DataInp3) VAL=1.73.3V FALL=1 TARG V(DataOutp3) VAL=1.73.3V RISE=1
.MEASURE td param='tpdr + tpdf/2'
.MEASURE pwr AVG P(VS) FROM 0ns TO 30ns

.TRAN  1PS 100NS 0.5NS
.PROBE 
.END 