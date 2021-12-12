function [x_aumentado,y_aumentado] = desenhar_malha_deformada(x,y,u,n_nos,matriz_de_incidencias,tipo_elmnt)

n_gl = n_nos*2;
scale_factor = 1000;
x_aumentado = x + u(1:2:n_gl,1)*scale_factor;
y_aumentado = y + u(2:2:n_gl,1)*scale_factor;

%Desenhar a malha deformada
n_elementos=size(matriz_de_incidencias,1);

figure
plot (x_aumentado,y_aumentado,'ro');
hold on

if tipo_elmnt == 8 || tipo_elmnt == 6
    matriz_de_incidencias = matriz_de_incidencias(:,1:tipo_elmnt/2);
end

for i=1:n_elementos
    nDOFS=[matriz_de_incidencias(i,:) matriz_de_incidencias(i,1)];
    plot(x_aumentado(nDOFS),y_aumentado(nDOFS),'k');
    title('Malha Deformada')
end
hold off
end