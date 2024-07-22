* Final Project of DIC - Decoder4x16 by G1 (Amirreza Eftekhari, Amirreza Ahmadi)
.INCLUDE "tsmc025.txt"

.GLOBAL Vdd
.GLOBAL Vss 
.GLOBAL Out1 Out2 Out3 Out4 Out5 Out6 Out7 Out8 Out9 Out10 Out11 Out12 Out13 Out14 Out15 Out16

VS Vdd 0 5v                                     
VGND Vss 0 0v

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

.SUBCKT Inverter In Out 
Mn  Out In Vss MODN W=1u L=1u    
Mp  Out In Vdd MODP W=1u L=1u
.ENDS Inverter

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


VA A Vss 0v
VB B Vss 0v
VC C Vss 0v
VD D Vss 5v



Xdecoder A B C D Out1 Out2 Out3 Out4 Out5 Out6 Out7 Out8 Out9 Out10 Out11 Out12 Out13 Out14 Out15 Out16 Decoder4to16

.TRAN  1PS 100NS 0.1NS
.PROBE 
.END 