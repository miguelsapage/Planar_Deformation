function quadrangular_quadratico()

dados = fopen('placa_quadrados_quadratico.txt');
[matriz_dos_nos,n_nos,n_elementos,tipo_elmnt,matriz_de_incidencias,~,matriz_propriedades,~,~,~,matriz_fronteira,~,...
    ~,~,matriz_tensoes]= ler_dados(dados);

[x,y] = desenhar_malha(matriz_dos_nos,matriz_de_incidencias,tipo_elmnt);

[Kg,fg,matriz_dimensoes_elementos] = matriz_rigidez_quadrados_quadratica(matriz_de_incidencias,n_elementos,x,y,matriz_propriedades,n_nos);

[u] = condicao_fronteira_quadratica(matriz_tensoes,fg,Kg,matriz_propriedades,matriz_dimensoes_elementos,matriz_fronteira);

[x_aumentado,y_aumentado] = desenhar_malha_deformada(x,y,u,n_nos,matriz_de_incidencias,tipo_elmnt);

[epsilon,sigma,VMS] = tensao_extensao_quadrados_quadratico(matriz_propriedades,x,y,u,matriz_de_incidencias,n_elementos);

[tensao_max,tensao_min,extensao_max,extensao_min,energia_deformacao,deslocamentos,u_x_max,u_y_max,u_x_min,u_y_min,VMS_max,VMS_min]=tratamento_de_dados(sigma,epsilon,u,n_elementos,Kg,VMS);


fprintf('\n Tensão xx máxima = %f MPa\n Tensão yy máxima = %f MPa\n Tensão xy máxima = %f MPa', tensao_max(1),tensao_max(2),tensao_max(3))
fprintf('\n Tensão xx mínima = %f MPa\n Tensão yy mínima = %f MPa\n Tensão xy mínima = %f MPa', tensao_min(1),tensao_min(2),tensao_min(3))
fprintf('\n Extensão xx máxima = %f \n Extensão yy máxima = %f \n Extensão xy máxima = %f ', extensao_max(1),extensao_max(2),extensao_max(3))
fprintf('\n Extensão xx mínima = %f \n Extensão yy mínima = %f \n Extensão xy mínima = %f ', extensao_min(1),extensao_min(2),extensao_min(3))
fprintf('\n Tensão de Von-Mises máxima = %f MPa\n Tensão de Von-Mises mínima = %f MPa', VMS_max,VMS_min)
fprintf('\n Deslocamento mínimo em x = %f mm\n Deslocamento máximo em x = %f mm\n Deslocamento mínimo em y = %f mm\n Deslocamento máximo em y = %f mm', u_x_min,u_x_max,u_y_min,u_y_max)
fprintf('\n Energia de Deformação Elástica = %f kJ\n', energia_deformacao*10^-3);

plot_graficos(deslocamentos,matriz_de_incidencias,x_aumentado,y_aumentado,n_elementos,n_nos,tipo_elmnt,sigma,epsilon,VMS)
end