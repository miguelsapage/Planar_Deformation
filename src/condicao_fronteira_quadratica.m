function [u] = condicao_fronteira_quadratica(matriz_tensoes,fg,Kg,...
    matriz_propriedades,matriz_dimensoes_elementos,matriz_fronteira)

espessura = matriz_propriedades(5);

% Condições de fronteira naturais
for i = 1:length(matriz_tensoes(:,1))
    elemento = matriz_tensoes(i, 1);
    no1 = matriz_tensoes(i, 2);
    no2 = matriz_tensoes(i, 3);
    no3 = matriz_tensoes(i, 4);
    
    fg(2*no1-1) = fg(2*no1-1) + matriz_tensoes(i, 5)*espessura*(matriz_dimensoes_elementos(elemento, 2))/6;
    fg(2*no1) = fg(2*no1) + matriz_tensoes(i, 6)*espessura*(matriz_dimensoes_elementos(elemento, 2))/6;
    fg(2*no2-1) = fg(2*no2-1) + matriz_tensoes(i, 5)*espessura*(matriz_dimensoes_elementos(elemento, 2))*(4/6);
    fg(2*no2) = fg(2*no2) + matriz_tensoes(i, 6)*espessura*(matriz_dimensoes_elementos(elemento, 2))*(4/6);
    fg(2*no3-1) = fg(2*no3-1) + matriz_tensoes(i, 5)*espessura*(matriz_dimensoes_elementos(elemento, 2))/6;
    fg(2*no3) = fg(2*no3) + matriz_tensoes(i, 6)*espessura*(matriz_dimensoes_elementos(elemento, 2))/6;
end

% Condições de fronteira essenciais
boom = 1e15;
for i = 1:length(matriz_fronteira(:,1))
    no = matriz_fronteira(i,1);
    iDOF = (no-1)*2+matriz_fronteira(i,2);
    Kg(iDOF,iDOF) = boom;
    fg(iDOF,1) = boom*0;
end

Kg = sparse(Kg);
fg = sparse(fg);
u = Kg\fg;

end