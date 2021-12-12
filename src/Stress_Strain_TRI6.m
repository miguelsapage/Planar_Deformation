function [Stress Strain]=Stress_Strain_TRI6 (XN,C,Delta,csi,eta)
%--------------------------------------------------------------------------
%   C  - Matriz Elastica para Elasticidade Plana
%--------------------------------------------------------------------------
%
A = zeros(6,2);	% matriz auxiliar A(6x2) das derivadas parciais das
%	funcoes de forma em (x,y) calculada na Shape_N_Der6
%--------------------------------------------------------------------------
%   para cada ponto (csi,eta) dado, calcular a matriz A (6x2) das 
%   derivadas parciais das funcoes de forma em (x,y)      
%------------------------------------------
[A F Detj]=Shape_N_Der6 (XN,csi,eta);
%--------------------------------------------------------------------------
%      forma a matriz B (3x12) para elasticidade plana
B=[A(1,1) 0 A(2,1) 0 A(3,1) 0 A(4,1) 0 A(5,1) 0 A(6,1) 0;0 A(1,2) 0 A(2,2)...
   0 A(3,2) 0 A(4,2) 0 A(5,2) 0 A(6,2); A(1,2) A(1,1) A(2,2) A(2,1) A(3,2)...
   A(3,1) A(4,2) A(4,1) A(5,2) A(5,1) A(6,2) A(6,1)];
%--------------------------------------------------------------------------
Strain = B*Delta;
Stress = C*Strain;
end