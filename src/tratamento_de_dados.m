function [tensao_max,tensao_min,extensao_max,extensao_min,energia_deformacao,deslocamentos,u_x_max,u_y_max,u_x_min,...
    u_y_min,VMS_max,VMS_min]=tratamento_de_dados(sigma,epsilon,u,n_elementos,Kg,VMS)

%Tensão
sigma_x = zeros(n_elementos,1);
sigma_y = zeros(n_elementos,1);
sigma_xy = zeros(n_elementos,1);

for  i = 1:n_elementos
    sigma_x(i) = sigma(i,1);
    sigma_y(i) = sigma(i,2);
    sigma_xy(i) = sigma(i,3);
end
sig_x_max = max(abs(sigma_x));
sig_y_max = max(abs(sigma_y));
sig_xy_max = max(abs(sigma_xy));
tensao_max = [sig_x_max,sig_y_max,sig_xy_max]*10^-6;

sig_x_min = min(abs(sigma_x));
sig_y_min = min(abs(sigma_y));
sig_xy_min = min(abs(sigma_xy));
tensao_min = [sig_x_min,sig_y_min,sig_xy_min]*10^-6;

%Extensão
epsilon_x = zeros(n_elementos,1);
epsilon_y = zeros(n_elementos,1);
epsilon_xy = zeros(n_elementos,1);

for  i = 1:n_elementos
    epsilon_x(i) = epsilon(i,1);
    epsilon_y(i) = epsilon(i,2);
    epsilon_xy(i) = epsilon(i,3);
end
eps_x_max = max(abs(epsilon_x));
eps_y_max = max(abs(epsilon_y));
eps_xy_max = max(abs(epsilon_xy));
extensao_max = [eps_x_max,eps_y_max,eps_xy_max];

eps_x_min = min(abs(epsilon_x));
eps_y_min = min(abs(epsilon_y));
eps_xy_min = min(abs(epsilon_xy));
extensao_min = [eps_x_min,eps_y_min,eps_xy_min];

%Calcula a energia de deformação elástica
energia_deformacao = double(0.5*u'*Kg*u*10^-6);

deslocamentos = zeros(length(u)/2,3);

for i = 1:(length(u)/2)
    deslocamentos(i, 1) = i; %número do nó
    deslocamentos(i, 2) = u((2*i)-1); %deslocamento em x
    deslocamentos(i, 3) = u(2*i);  %deslocamento em y
end


u_x_max = max(abs(deslocamentos(:,2)));
u_y_max = max(abs(deslocamentos(:,3)));
u_x_min = min(abs(deslocamentos(:,2)));
u_y_min = min(abs(deslocamentos(:,3)));

VMS_max = max(abs(VMS*10^-6));
VMS_min = min(abs(VMS*10^-6));


end