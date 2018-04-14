# EMC Filter Implementation
Implementation of EMC filter to prevent EMI from corrupting FlexRay module operation.

Below is an excerpt of the report included in this repository. Review 'ECE580 Project 1 Report' for full details.

# Introduction

An emerging alternative to standard gasoline powered vehicles is the electric or hybrid-electric vehicle (HEV). HEVs produce fewer emissions than their gasoline powered counterparts. They do however come with their own unique challenges. One of these challenges is the electromagnetic interference inherent to their design and power source. Electromagnetic compatibility (EMC) is a critical factor in ensuring robust vehicle operation and occupant safety. This report proposes several solutions to an identified electromagnetic interference (EMI) occurrence in a HEV which will allow proper operation of the FlexRay communications module.

# Problem Statement

The FlexRay communications system is a time-deterministic communications protocol for in-vehicle control applications. It is designed to provide high speed distributed control for advanced automotive applications. It is known, that for FlexRay to operate properly, the noise on the power line must be <40dB A between frequencies of 2MHz to 7MHz.

Noise on the power line exceeding this requirement has been identified and measured to be above the allowable limit (PENG, et al., 2016). Figure 1 displays interference currents in excess of 60dB near 4MHz during an electric assist braking event.

(figure 1)

# Design Specifications

(figure)

# Design Solution

To allow proper operation of the FlexRay module, interference current must be reduced by at least 25dB at frequencies greater than 2MHz.

Three design solutions will be implemented:
1.	Analog Implementation
2.	IIR Implementation
3.	FIR Implementation 

# Analog Implementation

Frequency response of analog filter implementation 

# IIR Implementation

Frequency response of IIR filter implementation 

# FIR Implementation

Frequency response of FIR filter implementation 
