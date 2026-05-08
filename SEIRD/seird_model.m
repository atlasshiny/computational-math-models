function [dydt] = seird_model(~, y, b, sigma, g, mu)
%SEIRD model for disease prediction
%   Calculates the changes in the susceptible population, those who have
%   been exposed, infected, and cured/died, all of which are with respect
%   to time 't'.
arguments (Input)
    ~ %the time component
    y (5,1) double %contains the SEIRD data
    b double %the beta parameter, responsible for controlling transmission rate
    sigma double %rate of progression from exposed to infectious
    g double %recovery rate
    mu double %disease-induced death rate
end

arguments (Output)
    dydt (5,1) %a column vector containing the rates of change
end
S = y(1); %susceptible people
E = y(2); %exposed individuals
I = y(3); %infected individuals
R = y(4); %recovered/immune individuals
D = y(5); %deceased individuals
N = S + E + I + R + D; %the total population (including deaths)

dsdt = -(b * S * I) / N; %the rate of change describing how people go from being susceptible to being exposed (negative to show people leaving the susceptible group into the exposed group)
dedt = (b * S * I) / N - sigma * E; %the rate of change describing how people go from being susceptible to being exposed (positive to show people entering the exposed group)
didt = sigma * E - g * I; %the rate of change describing how exposed people get infected
drdt = g * I; %the "balance", which ensures that the total net change is zero (accounts for people who are immune/dead)
dddt = mu * I; %the rate of change describing how infected people die

dydt = [dsdt; dedt; didt; drdt; dddt];
end