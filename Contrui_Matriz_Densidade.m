%Programa principal
clear;
clc;
%format compact;
format long;
disp('            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('            %% ____________________________________________________________ %%');
disp('            %%|              Contrui as matrizes densidade                 |%%');
disp('            %%|                UNIVERSIDADE FEDERAL DE OURO PRETO          |%%');
disp('            %%|            Departamento de Engenharia Elétrica             |%%');
disp('            %%|____________________________________________________________|%%');
disp('            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
%------------ PARAMETROS ----------------------
caso = 'casoieee300';           %% arquivo de dados default e´ 'caso.m'
[rede, barras, nomes, linhas] = feval(caso);       %% Leitura do arquivo de dados.


%------ ordena as barras caso nao esteja ordenado
for i=1: length(barras(:,1))
    if i ~= barras(i,1)
        [barras,linhas] = OrdenaBarras(barras,linhas);
    end
end


%---------------  ORDENAÇ~AO  DE DADOS 
%%	Determinacao do tamanho da rede.
[NB , colunas] = size(barras);
[NR , colunas] = size(linhas);
%%	Carregamento dos vetores de barra.
%barras(:,5:8) = barras(:,5:8)/50;
for k = 1:NB    %% Lendo dados de cada barra.
        num(k)  = barras(k,1);  %% Número da barra.
        tipo(k) = barras(k,2);  %% Vetor de tipos das barras.
        vesp(k) = barras(k,3);  %% Vetor de tensoes das barras.
        ang(k)  = barras(k,4) * pi/180; %% Vetor de angulos convertidos para radianos.
        pg(k)   = barras(k,5);  %% Vetor de potencias ativas geradas nas barras.
        qg(k)   = barras(k,6);  %% Vetor de potencias reativas geradas nas barras.
        pc(k)   = barras(k,7);  %% Vetor de potencias ativas consumidas nas barras.
        qc(k)   = barras(k,8);  %% Vetor de potencias reativas consumidas nas barras.
        qmin(k) = barras(k,9);  %% Vetor de potencias reativas minimas nas barras.
        qmax(k) = barras(k,10); %% Vetor de potencias reativas maximas nas barras.
        vmin(k) = barras(k,11); %% Vetor de tensoes minimas nas barras.
        vmax(k) = barras(k,12); %% Vetor de tensoes maximas nas barras.
        bshk(k) = barras(k,13);  %% Vetor de shunts de barras.

        pesp(k) = pg(k) - pc(k);    %% Vetor de potencias ativas especificadas das barras.
        qesp(k) = qg(k) - qc(k);    %% Vetor de potencias reativas especificadas das barras.
    limQ(k,1:2) = 0;    %% Vetor de verificaçao de violaçao de reativos em barras PV.
    limV(k,1:2) = 0;    %% Vetor de verificaçao de violaçao de tensoes nas barras.
end

%%	Carregamento dos vetores de linha

for l = 1:NR    %% Lendo dados de cada linha.
	de(l)   = linhas(l,1);  %% Vetor de barras origem (barra k no modelo pi de linhas k-m).
	para(l) = linhas(l,2);  %% Vetor de barras destino (barra m no modelo pi de linhas k-m).
	r(l)    = linhas(l,3);  %% Vetor de resistencias das linhas.
	x(l)    = linhas(l,4);  %% Vetor de reatancias das linhas.
	bshl(l) = linhas(l,5) / 2.; %% Vetor de shunts de linhas (ja dividido por 2).
	tap(l,1:3)= linhas(l,6:8);  %% Vetor de tap's dos transformadores (se tap = 1 nao tem 
                              %% transformador na ligaçao, se tapmax = tapmin o transformador
                              %% tem tap fixo.
    Dtap(l) = 0;    %% Variaçao dos tap´s.
end

%---------- FIM DA ORDENAÇ~AO DOS DADOS
[Y, y] = fc_Y(NB, NR, bshk, de, para, r, x, bshl, tap); %% Funçao que retorna matriz admitancia
                                                        %% nodal e vetor de admitancias serie.

G = real(Y);    %% Matriz condutancia nodal.
B = imag(Y);    %% Matriz suscepitancia nodal.
%--------- COLOCA UNS E ZEROS NA MATRIZ ADMITANCIA


poss = find (Y(:) ~= 0);
Densidade = zeros(NB);
Densidade(poss)=1;

% xxx = Densidade(170,:) - Densidade(171,:)
% poss = find (xxx(:) == 0);
% length(poss)


%-------  gravaç~ao do arquivo em .m
if NB < 290  % o excel n~ao soporta + 290 colunas
    Nova_linhas=0;
    Nova_linhas=Densidade;
    [iu uu]=size(Nova_linhas);
    fid = fopen('linha_I.xlc','w');
    for i=1:iu    
        for j=1:uu  
            fprintf(fid,'%14.0f',Nova_linhas(i,j)); 
        end
        fprintf(fid,'\n');
    end 
    fclose(fid);
end
%%%%%%%%%%%%%%%%  Fim de save en formato .m

if NB > 290  % o excel n~ao soporta + 290 colunas    
    DensidadeTemp = zeros(NB,NB+1);
    DensidadeTemp (:,2:NB+1) = Densidade;
    Nova_linhas=0;
    Nova_linhas=DensidadeTemp;
    [iu uu]=size(Nova_linhas);
    fid = fopen('linha_I.m','w');
    for i=1:iu      
        for j=1:uu 
            if j==1
               fprintf(fid,'%6.0f',i);   
            else                
                fprintf(fid,'%6.0f',Nova_linhas(i,j));  
            end
        end
        fprintf(fid,'\n');
    end 
    fclose(fid);
end
%%%%%%%%%%%%%%%%  Fim de save en formato .m
