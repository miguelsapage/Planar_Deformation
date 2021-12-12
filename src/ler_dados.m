function[matriz_dos_nos,n_nos,n_elementos,tipo_elmnt,matriz_de_incidencias,n_propriedades,matriz_propriedades,...
    n_carregamentos,matriz_carregamentos,n_fronteira,matriz_fronteira,n_cargas,...
    matriz_cargas_pontuais,n_tensoes,matriz_tensoes]= ler_dados(dados)

fgetl(dados);
string1=strcat(upper(fgetl(dados))); %ler o ficheiro e converter em string
string2='COORDENADAS';


if strfind(string1,string2)==1
    %Coordenadas dos Nós
    n_nos = fscanf (dados, '%f', 1);
    matriz_dos_nos = fscanf (dados,'%e', [3 inf]);
    matriz_dos_nos = matriz_dos_nos';
    matriz_dos_nos = matriz_dos_nos(:,2:end);
    
    %Matriz de Incidências
    fgetl(dados);
    n_elementos = fscanf (dados, '%f', 1);
    incidencias_linha = fscanf (dados,'%e');
    tipo_elmnt = incidencias_linha(3);
    incidencias_linha = reshape(incidencias_linha, [tipo_elmnt + 3, n_elementos])';
    matriz_de_incidencias =  incidencias_linha(:,4:end);
    
    %Propriedades do Material
    fgetl(dados);
    n_propriedades = fscanf (dados, '%f', 1);
    matriz_propriedades=fscanf (dados,'%e', [6 inf]);
    matriz_propriedades=matriz_propriedades';
    
    %Carregamentos Distribuídos
    fgetl(dados);
    n_carregamentos = fscanf (dados, '%f', 1);
    matriz_carregamentos=fscanf (dados,'%e', [6 inf]);
    matriz_carregamentos=matriz_carregamentos';
    
    %Condições de Fronteira
    fgetl(dados);
    n_fronteira = fscanf (dados, '%f', 1);
    matriz_fronteira=fscanf (dados,'%e', [3 inf]);
    matriz_fronteira=matriz_fronteira';
    
    %Cargas Pontuais
    fgetl(dados);
    n_cargas=fgetl(dados);
    matriz_cargas_pontuais=fscanf(dados,'%e', [3 inf]);
    matriz_cargas_pontuais=matriz_cargas_pontuais';
    
    %Tensão na Fronteira
    fgetl(dados);
    n_tensoes=fgetl(dados);
    if tipo_elmnt == 8 || tipo_elmnt == 6
        matriz_tensoes=fscanf(dados,'%e', [6 inf]);
    else
        matriz_tensoes=fscanf(dados,'%e', [5 inf]);
    end
    matriz_tensoes=matriz_tensoes';
end
end