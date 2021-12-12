function plot_graficos(deslocamentos,matriz_de_incidencias,x_aumentado,y_aumentado,n_elementos,n_nos,tipo_elmnt,sigma,epsilon,VMS)
sigma_x = sigma(:,1);
sigma_y = sigma(:,2);
sigma_xy = sigma(:,3);
e_xx = epsilon(:,1);
e_yy = epsilon(:,2);
e_xy = epsilon(:,3);
u_x = deslocamentos(:, 2);
u_y = deslocamentos(:, 3);
VMS = VMS';


%Gráficos dos Deslocamentos
faz_grafico(matriz_de_incidencias,x_aumentado,y_aumentado,u_x,n_elementos,n_nos,tipo_elmnt);
title('Gráfico de deslocamentos em x')
faz_grafico(matriz_de_incidencias,x_aumentado,y_aumentado,u_y,n_elementos,n_nos,tipo_elmnt);
title('Gráfico de deslocamentos em y')
%Gráficos das Tensões
faz_grafico(matriz_de_incidencias,x_aumentado,y_aumentado,sigma_x,n_elementos,n_nos,tipo_elmnt);
title('Gráfico de \sigma_x')
faz_grafico(matriz_de_incidencias,x_aumentado,y_aumentado,sigma_y,n_elementos,n_nos,tipo_elmnt);
title('Gráfico de \sigma_y')
faz_grafico(matriz_de_incidencias,x_aumentado,y_aumentado,sigma_xy,n_elementos,n_nos,tipo_elmnt);
title('Gráfico de \sigma_{xy}')
faz_grafico(matriz_de_incidencias,x_aumentado,y_aumentado,VMS,n_elementos,n_nos,tipo_elmnt);
title('Gráfico de VMS')
%Gráficos das Extensões
faz_grafico(matriz_de_incidencias,x_aumentado,y_aumentado,e_xx,n_elementos,n_nos,tipo_elmnt);
title('Gráfico de \epsilon_{xx}')
faz_grafico(matriz_de_incidencias,x_aumentado,y_aumentado,e_yy,n_elementos,n_nos,tipo_elmnt);
title('Gráfico de \epsilon_{yy}')
faz_grafico(matriz_de_incidencias,x_aumentado,y_aumentado,e_xy,n_elementos,n_nos,tipo_elmnt);
title('Gráfico de \epsilon_{xy}')


end