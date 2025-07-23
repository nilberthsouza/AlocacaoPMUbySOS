function [Y, y] = fc_Y(NB, NR, bshk, de, para, r, x, bshl, tap)
%fc_Y Monta matriz admit�ncia nodal.
%	------------------------------------------------------------------------------------------------
%
%	fc_Y.m
%
%   [Y, y] = fc_Y(NB, NR, bshk, de, para, r, x, bshl, tap)
%
%	Monta matriz admit�ncia nodal.
%
%   Monta a matriz admit�ncia nodal a partir do n�mero de barras e de linhas,
%   dos dados de shunt das barras, dos dados das linhas e dos dados dos transformadores.
%   O modelo utilizado para o transformador � da barra k para barra m, 
%   com admit�ncia s�rie do lado de m e rela��o 1:a do lado de k.
%   Aqui n�o s�o considerados transformadores defasadores, apenas transformadores em fase.
%   Esta fun��o retorna a matriz admit�ncia Y e o vetor de admit�ncias s�rie das linhas.
%
%   FluxodeCarga Vers�o 1.0.1
%   por M�rcio Ven�cio P. Alc�ntara, DSCE - FEEC - UNICAMP
%
%	�ltima modifica��o: 17 de junho 2003
%   Distribui��o permitida desde que citada a fonte 
%   Departamento de Sistemas e Controle de Energia (DSCE)
%   Visite http://www.marcio.ezdir.net para mais informa��es
%   ou envie e-mail para marcio@dsce.fee.unicamp.br para mais informa��es
%	------------------------------------------------------------------------------------------------

Y = zeros(NB,NB);   %% Inicializa��o da matriz admit�ncia com zeros.

for k = 1:NB
	Y(k,k) = i*bshk(k); %% Soma dos elementos shunt de barras na diagonal
                        %% principal da matriz admit�ncia.
end

for l = 1:NR
    k = de(l);
    m = para(l);

    y(l) = 1/(r(l) + i*x(l));   %% C�lculo da admit�ncia s�rie das linha.

    akk(l) = tap(l,1)*(tap(l,1)-1); %% fator do elemento B do modelo pi do transformador em fase.
    amm(l) = 1-tap(l,1);  %% fator do elemento C do modelo pi do transformador em fase.
    akm(l) = tap(l,1);    %% fator do elemento A do modelo pi do transformador em fase.

    Y(k,k) = Y(k,k) + akm(l)*y(l) + akk(l)*y(l)+ i*bshl(l); %% Soma dos elementos shunt de linha,
    Y(m,m) = Y(m,m) + akm(l)*y(l) + amm(l)*y(l) + i*bshl(l); %% admit�ncia s�rie A de linha,
                                              %% e admit�ncias B ou C do modelo pi do transformador,
                                              %% na diagonal principal.

    Y(k,m) = Y(k,m) - akm(l)*y(l);  %% Soma das admit�ncias s�rie A de linha (akm = 1 sem transformador)
    Y(m,k) = Y(m,k) - akm(l)*y(l);  %% nos elementos fora da diagonal principal.
    
end
l;
return;