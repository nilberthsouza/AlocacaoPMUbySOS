function [Y, y] = fc_Y(NB, NR, bshk, de, para, r, x, bshl, tap)
%fc_Y Monta matriz admitância nodal.
%	------------------------------------------------------------------------------------------------
%
%	fc_Y.m
%
%   [Y, y] = fc_Y(NB, NR, bshk, de, para, r, x, bshl, tap)
%
%	Monta matriz admitância nodal.
%
%   Monta a matriz admitância nodal a partir do número de barras e de linhas,
%   dos dados de shunt das barras, dos dados das linhas e dos dados dos transformadores.
%   O modelo utilizado para o transformador é da barra k para barra m, 
%   com admitância série do lado de m e relação 1:a do lado de k.
%   Aqui não são considerados transformadores defasadores, apenas transformadores em fase.
%   Esta função retorna a matriz admitância Y e o vetor de admitâncias série das linhas.
%
%   FluxodeCarga Versão 1.0.1
%   por Márcio Venício P. Alcântara, DSCE - FEEC - UNICAMP
%
%	Última modificação: 17 de junho 2003
%   Distribuição permitida desde que citada a fonte 
%   Departamento de Sistemas e Controle de Energia (DSCE)
%   Visite http://www.marcio.ezdir.net para mais informações
%   ou envie e-mail para marcio@dsce.fee.unicamp.br para mais informações
%	------------------------------------------------------------------------------------------------

Y = zeros(NB,NB);   %% Inicialização da matriz admitância com zeros.

for k = 1:NB
	Y(k,k) = i*bshk(k); %% Soma dos elementos shunt de barras na diagonal
                        %% principal da matriz admitância.
end

for l = 1:NR
    k = de(l);
    m = para(l);

    y(l) = 1/(r(l) + i*x(l));   %% Cálculo da admitância série das linha.

    akk(l) = tap(l,1)*(tap(l,1)-1); %% fator do elemento B do modelo pi do transformador em fase.
    amm(l) = 1-tap(l,1);  %% fator do elemento C do modelo pi do transformador em fase.
    akm(l) = tap(l,1);    %% fator do elemento A do modelo pi do transformador em fase.

    Y(k,k) = Y(k,k) + akm(l)*y(l) + akk(l)*y(l)+ i*bshl(l); %% Soma dos elementos shunt de linha,
    Y(m,m) = Y(m,m) + akm(l)*y(l) + amm(l)*y(l) + i*bshl(l); %% admitância série A de linha,
                                              %% e admitâncias B ou C do modelo pi do transformador,
                                              %% na diagonal principal.

    Y(k,m) = Y(k,m) - akm(l)*y(l);  %% Soma das admitâncias série A de linha (akm = 1 sem transformador)
    Y(m,k) = Y(m,k) - akm(l)*y(l);  %% nos elementos fora da diagonal principal.
    
end
l;
return;