% Parameters
b = 0.3;        % transmission rate
sigma = 0.2;    % progression rate (1/latent period)
g = 0.1;        % recovery rate
mu = 0.01;      % disease-induced death rate

% Initial conditions [S, E, I, R]
N = 100000;
S_0 = N - 1;
E_0 = 0;
I_0 = 1;
R_0 = 0;
y_0 = [S_0; E_0; I_0; R_0; 0]; % add initial deaths D_0 = 0

% Time span
tspan = [0 160];

% Solve
[t, y] = ode45(@(t,y) seird_model(t, y, b, sigma, g, mu), tspan, y_0);

% Plot
plot(t, y)
legend('S', 'E', 'I', 'R', 'D')
xlabel('Time (days)')
ylabel('Population')
grid("on")
title('SEIR Model')
% Save the plot as PNG
saveas(gcf, 'seird_plot.png')