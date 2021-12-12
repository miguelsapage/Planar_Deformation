function [Ke fe]=Elem_ElasTRI6 (XN,C,he,fL)
%   Matriz XN(6,2) contem as coordenadas locais deste TRI de 6 nos
%   fL - intensidade da força uniforme  
%   inicializar Ke
 Ke = zeros(12,12);
 A = zeros(6,2);	% matriz auxiliar A(6x2) das derivadas parciais das
%	 funcoes de forma em (x,y)
 F = zeros(6,1);	% vector auxiliar F(6,1) das funcoes de forma
%--------------------------------------------------------------------------
%   gerar os pontos de integracao
nip = 7;
[xp wp]=GenipT (nip);

%   percorrer os pontos de integracao
for ip=1:nip;	%	ciclo para os pontos de integracao

csi = xp(ip,1);
eta = xp(ip,2);
%
%   para cada ponto dado, calcular:   
%   a matriz A (6x2) das derivadas parciais das funcoes de forma em (x,y);  
%   funcoes de forma do TRI-6, no vector F(6x1);
%   jacobiano da transformacao, Detj.
%-------------------------------------------------------
[A F Detj]=Shape_N_Der6 (XN,csi,eta);
%--------------------------------------------------------------------------
%      forma a matriz B (3x12) para elasticidade plana
B=[A(1,1) 0 A(2,1) 0 A(3,1) 0 A(4,1) 0 A(5,1) 0 A(6,1) 0;0 A(1,2) 0 A(2,2)...
   0 A(3,2) 0 A(4,2) 0 A(5,2) 0 A(6,2); A(1,2) A(1,1) A(2,2) A(2,1) A(3,2)...
   A(3,1) A(4,2) A(4,1) A(5,2) A(5,1) A(6,2) A(6,1)];
%--------------------------------------------------------------------------
%      forma a matriz Psi (2x12) para elasticidade plana
Psi=[F(1) 0 F(2) 0 F(3) 0 F(4) 0 F(5) 0 F(6) 0;0 F(1) 0 F(2) 0 F(3) 0 ...
     F(4) 0 F(5) 0 F(6)];
%--------------------------------------------------------------------------
%   7) peso transformado
wip = he*wp(ip)*Detj;
%   8) calcular produto B'*C*B, pesar e somar a Ke
Ke = Ke + wip*B'*C*B ;
%   9) %   vector de cargas: somar fe aqui quando tiver de ser ;)
%wipf = fL*wip ;
%fe = fe + wipf*Psi ;
fe = zeros(12,1);    %   nao ha body forces
%	proximo ponto
end	%   fim de ciclo de integracao
end