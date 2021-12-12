function [Kg,fg,matriz_dimensoes_elementos] = matriz_rigidez_quadrados_linear(matriz_de_incidencias,n_elementos,x,y,matriz_propriedades,n_nos)

%Propriedades mecânicas do material
he = matriz_propriedades(5); %espessura
nu = matriz_propriedades(4); %número poisson
E = matriz_propriedades(3); %módulos de Young

%Extensão plana
C = E/((1+nu)*(1-2*nu)) * [1-nu nu 0; nu 1-nu 0; 0 0 (1-2*nu)/2];
n_gl=2*n_nos;            %número total de graus de liberdade

%Assemblagem
%Inicialização
Kg=zeros(n_gl,n_gl);
fg=zeros(n_gl,1);

for i=1:n_elementos
    no1 = matriz_de_incidencias(i,1);
    no2 = matriz_de_incidencias(i,2);
    no3 = matriz_de_incidencias(i,3);
    no4 = matriz_de_incidencias(i,4);
    nodes = matriz_de_incidencias(i,:);
    
    XN(1:4,1)=x(nodes);
    XN(1:4,2)=y(nodes);
    DOF1 = (no1-1)*2+1;
    DOF2 = (no2-1)*2+1;
    DOF3 = (no3-1)*2+1;
    DOF4 = (no4-1)*2+1;
    nDOFS=[DOF1 DOF1+1 DOF2 DOF2+1 DOF3 DOF3+1 DOF4 DOF4+1];
    
    [Ke, fe]= Elem_ElasQuad4 (XN,C,he,0); %Carregamento nulo
    
    Kg(nDOFS,nDOFS)= Kg(nDOFS,nDOFS) + Ke;
    fg(nDOFS,1)= fg(nDOFS,1) + fe;
end

matriz_dimensoes_elementos = zeros(n_elementos,3);

for i = 1:n_elementos
    a = abs(x(matriz_de_incidencias(i,1))-x(matriz_de_incidencias(i,2)));
    b = abs(y(matriz_de_incidencias(i,1))-y(matriz_de_incidencias(i,2)));
    c = abs(x(matriz_de_incidencias(i,2))-x(matriz_de_incidencias(i,3)));
    d = abs(y(matriz_de_incidencias(i,2))-y(matriz_de_incidencias(i,3)));
    e = abs(x(matriz_de_incidencias(i,3))-x(matriz_de_incidencias(i,4)));
    f = abs(y(matriz_de_incidencias(i,3))-y(matriz_de_incidencias(i,4)));
    g = abs(x(matriz_de_incidencias(i,4))-x(matriz_de_incidencias(i,1)));
    h = abs(y(matriz_de_incidencias(i,4))-y(matriz_de_incidencias(i,1)));
    
    comprimento = max([a,c,e,g]);
    largura = max([b,d,f,h]);
    
    %Matriz com comprimento e largura de cada elemento
    matriz_dimensoes_elementos(i,1) = i;
    matriz_dimensoes_elementos(i,2) = comprimento;
    matriz_dimensoes_elementos(i,3) = largura;
    
end

end