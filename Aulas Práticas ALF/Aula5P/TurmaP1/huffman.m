function [codigo]=huffman(p)
nco=length(p); % numero de caracteres no alfabeto original
label(1:nco)=1:nco;
filhos=zeros(nco,2); % para registar filhos

p_trab=p; % vai ter comprimento variavel
nc_trab=nco;
nc=nco;
while  nc_trab>1
    [p1, i1]=min(p_trab(1:nc_trab));
    p_trab(i1)=p_trab(nc_trab);  % eliminamos o caracter i1
     %do vetor p_trab
     lab1=label(i1);
    label(i1)=label(nc_trab); nc_trab=nc_trab-1;
     
   
    [p2, i2]=min(p_trab(1:nc_trab));
    p_trab(i2)=p_trab(nc_trab);  % eliminamos o caracter i2
   %do vetor p_trab
    lab2=label(i2);
    label(i2)=label(nc_trab);nc_trab=nc_trab-1;
 
    % acrescentamos um novo caracter composto
    nc_trab=nc_trab+1; p_trab(nc_trab)=p1+p2;
    nc=nc+1; filhos(nc,1)=lab1; filhos(nc,2)=lab2;
    label(nc_trab)=nc;   
end
    
    % percorremos a lista de caracteres do ultimo acrescentado para o
    % primeiro  atribuindo a cada filho um codigo
    
    % Em versoes de matlab antigas nao ha' arrays de strings e temos que
    % usar arrays de cells
    %Esta versao funciona em Matlab 2014 e Matlab2020
    
    codigo=repmat({' '},nc,1); % cria um array de cells
    codigo(filhos(nc,1))={'0'}; codigo(filhos(nc,2))={'1'};
    
    %codigo=repmat("" ,nc,1); %apenas Matlab 2020
    %codigo(filhos(nc,1))="0"; codigo(filhos(nc,2))="1"; %apenas Matlab 2020
    
    for i=nc-1:-1:1
        if(filhos(i,1) >0) 
        codigo(filhos(i,1))=strcat(codigo(i,1), '0'); 
        codigo(filhos(i,2))=strcat(codigo(i,1), '1'); 
        %codigo(filhos(i,1))=strcat(codigo(i,1), "0"); %apenas Matlab 2020
        %codigo(filhos(i,2))=strcat(codigo(i,1), "1"); %apenas Matlab 2020
        end
    end
  codigo=codigo(1:nco);
end