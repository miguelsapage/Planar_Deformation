function [Ke fe]=Elem_ElasQuad8 (XN,C,he,fL)
%   Matriz XN(8,2) contem as coordenadas locais deste Quad de 8 nos
%   fL - intensidade da força uniforme  
%   inicializar Ke
 Ke = zeros(16,16);
 A = zeros(8,2);	% matriz auxiliar A(8x2) das derivadas parciais das
%	 funcoes de forma em (x,y)
 F = zeros(8,1);	% vector auxiliar F(8,1) das funcoes de forma
%--------------------------------------------------------------------------
%   gerar os pontos de integracao
nip = 9;
[xp wp]=Genip2DQ (nip);

%   percorrer os pontos de integracao
for ip=1:nip;	%	ciclo para os pontos de integracao

csi = xp(ip,1);
eta = xp(ip,2);
%
%   para cada ponto dado, calcular:   
%   a matriz A (8x2) das derivadas parciais das funcoes de forma em (x,y);  
%   funcoes de forma do Quad-8, no vector F(8x1);
%   jacobiano da transformacao, Detj.
%-------------------------------------------------------
[A F Detj]=Shape_N_Der8 (XN,csi,eta);
%--------------------------------------------------------------------------
%      forma a matriz B (3x16) para elasticidade plana
B=[A(1,1) 0 A(2,1) 0 A(3,1) 0 A(4,1) 0 A(5,1) 0 A(6,1) 0 A(7,1) 0 A(8,1) 0;...
   0 A(1,2) 0 A(2,2) 0 A(3,2) 0 A(4,2) 0 A(5,2) 0 A(6,2) 0 A(7,2) 0 A(8,2);...
   A(1,2) A(1,1) A(2,2) A(2,1) A(3,2) A(3,1) A(4,2) A(4,1) A(5,2) A(5,1) ...
   A(6,2) A(6,1) A(7,2) A(7,1) A(8,2) A(8,1)] ;
%--------------------------------------------------------------------------
%      forma a matriz Psi (2x16) para elasticidade plana
Psi=[F(1) 0 F(2) 0 F(3) 0 F(4) 0 F(5) 0 F(6) 0 F(7) 0 F(8) 0;...
     0 F(1) 0 F(2) 0 F(3) 0 F(4) 0 F(5) 0 F(6) 0 F(7) 0 F(8)] ;
%--------------------------------------------------------------------------
%   7) peso transformado
wip = he*wp(ip)*Detj;
%   8) calcular produto B'*C*B, pesar e somar a Ke
Ke = Ke + wip*B'*C*B ;
%   9) %   vector de cargas: somar fe aqui quando tiver de ser ;)
%wipf = fL*wip ;
%fe = fe + wipf*Psi ;
fe = zeros(16,1);    %   nao ha body forces
%	proximo ponto
end	%   fim de ciclo de integracao
end