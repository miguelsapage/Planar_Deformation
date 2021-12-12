function [epsilon,sigma,VMS] = tensao_extensao_triangulos_linear(matriz_propriedades,x,y,u,matriz_de_incidencias,n_elementos)
% Calcular tensão e extensão nos elementos

%Propriedades do material
E = matriz_propriedades(3); %Módulo de Young
nu = matriz_propriedades(4); %Coeficiente de Poisson
C = E/((1+nu)*(1-2*nu)) * [1-nu nu 0; nu 1-nu 0; 0 0 (1-2*nu)/2]; % defromação plana

sigma = zeros(n_elementos,3);
epsilon = zeros(n_elementos,3);
VMS = zeros(n_elementos,1);

%Graus de liberdade
for i=1:n_elementos
    no1 = matriz_de_incidencias(i,1);
    no2 = matriz_de_incidencias(i,2);
    no3 = matriz_de_incidencias(i,3);
    
    DOF1 = (no1-1)*2+1;
    DOF2 = (no2-1)*2+1;
    DOF3 = (no3-1)*2+1;
    
    DOFS = [DOF1 DOF1+1 DOF2 DOF2+1 DOF3 DOF3+1];
    
    delta = u(DOFS);
        
    [sigma(i,:), epsilon(i,:)] = Stress_Strain_TRI3(x(no1),y(no1),x(no2),y(no2),x(no3),y(no3),C,delta);
    
    %Tensão de Von Mises
    Sigz= nu*(sigma(i,1)+sigma(i,2));
    I1= sigma(i,1)+sigma(i,2)+Sigz ;
    I2= sigma(i,1)*sigma(i,2)+sigma(i,1)*Sigz+sigma(i,2)*Sigz-sigma(i,3)^2;
    VMS(i) = sqrt(I1*I1-3*I2);
end


end