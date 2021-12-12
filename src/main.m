% MECÂNICA COMPUTACIONAL - LEMec - 2021/2022
% G30
% 96291 - Miguel Sapage

clear
clc
close all

choice = menu('Escolha o tipo de malha:', 'Elementos Triangulares de 3 nós' , 'Elementos Triangulares de 6 nós',...
    'Elementos Quadrangulares de 4 nós', 'Elementos Quadrangulares de 8 nós', 'Exemplo com Geometria Simples');
if choice == 1
    triangular_linear()
elseif choice == 2
    triangular_quadratico()
elseif choice == 3
    quadrangular_linear()
elseif choice == 4
    quadrangular_quadratico()
elseif choice == 5
    choice = menu('Escolha o tipo de elementos:', 'Elementos Quadrangulares', 'Elementos Triangulares');
    if choice == 1
        geometria_simples_quadrangular()
    elseif choice == 2
        geometria_simples_triangular()
    end
end