## Description
This application provides the solution of a many-body spin 
polarized fermions with nearest neighbour, embedding a test (probe)
distinguishable particle.

### HOWTO for `Config.yaml`


#### **System Variables**
* _l_: Number of Sites
* _n_: Number of fermions

#### **Energy**
* _t1_: Nearest neighbour hopping kinetic energy 
* _u1_: Nearest neighbour interaction
* _t2_: Next Nearest neighbour hopping kinetic energy (Need to be tested)
* _u2_: Next Nearest neighbour interaction (Need to be tested)
* _vr_: Strength of sites potential energy
* Vt:Type of Onsite Potential (`R`=Random, `L`=Linear, `Q`=Quadratic)
* _ts_: Test particle hopping kinetic energy
* _ws_: Onsite interaction strength of fermions with test particle

#### **Results**
Check the `data` directory.

Support: m.koorepaz@gmail.com