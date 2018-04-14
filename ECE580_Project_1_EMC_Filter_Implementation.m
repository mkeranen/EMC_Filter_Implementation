%ECE580 Project 1 - Winter 2018
%By: Mark Keranen
%Implementation of EMC filter to ensure proper operation of FlexRay Module

%Requirement: FlexRay module requires <40dB noise between 2-7MHz on power 
%line for proper operation

%Currently as Measured: Noise between 2-7MHz approaches 65dB.

%Solution: Provide >25dB attenuation at >2MHz using:
%   1. Analog Implementation
%   2. IIR Implementation of Analog Solution
%   3. FIR Implementation


%Analog Implementation*****************************************************

%Fifth Order Maximally Flat Low Pass Filter, frequency shifted for wc=1MHz
%T(s) = 1*10^-30 s^5 + 3.236×10^-24 s^4 + 5.23592×10^-18 s^3 + 
%       5.23592×10^-12 s^2 + 3.236×10^-6 s + 1
numerator = [0 0 0 0 1];
denominator = [1*10^-30 3.236*10^-24 5.23592*10^-18 5.23592*10^-12 3.236*10^-6 1];
w = logspace(-3, 9, 1000); %freq range

T=freqs(numerator, denominator, w); %Calculate frequency response of T(s)

hold on
semilogx(w, 20*log10(abs(T))) %Plot magnitude response in dB
hold off

axis([6*10^5 3*10^6 -40 10])
grid on
grid minor

%Add Design Specs to Chart to confirm specifications are met
passBandLowerLimit = refline(0,-3);
stopBandUpperLimit = refline(0,-25);
passBandLowerLimit.Color='k';
stopBandUpperLimit.Color='k';

cutOffFrequency = line([1*10^6 1*10^6], [-80 10]);
stopBandStartFrequency = line([2*10^6 2*10^6], [-80 10]);
cutOffFrequency.Color='k';
stopBandStartFrequency.Color='k';

title('Frequency Response of T(s) - Analog Implementation');
xlabel('Frequency (Hz)');
ylabel('20Log|T(s)|');

%IIR Implementation of Analog Design***************************************
figure()

fc = 1*10^6;  %Cutoff frequency = 1 MHz
fs = 15*10^6; %Sampling Frequency = 15 MHz; 7MHz * 2 = 14MHz +1 for SF
fp = fc;  %Match frequency for prewarping
filterOrder = 5; %Order calculated based on design specifications

%Calculate Transfer function coefficients and H(s)
[b,a] = butter(filterOrder,2*pi*fc,'s');
[h,w] = freqs(b,a);

%Convert frequency to MHz
w = (w/(2*pi));

%Plot frequency response of filter
semilogx(w, 20*log10(abs(h)));
axis([6*10^5 3*10^6 -40 10])
grid on
grid minor

%Plot design requirements
passBandLowerLimit = refline(0,-3);
stopBandUpperLimit = refline(0,-25);
passBandLowerLimit.Color='k';
stopBandUpperLimit.Color='k';

cutOffFrequency = line([1*10^6 1*10^6], [-80 10]);
stopBandStartFrequency = line([2*10^6 2*10^6], [-80 10]);
cutOffFrequency.Color='k';
stopBandStartFrequency.Color='k';

title('Frequency Response of H(s)');
xlabel('Frequency (Hz)');
ylabel('20Log|H(s)|');

%Use bilinear transform to find map s-domain filter to z-domain
figure()

%Perform bilinear transform using coefficients generated for s-domain,
%passing sampling frequency and match frequency

[numd,dend] = bilinear(b,a,fs,fp); %H(z)

%Calculate frequency response of H(z)
[hd,wd] = freqz(numd,dend);

%Un-normalize frequency
wd = ((wd/(2*pi))*fs);

%Plot H(z) frequency response
semilogx(wd, 20*log10(abs(hd)));
axis([6*10^5 3*10^6 -40 10])
grid on
grid minor

%Plot design specs
passBandLowerLimit = refline(0,-3);
stopBandUpperLimit = refline(0,-25);
passBandLowerLimit.Color='k';
stopBandUpperLimit.Color='k';

cutOffFrequency = line([1*10^6 1*10^6], [-80 10]);
stopBandStartFrequency = line([2*10^6 2*10^6], [-80 10]);
cutOffFrequency.Color='k';
stopBandStartFrequency.Color='k';

title('Frequency Response of H(z)');
xlabel('Frequency (Hz)');
ylabel('20Log|H(z)|');

%FIR Implementation********************************************************

%Setting up kaiser window parameters

n=36;           %Determined using Kaiser window equations
beta=1.339;     %Determined using Kaiser window equations
firFilter = fir1(n,pi/15, kaiser(n+1,beta)); %Create FIR filter with kaiser window

figure()
[d,wd]=freqz(firFilter,1); %calculating H(z)
plot(wd,20*log10(abs(d)))
title('Normalized Frequency Response of FIR Lowpass Filter')
xlabel('Frequency (rads/sec)')
ylabel('20Log|H(z)|')
axis([0 pi -80 5])
grid on
grid minor

%Plot normalized design specifications
passBandLowerLimit = refline(0,-3);
stopBandUpperLimit = refline(0,-25);
passBandLowerLimit.Color='k';
stopBandUpperLimit.Color='k';

cutOffFrequency = line([2*pi/15 2*pi/15], [-80 10]);
stopBandStartFrequency = line([4*pi/15 4*pi/15], [-80 10]);
cutOffFrequency.Color='k';
stopBandStartFrequency.Color='k';

%Un-normalize frequency and replot to display frequency response in MHz
figure()
plot(fs/2*wd/pi,20*log10(abs(d))) 
axis([0 4*10^6 -40 5])
grid on
grid minor
xlabel('Frequency (Hz)')
ylabel('20Log|H(z)|')
title('Frequency Response of FIR Lowpass Filter')

%Plot design requirements
passBandLowerLimit = refline(0,-3);
stopBandUpperLimit = refline(0,-25);
passBandLowerLimit.Color='k';
stopBandUpperLimit.Color='k';

cutOffFrequency = line([1*10^6 1*10^6], [-80 10]);
stopBandStartFrequency = line([2*10^6 2*10^6], [-80 10]);
cutOffFrequency.Color='k';
stopBandStartFrequency.Color='k';
