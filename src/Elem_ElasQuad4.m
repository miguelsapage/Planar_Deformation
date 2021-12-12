function [Ke, fe]=Elem_ElasQuad4 (XN,C,he,fL)
%   Matriz XN(4,2) contem as coordenadas locais deste quad de 4 nos
%   fL - intensidade da força uniforme  
%   inicializar Ke
 Ke = zeros(8,8);
 A = zeros(4,2);	% matriz auxiliar A(4x2) das derivadas parciais das
%	 funcoes de forma em (x,y)
 F = zeros(4,1);	% vector auxiliar F(4,1) das funcoes de forma
%--------------------------------------------------------------------------
%   gerar os pontos de integracao
nip = 4;
[xp, wp]=Genip2DQ (nip);

%   percorrer os pontos de integracao
for ip=1:nip	%	ciclo para os pontos de integracao

csi = xp(ip,1);
eta = xp(ip,2);
%
%   para cada ponto dado, calcular:   
%   a matriz A (4x2) das derivadas parciais das funcoes de forma em (x,y);  
%   funcoes de forma do quad-4, no vector F(4x1);
%   jacobiano da transformacao, Detj.
%-------------------------------------------------------
[A, F, Detj]=Shape_N_Der4 (XN,csi,eta);
%--------------------------------------------------------------------------
%      forma a matriz B (3x8) para elasticidade plana
B=[A(1,1) 0 A(2,1) 0 A(3,1) 0 A(4,1) 0;0 A(1,2) 0 A(2,2) 0 A(3,2) 0 A(4,2);...
   A(1,2) A(1,1) A(2,2) A(2,1) A(3,2) A(3,1) A(4,2) A(4,1)];
%--------------------------------------------------------------------------
%      forma a matriz Psi (2x8) para elasticidade plana
Psi=[F(1) 0 F(2) 0 F(3) 0 F(4) 0;0 F(1) 0 F(2) 0 F(3) 0 F(4)];
%--------------------------------------------------------------------------
%   7) peso transformado
wip = he*wp(ip)*Detj;
%   8) calcular produto B'*C*B, pesar e somar a Ke
Ke = Ke + wip*B'*C*B ;
%   9) %   vector de cargas: somar fe aqui quando tiver de ser ;)
%wipf = fL*wip ;
%fe = fe + wipf*Psi ;
fe = zeros(8,1);    %   nao ha body forces
%	proximo ponto
end	%   fim de ciclo de integracao
end