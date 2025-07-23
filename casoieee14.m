function [rede, barras, linhas] = caso
%function [rede, barras,nomes, linhas] = caso

%CASO Define os dados do fluxo de carga em um formato adequado ao programa Fluxo de Carga.
%   ------------------------------------------------------------------------------------------------
%   
%   [rede, barras, nomes, linhas] = caso
%
%   O formato dos dados é similar a outros existentes, como o IEEE Common
%   Data Format ou o PTI format.
%
%   Nome da Rede
%       rede, variável que recebe uma string como nome dado à rede
%
%   Formato dos Dados das Barras
%       1   número da barra (1 até 9999)
%       2   tipo da barra
%               barra PQ                    = 0
%               barra PV                    = 1
%               barra de referência (VTeta) = 2
%       3   Vk, magnitude da tensão (p.u.)
%       4   Fase, ângulo da tensão (graus)
%       5   Pg, potência ativa gerada (p.u.)
%       6   Qg, potência reativa gerada (p.u.)
%       7   Pc, potência ativa demandada (p.u.)
%       8   Qc, potência reativa demandada (p.u.)
%       9   Qmin, potência reativa de saída mínima (p.u.)
%      10   Qmax, potência reativa de saída máxima (p.u.)
%      11   Vmin, tensão mínima na barra (p.u.)
%      12   Vmax, tensão máxima na barra (p.u.)
%      13   bshk, susceptância de shunt (p.u.)
%   Nomes
%       1   nome da barra em cada linha no formato 'nome';
%
%   Formato dos Dados das Linhas
%       1   De, número da barra origem
%       2   Para, número da barra destino
%       3   r, resistência série (p.u.)
%       4   x, reatância série (p.u.)
%       5   bshl, susceptância shunt de linha (total) (p.u.)
%       6   tap, relação de transformação 1:a (a -> número real)
%           (tap = 1 para linhas sem transformador, taps estão na barra 'de',
%                           impedância na barra 'para', defasador não é considerado)
%       7   tapmin, valor mínimo que pode assumir a relação de transformação.
%       8   tapmax, valor máximo que pode assumir a relação de transformação.
%
%   por Márcio Venício P. Alcântara, DSCE - FEEC - UNICAMP
%
%   Última modificação: 21 de maio 2003
%   Distribuição permitida desde que citada a fonte 
%   Departamento de Sistemas e Controle de Energia (DSCE)
%   Visite http://www.marcio.ezdir.net para mais informações
%   ou envie e-mail para marcio@dsce.fee.unicamp.br para mais informações
%   ------------------------------------------------------------------------------------------------


%%   Nome da Rede

rede = 'Modelo Teste IEEE 14 Barras';

%%	Dados das Barras
%%
%%	Num   Tipo    Vk     Fase      Pg        Qg          Pc       Qc     Qmin     Qmax Vmin  Vmax  bshk

barras = [
  1      3     1.060        0.0    2.324    -0.169    0.000   	0.000   	0.00	   0.00      0.95       1.05      0.0;
  2      2     1.045      -4.98    0.400   	0.424	   0.217   	0.127   	0.50	  -0.40      0.95    	1.10	  0.0;
  3      2     1.010     -12.72    0.000   	0.234	   0.942   	0.190   	0.40	   0.00      0.95    	1.05	  0.0;
  4      0     1.019     -10.33    0.000   	0.000	   0.478   -0.039   	0.00	   0.00      0.95    	1.05	  0.0;
  5      0     1.020      -8.78    0.000   	0.000	   0.076   	0.016   	0.00	   0.00      0.95    	1.05	  0.0;
  6      2     1.070     -14.22    0.000   	0.122	   0.112   	0.075   	0.24	  -0.06      0.95    	1.05	  0.0;
  7      0     1.062     -13.37    0.000   	0.000	   0.000   	0.000   	0.00	   0.00      0.95    	1.05	  0.0;
  8      2     1.090     -13.36    0.000   	0.174	   0.000   	0.000   	0.24	  -0.06      0.95    	1.05	  0.0;
  9      0     1.056     -14.94    0.000   	0.000	   0.295   	0.166   	0.00	   0.00      0.95    	1.05	  0.19;
 10      0     1.051     -15.10    0.000   	0.000	   0.090   	0.058   	0.00	   0.00      0.95    	1.05	  0.0;
 11      0     1.057     -14.79    0.000   	0.000	   0.035   	0.018   	0.00	   0.00      0.95    	1.05	  0.0;
 12      0     1.055     -15.07    0.000   	0.000	   0.061   	0.016   	0.00	   0.00      0.95    	1.05	  0.0;
 13      0     1.050     -15.16    0.000   	0.000	   0.135   	0.058   	0.00	   0.00      0.95    	1.10	  0.0;
 14      0     1.036     -16.04    0.000   	0.000	   0.149   	0.050   	0.00	   0.00      0.95    	1.05	  0.0];

Nomes = {
 	  'Bus 1 HV';	'Bus 2 HV';	'Bus 3 HV';	'Bus 4 HV';	'Bus 5 HV';	'Bus 6 HV';	'Bus 7 HV';	'Bus 8 HV';	'Bus 9 HV';
      'Bus 10 HV';	'Bus 11 HV';	'Bus 12 HV';	'Bus 13 HV';	'Bus 14 HV'};

%%	Dados das Linhas
%%
%%	De Para     r         x        bshl  tap  tapmin tapmax

linhas  = [
     1   2	0.01938   0.05917     0.0528 1.0   1.0     1.0;
     1   5	0.05403   0.22304     0.0492 1.0   1.0     1.0;
     2   3	0.04699   0.19797     0.0438 1.0   1.0     1.0;
     2   4 	0.05811   0.17632     0.0340 1.0   1.0	   1.0;
     2   5 	0.05695   0.17388     0.0346 1.0   1.0     1.0;
     3	 4	0.06701   0.17103     0.0128 1.0   1.0     1.0;
     4	 5	0.01335   0.04211     0.0    1.0   1.0     1.0;
     4	 7	0.0       0.20912     0.0    0.978 1.0     1.0;
     4	 9	0.0       0.55618     0.0    0.969 1.0	   1.0;
     5	 6	0.0       0.25202     0.0    0.932 1.0     1.0;
     6	11	0.09498   0.19890     0.0    1.0   1.0     1.0;
     6	12	0.12291   0.25581     0.0    1.0   1.0     1.0;
     6	13	0.06615   0.13027     0.0    1.0   1.0     1.0;
     7	 8	0.0       0.17615     0.0    1.0   1.0	   1.0;
     7	 9	0.0       0.11001     0.0    1.0   1.0     1.0;
     9	10	0.03181   0.08450     0.0    1.0   1.0     1.0;
     9	14	0.12711   0.27038     0.0    1.0   1.0     1.0;
    10	11	0.08205   0.19207     0.0    1.0   1.0     1.0;
    12	13	0.22092   0.19988     0.0    1.0   1.0	   1.0;
    13	14	0.17093   0.34802     0.0    1.0   1.0     1.0];

return;