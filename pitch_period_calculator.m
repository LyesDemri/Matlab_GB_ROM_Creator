clear;clc;close all;

frequency = 61.74;

%frequency = 131072/(2048-period_value)
%2048-period_value = 131072/frequency
%period_value = 2048-131072/frequency

period_value = round(2048-131072/frequency)

period_value = de2bi(abs(period_value),12,'left-msb')


period_value = 1-period_value
period_value = char(period_value+char('0'))
period_value = bin2dec(period_value)+1
period_value = dec2hex(period_value)