function [codigo]=huffman(p)
% vetor com as probabilidades de cada caracter
nco=length(p); % numero de carateres 

p_trab=p; % probabilidades dos caracteres presentes no alfabeto de trabalho
nc_trab=nco;% numero de carateres no alfabeto de trabalho

label(1:nco)=1:nco; % label dos caracteres armazenados cuja probabilidade
% esta armazenada no vetor p_trab

nc=nco;  % numero de carateres total=numero original+ numero dos criados

filhos=zeros(nc,2); % para registar os caracteres filhos dos carateres adicionados
% filhos=0 significa que não tem filhos


while nc_trab > 1  %retirar od dois carateres com menor probabilidade
    % e adicionar um carater com probabilidade igual a soma
    [p1,i1]=min(p_trab(1:nc_trab)); % p1 valor minimo de probabilidade e i1 
    %posicao no vetor p_trab onde ocorre 
    % eliminar este caracter do alfabeto de trabalho (eliminamos do vetor
    % p_trab)
    p_trab(i1)=p_trab(nc_trab); % copiamos o ultimo para a posicao a eliminar
    lab1=label(i1); % rotulo do carater eliminado
    label(i1)=label(nc_trab); nc_trab=nc_trab-1;
    
    % repetir para encontrar o segundo carater com menor probabilidade
    [p2,i2]=min(p_trab(1:nc_trab)); % p1 valor minimo de probabilidade e i1 
    %posicao no vetor p_trab onde ocorre 
    % eliminar este caracter do alfabeto de trabalho (eliminamos do vetor
    % p_trab)
    p_trab(i2)=p_trab(nc_trab); % copiamos o ultimo para a posicao a eliminar
    lab2=label(i2); % rotulo do carater eliminado
    label(i2)=label(nc_trab); nc_trab=nc_trab-1;
    
    % adicionar um novo caracter
    nc_trab=nc_trab+1; p_trab(nc_trab)=p1+p2;
    nc=nc+1; % criamos um carater
    label(nc_trab)=nc;
    filhos(nc,1)=lab1; filhos(nc,2)=lab2; %registamos os filhos do novo carater
    
    
end
codigo=repmat({''},nc,1); % fetor de cells
codigo(filhos(nc,1))={'0'}; codigo(filhos(nc,2))={'1'}; 
for i=nc-1:-1:1
    if filhos(i,1) >0
    codigo(filhos(i,1))=strcat(codigo(i),'0');codigo(filhos(i,2))=strcat(codigo(i),'1');
    % codigo dos filhos e' o codigo do pai concatenado com 0 (filho 1)
    % concatenado com 1 (filho 2)
    end
    
end
  codigo=codigo(1:nco);  

end