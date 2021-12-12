function[x,y] = desenhar_malha(matriz_dos_nos,matriz_de_incidencias,tipo_elmnt)

x = matriz_dos_nos(:,1);
y = matriz_dos_nos(:,2);

% Desenha a malha
n_elmts=size(matriz_de_incidencias,1);
figure
plot(x,y,'ro');hold

if tipo_elmnt == 8 || tipo_elmnt == 6
    matriz_de_incidencias = matriz_de_incidencias(:,1:tipo_elmnt/2);
end

for i=1:n_elmts
    nDOFS=[matriz_de_incidencias(i,:) matriz_de_incidencias(i,1)]; %conectividade
    plot(x(nDOFS),y(nDOFS),'b');hold on
    title('Malha')
end

end