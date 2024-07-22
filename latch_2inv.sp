* Final Project of DIC - Latch with 2 inverters by G1 (Amirreza Eftekhari, Amirreza Ahmadi)
.INCLUDE "tsmc025.txt"

.GLOBAL Vdd
.GLOBAL Vss 

VS Vdd 0 5v                                     
VGND Vss 0 0v

.SUBCKT Inverter In Out 
Mn1  Out In Vss MODN W=1u L=1u    
Mp2  Out In Vdd MODP W=1u L=1u
.ENDS Inverter

.SUBCKT CmosPass DRAIN GATE SOURCE INVGATE 
Mn DRAIN GATE SOURCE MODN W=1u L=1u
Mp SOURCE INVGATE DRAIN MODP W=1u L=1u 
.ENDS CmosPass 

.SUBCKT Latch2inv Inp Out  
Xinv_1 Inp Out Inverter 
Xinv_2 Out Inp Inverter 
.ENDS Latch2inv 

.GLOBAL Clk InvClk
.GLOBAL En_Write InvEnWrtie

.SUBCKT Cell DataInp InvDataInp DataOutp Addr InvAddr

XSignalWr DataInp En_Write Node1 InvEnWrtie CmosPass
XSignalClk Node1 Clk DataOutp InvClk CmosPass
XSignalAddr DataOutp Addr Inp InvAddr CmosPass

XInvEnWrtie InvDataInp En_Write Node2 InvEnWrtie CmosPass 
XInvClk Node2 Clk InvDataOutp InvClk CmosPass 
XInvAddr InvDataOutp Addr Out InvAddr CmosPass 

XLatch2inv Inp Out Latch2inv

.ENDS Cell

XInvDataInp DataInp InvDataInp Inverter
XInvAddr Addr InvAddr Inverter
XInvClk Clk InvClk Inverter
XInvEnWrtie En_Write InvEnWrtie Inverter

XCell DataInp InvDataInp DataOutp Addr InvAddr Cell

VDataInp DataInp 0 PWL(1ps 0v, 9ns 0v,
+  10ns 0v, 19ns 0v,
+  20ns 0v, 29ns 0v,
+  30ns 0v, 39ns 0v,
+  40ns 5v, 49ns 5v,
+   50ns 5v, 59ns 5v,
+   60ns 5v, 69ns 5v,
+   70ns 5v, 79ns 5v,
+   80ns 0v, 89ns 0v,
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

Vwrite En_Write 0 PWL(1ps 0v, 9ns 0v,
+  10ns 5v, 19ns 5v,
+  20ns 5v, 29ns 5v,
+  30ns 0v, 39ns 0v,
+  40ns 0v, 49ns 0v,
+   50ns 0v, 59ns 0v,
+   60ns 5v, 69ns 5v,
+   70ns 5v, 79ns 5v,
+   80ns 0v, 89ns 0v,
+   90ns 0v, 99ns 0v,)


VAddr Addr 0 PWL(1ps 0v, 9ns 0v,
+  10ns 5v, 19ns 5v,
+  20ns 0v, 29ns 0v,
+  30ns 0v, 39ns 0v,
+  40ns 0v, 49ns 0v,
+   50ns 0v, 59ns 0v,
+   60ns 0v, 69ns 0v,
+   70ns 5v, 79ns 5v,
+   80ns 5v, 89ns 5v,
+   90ns 0v, 99ns 0v,)

.TRAN  1PS 100NS 0.1NS
.PROBE 
.END 