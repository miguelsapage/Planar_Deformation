function faz_grafico(matriz_de_incidencias,x,y,componente,n_elementos,n_nos,tipo_elmnt)

if tipo_elmnt == 8 || tipo_elmnt == 6
    matriz_de_incidencias = matriz_de_incidencias(:,1:tipo_elmnt/2);
    tipo_elmnt = tipo_elmnt/2;
end

X = zeros(tipo_elmnt,n_elementos) ;
Y = zeros(tipo_elmnt,n_elementos) ;
profile = zeros(tipo_elmnt,n_elementos) ;
nos = zeros(3,1);

for j=1:n_elementos
    for i=1:tipo_elmnt
        nos(i)=matriz_de_incidencias(j,i);
        X(i,j)=x(nos(i));
        Y(i,j)=y(nos(i));
        
    end
    
    if length(componente) == n_nos
        profile(:,j) = componente(nos') ;
    elseif length(componente) == n_elementos
        profile = componente;
    end
end




f3 = figure ;
set(f3,'name','Gráfico','numbertitle','off') ;
colormap(jet);
fill(X,Y,profile)
axis off ;
%REDEFINIR A COLORBAR
brighten(0.5);

barra = colorbar;
set(get(barra,'title'),'string','VAL');

clim = caxis;
ylim(barra,[clim(1) clim(2)]);
numpts = 24 ;
kssv = linspace(clim(1),clim(2),numpts);
set(barra,'YtickMode','manual','YTick',kssv);
for i = 1:numpts
    imep = num2str(kssv(i),'%+3.2E');
    vasu(i) = {imep} ;
end
set(barra,'YTickLabel',vasu(1:numpts),'fontsize',9);


end