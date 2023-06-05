## Description
This application provides the solution of a many-body spin 
polarized fermions with nearest neighbour, embedding a test (probe)
distinguishable particle.

### HOWTO for `Config.yaml`


#### **System Variables**
* _L_: Number of Sites
* _N_: Number of fermions

#### **Energy**
* _T1_: Nearest neighbour hopping kinetic energy 
* _U1_: Nearest neighbour interaction
* _T2_: Next Nearest neighbour hopping kinetic energy (Need to be tested)
* _U2_: Next Nearest neighbour interaction (Need to be tested)
* _Vr_: Strength of sites potential energy
* Vt:Type of Onsite Potential (`R`=Random, `L`=Linear, `Q`=Quadratic)
* _Ts_: Test particle hopping kinetic energy
* _W_: Onsite interaction strength of fermions with test particle

#### **Results**
Check the `data` directory.

Support. m.koorepaz@gmail.com