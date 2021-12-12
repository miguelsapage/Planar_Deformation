function [epsilon,sigma,VMS] = tensao_extensao_quadrados_linear(matriz_propriedades,x,y,u,matriz_de_incidencias,n_elementos)

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
    no4 = matriz_de_incidencias(i,4);
    
    nodes = matriz_de_incidencias(i,:);
    XN(1:4,1) = x(nodes);
    XN(1:4,2) = y(nodes);
    
    DOF1 = (no1-1)*2+1;
    DOF2 = (no2-1)*2+1;
    DOF3 = (no3-1)*2+1;
    DOF4 = (no4-1)*2+1;
    
    DOFS = [DOF1 DOF1+1 DOF2 DOF2+1 DOF3 DOF3+1 DOF4 DOF4+1];
    
    delta = u(DOFS);
    
    xi = 0;
    eta = 0;
    
    [sigma(i,:), epsilon(i,:)] = Stress_Strain_Quad4(XN,C,delta,xi,eta);
    
    %Tensão de Von Mises
    Sigz= nu*(sigma(i,1)+sigma(i,2));
    I1= sigma(i,1)+sigma(i,2)+Sigz ;
    I2= sigma(i,1)*sigma(i,2)+sigma(i,1)*Sigz+sigma(i,2)*Sigz-sigma(i,3)^2;
    VMS(i) = sqrt(I1*I1-3*I2);
end


end