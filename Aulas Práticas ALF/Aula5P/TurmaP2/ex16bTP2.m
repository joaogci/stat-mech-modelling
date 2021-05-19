clear all
close all

% p=[6/21, 5/21, 4/21, 3/21, 2/21, 1/21];
% [codigo]=huffman(p);
fid=fopen('MobyDickChapter1.txt','r');
A=fread(fid,'*char'); %le o ficheiro para variavel A que e' um vetor 
%de carateres
fclose(fid);

nct=numel(A); % numero de carateres no texto
fprintf(1,'Numero de carateres = %d\n',nct)
A_ascii=double(A);
%carateres diferentes usados
carateres_usados=unique(A_ascii);
h=hist(A_ascii,carateres_usados);
p=h/sum(h); % vetor de probabilidade dos carateres usados
fprintf(1,'Numero de carateres usados=%d\n',length(p));
figure(1)
plot(p,'r-')
xlabel('carater'); ylabel('p')

[codigo]=huffman(p)

S=-sum(p.*log2(p));
fprintf(1,'Entropia do texto (por carater)=%f bits\n',S)
% numero de bits medio de um carater
tam=cellfun('size',codigo,2);
L=sum(p.*tam');
fprintf(1,'Numero de bits medio de um carater=%f\n',L)
% Calculo do tamanho do texto na codificacao encontrada
tam_texto=0;
for i=1:nct
    tam_texto=tam_texto+tam(A(i)==carateres_usados);
end
fprintf(1,'Tamanho do texto nao comprimido=%f kB\n',nct/1024);

fprintf(1,'Tamanho do texto  comprimido=%f kB\n',tam_texto/8/1024);

%mensagem codificada
Acodificado=[];
% escreve a mensagem no codigo otimo
for i=1:nct
    Acodificado=[Acodificado char(codigo(find(A(i)==carateres_usados)))];
end

%  descompressor
% dada a mensagem codificada reproduzir a mensagem original
%%%%%%%
%fazer em casa




    
    





    