# EMC_Filter_Implementation
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

Filter type and order selection is dictated by filter design specifications, included in Figure 2. With 25dB attenuation required in the stop band, Figure 3 demonstrates the need for a 5th order filter. A maximally flat filter type was selected to minimize magnitude impact in the pass band.

(Figure 3)
 
Figure 3. Attenuation vs normalized frequency for maximally flat filter prototypes (Pozar, 1998)

Given by filter type and order selection, the normalized polynomial for a 5th order low-pass Butterworth filter is as follows:

T(s)=(s+1)(s^2+0.6180s+1)(s^2+1.6180s+1)

Because this polynomial is provided for a normalized cutoff frequency ( _c  =  (1 rad)/sec  ) it is required to scale for the desired cutoff frequency, in this case, 1MHz.

Substituting  s/(2  × 〖10〗^6 )  for s, gives:

T(s)=(s/(2 ×〖10〗^6 )+1)(〖s/(2 ×〖10〗^6 )〗^2+0.6180 s/(2 ×〖10〗^6 )+1)(〖s/(2 ×〖10〗^6 )〗^2+1.6180 s/(2 ×〖10〗^6 )+1)

In this form, T(s) represents the analog implementation of a 5th order, low-pass Butterworth filter with cutoff frequency at 1MHz. Figure 4 displays the frequency response with overlaid design requirements. Note that all design specifications are met in this implementation.
 
Figure 4. Frequency Response of T(s) - Analog Implementation of Maximally Flat Low Pass Filter

Circuit implementation of a 5th order, low-pass Butterworth filter for a circuit beginning with a shunt element is shown below in Figure 5, where gn values represent frequency scaled circuit element values gathered from Table 8.3 in David Pozar's 'Microwave Engineering' (Pozar, 1998). Source impedance of 1   was assumed, as such, impedance scaling of circuit elements is not required.
 
Figure 5. Circuit diagram of analog implementation

Capacitor elements were scaled to the desired cutoff frequency using:
L^'=  L/ _c 
Inductive elements were scaled to the desired cutoff frequency using:
C^'=  C/ _c 

# IIR Implementation

Implementation of an infinite impulse response (IIR) filter follows the analog implementation, with the same cutoff frequency and filter order. The filter was generated in the analog (s) domain and then mapped to the frequency (z) domain using the bilinear transform.

Figure 6 shows the frequency response of H(s) for a 5th order low pass Butterworth filter.

(Figure)

Figure 6. Frequency response of low pass Butterworth filter in s-domain

H(s) was subsequently pre-warped and mapped to the z-domain using the bilinear transform with a sampling frequency of 15MHz. 15MHz sampling frequency was selected to capture all frequencies in the frequency band of interest (2MHz - 7MHz). Figure 7 displays the frequency response of the resulting filter in the z-domain. Note that at 2MHz, the frequency response of this filter exceeds the required 25dB attenuation.

(figure)
 
Figure 7. Frequency response of low pass Butterworth filter mapped to z-domain
Figure 8 & Figure 9 below display a block diagram depiction of the IIR filter implementations in the z-domain and the corresponding implementation in the time domain. Note that bn and an depict coefficients in the numerator and denominator of H(z). The diagrams depict the expanded form of the filtering scheme as follows:

X(z)  →  [H(z)]  →  Y(z)

Where 

H(z)=  (b_0+b_1 z^(-1)+b_2 z^(-1)+b_3 z^(-1)+b_4 z^(-1)+b_5 z^(-1))/(〖1+ a〗_1 z^(-1)+a_2 z^(-1)+a_3 z^(-1)+a_4 z^(-1)+a_5 z^(-1) )

Splitting H(z) into two components H1(z) and H2(z) gives:

X(z)  →  [H_1 (z)]  →W(z)  →[H_2 (z)]   →  Y(z)

Where

H_1 (z)= b_0+b_1 z^(-1)+b_2 z^(-1)+b_3 z^(-1)+b_4 z^(-1)+b_5 z^(-1)

H_2 (z)=  1/(〖1- a〗_1 z^(-1)+a_2 z^(-1)+a_3 z^(-1)+a_4 z^(-1)+a_5 z^(-1) )

With H(z) coefficient values specified in Table 1.

Table 1. H(z) coefficient values
n	0	1	2	3	4	5
bn	0.000218	0.001095	0.002189	0.002189	0.001095	0.000219
an	1	-3.647222	5.459623	-4.168367	1.617601	-0.254629


Combining the elements of the previous equations into a block diagram format gives the following.

(figure)
(figure)

# FIR Implementation

A finite impulse response (FIR) filter implementation was performed with Kaiser window parameters calculated using the general form Kaiser equations. Figure 10 displays normalized FIR filter response between 0 and  . 

(figure)

Figure 10. Normalized frequency response of FIR filter
Figure 11 displays frequency response of the same FIR filter, un-normalized and shown across frequency in Hz. Note that at frequencies >2MHz, this filter implementation provides >25dB attenuation.

(figure)

Figure 11. Frequency response of FIR filter

# Conclusion
Analog, IIR, and FIR filter types were implemented, all of which met the stated design requirement of 25dB attenuation at >2MHz. Reduction of interference current by this magnitude will ensure proper operation of the FlexRay module and ensure vehicle occupant safety.

# Future Work
To meet end product requirements, several additional items are required. Analog filter implementation assumes 1   source impedance. For proper frequency response and interference current attenuation, impedance scaling of the circuit is required. Actual source impedance should be investigated and identified to allow confirmation of the analog filter implementation.

Additionally, a cost of implementation study should be performed to select the ideal filter type for this application. Several factors such as DSP processing capabilities, PCB space, and added cost of implementation to the project must be explored for each solution option.

