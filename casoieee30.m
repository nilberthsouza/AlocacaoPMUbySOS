function [rede, barras, nomes, linhas] = caso
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
%               barra de referência (vteta) = 2
%       3   Vk, magnitude da tensão (p.u.)
%       4   Fase, ângulo da tensão (graus)
%       5   Pg, potência ativa gerada (p.u.)
%       6   Qg, potência reativa gerada (p.u.)
%       7   Pc, potência ativa demandada (p.u.)
%       8   Qc, potência reativa demandada (p.u.)
%       9   Qmin, potência reativa de saída mínima (p.u.)
%      10   Qmax, potência reativa de saída máxima (p.u.)
%      11   bshk, susceptância de shunt (p.u.)
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
%
%   por Márcio Venício P. Alcântara, DSCE - FEEC - UNICAMP
%
%   Última modificação: 23 de junho 2003
%   Distribuição permitida desde que citada a fonte 
%   Departamento de Sistemas e Controle de Energia (DSCE)
%   Visite http://www.marcio.ezdir.net
%   ou envie e-mail para marcio@dsce.fee.unicamp.br para mais informações
%   ------------------------------------------------------------------------------------------------


%%   Nome da Rede

rede = 'Modelo Teste IEEE 30 barras';

%%	Dados das Barras
%%
%%	  Num    Tipo  Vk   Fase   Pg    Qg     Pc      Qc     Qmin   Qmax      Vmin    Vmax    bshk

barras = [
  	   1	  2	   1.0	0.0	  2.60  -0.16   0.0     0.0     -999   999   	0.95    1.05     0.0;
  	   2	  1	   1.0	0.0	  0.40   0.50   0.217   0.127   -0.40  0.50 	0.95	1.10	 0.0;
  	   3	  0	   1.0	0.0	   0.0   0.0    0.024   0.012   -999   999  	0.95	1.05	 0.0;  
  	   4	  0	   1.0	0.0	   0.0   0.0    0.076   0.016   -999   999  	0.95	1.05	 0.0;  
  	   5	  1	   1.0	0.0	   0.0   0.37   0.942   0.19    -0.40  0.40 	0.95	1.05	 0.0;  
  	   6	  0	   1.0	0.0	   0.0   0.0    0.0     0.0     -999   999  	0.95	1.05	 0.0;  
  	   7	  0	   1.0	0.0	   0.0   0.0    0.228   0.109   -999   999  	0.95	1.05	 0.0;  
  	   8	  1	   1.0	0.0	   0.0   0.373  0.30    0.30    -0.10  0.40 	0.95	1.05	 0.0;  
  	   9	  0	   1.0	0.0	   0.0   0.0    0.0     0.0     -999   999  	0.95	1.05	 0.0;  
  	  10	  0	   1.0	0.0	   0.0   0.0    0.058   0.02    -999   999  	0.95	1.05	 0.19; 
  	  11	  1	   1.0	0.0	   0.0   0.16   0.0     0.0     -0.06  0.24 	0.95	1.05	 0.0;  
  	  12	  0	   1.0	0.0	   0.0   0.0    0.112   0.075   -999   999  	0.95	1.05	 0.0;  
  	  13	  1	   1.0	0.0	   0.0   0.10   0.0     0.0     -0.06  0.24 	0.95	1.10	 0.0;  
  	  14	  0	   1.0	0.0	   0.0   0.0    0.062   0.016   -999   999  	0.95	1.05	 0.0;  
  	  15	  0	   1.0	0.0	   0.0   0.0    0.082   0.025   -999   999  	0.95	1.05	 0.0;  
  	  16	  0	   1.0	0.0	   0.0   0.0    0.035   0.018   -999   999  	0.95	1.05	 0.0;  
  	  17	  0	   1.0	0.0	   0.0   0.0    0.090   0.058   -999   999  	0.95	1.05	 0.0;  
  	  18	  0	   1.0	0.0	   0.0   0.0    0.032   0.009   -999   999  	0.95	1.05	 0.0;  
  	  19	  0	   1.0	0.0	   0.0   0.0    0.095   0.034   -999   999  	0.95	1.05	 0.0;  
  	  20	  0	   1.0	0.0	   0.0   0.0    0.022   0.007   -999   999  	0.95	1.05	 0.0;  
  	  21	  0	   1.0	0.0	   0.0   0.0    0.175   0.112   -999   999  	0.95	1.05	 0.0;  
  	  22	  0	   1.0	0.0	   0.0   0.0    0.0     0.0     -999   999  	0.95	1.10	 0.0;  
  	  23	  0	   1.0	0.0	   0.0   0.0    0.032   0.016   -999   999  	0.95	1.10	 0.0;  
  	  24	  0	   1.0	0.0	   0.0   0.0    0.087   0.067   -999   999  	0.95	1.05	 0.043;
  	  25	  0	   1.0	0.0	   0.0   0.0    0.0     0.0     -999   999  	0.95	1.05	 0.0;  
  	  26	  0	   1.0	0.0	   0.0   0.0    0.035   0.023   -999   999  	0.95	1.05	 0.0;  
  	  27	  0	   1.0	0.0	   0.0   0.0    0.0     0.0     -999   999  	0.95	1.10	 0.0;  
  	  28	  0	   1.0	0.0	   0.0   0.0    0.0     0.0     -999   999  	0.95	1.05	 0.0; 
  	  29	  0	   1.0	0.0	   0.0   0.0    0.024   0.009   -999   999  	0.95	1.05	 0.0;  
   	  30	  0	   1.0	0.0	   0.0   0.0    0.106   0.019   -999   999  	0.95	1.05	 0.0]; 

nomes = {
    	'Glen Lyn';	'Claytor'; 'Kumis';	'Hancock'; 'Fieldale'; 'Roanoke'; 'Blaine'; 'Reusens'; 'Roanoke'; 'Roanoke'; 'Roanoke';  
	'Hancock'; 'Hancock'; 'Bus 14';	'Bus 15'; 'Bus 16';	'Bus 17'; 'Bus 18';	'Bus 19'; 'Bus 20';	'Bus 21'; 'Bus 22';	'Bus 23';   
	'Bus 24'; 'Bus 25';	'Bus 26'; 'Cloverdle'; 'Cloverdle';	'Bus 29'; 'Bus 30'};   
		   
%%	Dados das Linhas
%%
%%	De 	Para 	r   	x   bshl    tap  tapmin tapmax

linhas  = [
      1	 2	0.0192	0.0575	0.0528  1.0  1.0     1.0;
	  1	 3	0.0452	0.1652	0.0408	1.0  1.0     1.0;  
	  2	 4	0.0570	0.1737	0.0368	1.0  1.0     1.0; 
	  3	 4	0.0132	0.0379	0.0084	1.0  1.0     1.0; 
	  2	 5	0.0472	0.1983	0.0418	1.0  1.0     1.0; 
	  2	 6	0.0581	0.1763	0.0374	1.0  1.0     1.0; 
	  4	 6	0.0119	0.0414	0.0090	1.0  1.0     1.0; 
	  5	 7	0.0460	0.1160	0.0204	1.0  1.0     1.0; 
	  6	 7	0.0267	0.0820	0.0170	1.0  1.0     1.0; 
	  6	 8	0.0120	0.0420	0.0090	1.0  1.0     1.0; 
	  6	 9	0.0   	0.2080	0.0     0.978  1.0   1.0;
	  6	10	0.0   	0.5560	0.0     0.969  1.0   1.0;
	  9	11	0.0   	0.2080	0.0   	1.0  1.0     1.0; 
	  9	10	0.0   	0.1100	0.0   	1.0  1.0     1.0; 
	  4	12	0.0   	0.2560	0.0     0.932  1.0   1.0;
	 12	13	0.0   	0.1400	0.0   	1.0  1.0     1.0; 
	 12	14	0.1231	0.2559	0.0   	1.0  1.0     1.0; 
	 12	15	0.0662	0.1304	0.0   	1.0  1.0     1.0; 
	 12	16	0.0945	0.1987	0.0   	1.0  1.0     1.0;
	 14	15	0.2210	0.1997	0.0   	1.0  1.0     1.0;
	 16	17	0.0524	0.1923	0.0   	1.0  1.0     1.0;
	 15	18	0.1073	0.2185	0.0   	1.0  1.0     1.0;
	 18	19	0.0639	0.1292	0.0   	1.0  1.0     1.0;
	 19	20	0.0340	0.0680	0.0   	1.0  1.0     1.0;
	 10	20	0.0936	0.2090	0.0   	1.0  1.0     1.0;
	 10	17	0.0324	0.0845	0.0   	1.0  1.0     1.0;
	 10	21	0.0348	0.0749	0.0   	1.0  1.0     1.0;
	 10	22	0.0727	0.1499	0.0   	1.0  1.0     1.0;
	 21	22	0.0116	0.0236	0.0   	1.0  1.0     1.0;
	 15	23	0.1000	0.2020	0.0   	1.0  1.0     1.0;
	 22	24	0.1150	0.1790	0.0   	1.0  1.0     1.0;
	 23	24	0.1320	0.2700	0.0   	1.0  1.0     1.0;
	 24	25	0.1885	0.3292	0.0   	1.0  1.0     1.0;
	 25	26	0.2544	0.3800	0.0   	1.0  1.0     1.0;
	 25	27	0.1093	0.2087	0.0   	1.0  1.0     1.0;
	 28	27	0.0   	0.3960	0.0     0.968  1.0   1.0;
	 27	29	0.2198	0.4153	0.0   	1.0  1.0     1.0; 
	 27	30	0.3202	0.6027	0.0   	1.0  1.0     1.0; 
	 29	30	0.2399	0.4533	0.0   	1.0  1.0     1.0; 
	  8	28	0.0636	0.2000	0.0428	1.0  1.0     1.0; 
	  6	28	0.0169	0.0599	0.0130	1.0  1.0     1.0];
						     
return;						     