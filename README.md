# EMC Filter Implementation
Implementation of EMC filter to prevent EMI from corrupting FlexRay module operation.

Below is an excerpt of the report included in this repository. Review 'ECE580 Project 1 Report' for full details.

# Introduction

An emerging alternative to standard gasoline powered vehicles is the electric or hybrid-electric vehicle (HEV). HEVs produce fewer emissions than their gasoline powered counterparts. They do however come with their own unique challenges. One of these challenges is the electromagnetic interference inherent to their design and power source. Electromagnetic compatibility (EMC) is a critical factor in ensuring robust vehicle operation and occupant safety. This report proposes several solutions to an identified electromagnetic interference (EMI) occurrence in a HEV which will allow proper operation of the FlexRay communications module.

# Problem Statement

The FlexRay communications system is a time-deterministic communications protocol for in-vehicle control applications. It is designed to provide high speed distributed control for advanced automotive applications. It is known, that for FlexRay to operate properly, the noise on the power line must be <40dB A between frequencies of 2MHz to 7MHz.

Noise on the power line exceeding this requirement has been identified and measured to be above the allowable limit (PENG, et al., 2016). The figure below displays interference currents in excess of 60dB near 4MHz during an electric assist braking event.

![picture1](https://user-images.githubusercontent.com/16856208/38771698-9ac3a38e-3ff5-11e8-89b4-bc31b2b1b96b.png)

# Design Specifications

![slide1](https://user-images.githubusercontent.com/16856208/38771642-9e62dec0-3ff4-11e8-8f0a-e4ab0e7edfff.png)

# Design Solution

To allow proper operation of the FlexRay module, interference current must be reduced by at least 25dB at frequencies greater than 2MHz.

Three design solutions will be implemented:
1.	Analog Implementation
2.	IIR Implementation
3.	FIR Implementation 

# Analog Implementation

Frequency response of analog filter implementation 

![fig1 - freq response ts](https://user-images.githubusercontent.com/16856208/38771651-ac294ba2-3ff4-11e8-9025-586779469aa8.png)

Circuit implementation of analog filter

![analog circuit](https://user-images.githubusercontent.com/16856208/38771643-9e7e30f8-3ff4-11e8-938a-1b24264d3ae8.png)

# IIR Implementation

Frequency response of IIR filter implementation 

![fig3 - freq response hz](https://user-images.githubusercontent.com/16856208/38771649-ac052614-3ff4-11e8-800c-64cb32788bce.png)

Block diagram representation of IIR implementation in z-domain

![z-domain flowchart](https://user-images.githubusercontent.com/16856208/38771640-9e3dc716-3ff4-11e8-90c5-181d9ea2534f.png)

Block diagram representation of IIR implementation in time domain

![s-domain flowchart](https://user-images.githubusercontent.com/16856208/38771641-9e512586-3ff4-11e8-9568-799ceb178d2d.png)

# FIR Implementation

Frequency response of FIR filter implementation 

![fig4 - normalized frequency response of fir filter](https://user-images.githubusercontent.com/16856208/38771648-abf3f65a-3ff4-11e8-9218-62f1953576f5.png)

![fig5 - frequency response of fir filter](https://user-images.githubusercontent.com/16856208/38771647-abe310ec-3ff4-11e8-8cf4-1279109e9352.png)
