clear all
close all
clc
% p=[6/21, 5/21, 4/21, 3/21, 2/21, 1/21];
% [codigo]=huffman(p)
% pause

fid=fopen('MobyDickChapter1.txt','r');
A=fread(fid,'*char');
A=A';
fclose(fid);

l1=numel(A); %numero de caracteres
na=double(A);
A=A(na>0); % eliminamos caracteres que nao sao reconhecidos pelo matlab
l1=numel(A); %numero de caracteres
na=double(A);
caracter2ascii=unique(na); % codigo ascii dos caracteres que
%aparecem na mensagem
ncarateres=numel(caracter2ascii);
vmin=min(caracter2ascii); vmax=max(caracter2ascii);
[h]=hist(na,vmin:vmax);
h=h(h>0); % caracteres que aparecem no texto
p=h/sum(h);
figure(1)
plot(p,'r-')
xlabel('caracter'); ylabel('p')

[codigo]=huffman(p)
S=-sum(p.*log2(p));%entropia
fprintf(1,'Entropia do texto (por caracter)=%f bits\n',S)
%tam=strlength(codigo); % apenas versao Matlab2020
tam=cellfun('size',codigo,2); % 
%cellfun(FUN, C) applies the function specified by FUN to the
%    contents of each cell of cell array C, and returns the results in
%    the array A

L=sum(tam'.*p);% tamanho do codigo otimo
fprintf(1,'Numero medio de bits otimo por caracter=%f  bits\n',L)

%Numero de bits do texto
tam_texto=0;
for i=1: l1
    tam_texto=tam_texto+tam(A(i)==caracter2ascii);
end
fprintf(1,'Tamanho do texto comprimido =%f bits\n',tam_texto)

fprintf(1,'Tamanho do texto comprimido =%f kB\n',tam_texto/8/1024)% em kBytes
    