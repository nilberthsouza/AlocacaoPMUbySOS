function [rede, barras, nomes, linhas, Geradores,Trafos] = caso
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
%% tipos de conexao trafos e geradores
%   y  = 1
%   yT = 2
%   Delta = 3

%%   Nome da Rede

rede = 'Rede de 33 barras IEEE';

%%	Dados das Barras
%%
%%	Num  Tipo      Vk    Fase        Pg        Qg      Pc       Qc     Qmin  Qmax  Vmin  Vmax  bshk
 
barras = [                                                                                            
     1    2 	  12.66   0.00 	 0.000     0.000     0.0     0.0    -99   99    -99   99   0.0;    
     2    0		  1.0   0.00 	 0.000     0.000   100.0    60.0    -99   99    -99   99   0.0;    
     3    0 	  1.0   0.00 	 0.000     0.000    90.0    40.0    -99   99    -99   99   0.0     
     4    0 	  1.0   0.00 	 0.000     0.000   120.0    80.0    -99   99    -99   99   0.0;    
     5    0 	  1.0   0.00 	 0.000     0.000    60.0    30.0    -99   99    -99   99   0.0;    
     6    0       1.0   0.00     0.000     0.000    60.0    20.0    -99   99    -99   99   0.0;    
     7    0       1.0   0.00     0.000     0.000   200.0   100.0    -99   99    -99   99   0.0;    
     8    0       1.0   0.00     0.000     0.000   200.0   100.0    -99   99    -99   99   0.0     
     9    0       1.0   0.00     0.000     0.000    60.0    20.0    -99   99    -99   99   0.0;    
    10    0       1.0   0.00     0.000     0.000    60.0    20.0    -99   99    -99   99   0.0;    
    11    0       1.0   0.00     0.000     0.000    45.0    30.0    -99   99    -99   99   0.0;    
    12    0       1.0   0.00     0.000     0.000    60.0    35.0    -99   99    -99   99   0.0;    
    13    0       1.0   0.00     0.000     0.000    60.0    35.0    -99   99    -99   99   0.0;     
    14    0       1.0   0.00     0.000     0.000   120.0    80.0    -99   99    -99   99   0.0;      
    15    0       1.0   0.00     0.000     0.000    60.0    10.0    -99   99    -99   99   0.0;    
    16    0       1.0   0.00     0.000     0.000    60.0    20.0    -99   99    -99   99   0.0;    
    17    0       1.0   0.00     0.000     0.000    60.0    20.0    -99   99    -99   99   0.0;    
    18    0       1.0   0.00     0.000     0.000    90.0    40.0    -99   99    -99   99   0.0     
    19    0       1.0   0.00     0.000     0.000    90.0    40.0    -99   99    -99   99   0.0;    
    20    0       1.0   0.00     0.000     0.000    90.0    40.0    -99   99    -99   99   0.0;    
    21    0       1.0   0.00     0.000     0.000    90.0    40.0    -99   99    -99   99   0.0;    
    22    0       1.0   0.00     0.000     0.000    90.0    40.0    -99   99    -99   99   0.0;    
    23    0       1.0   0.00     0.000     0.000    90.0    50.0    -99   99    -99   99   0.0     
    24    0       1.0   0.00     0.000     0.000   420.0   200.0    -99   99    -99   99   0.0;    
    25    0       1.0   0.00     0.000     0.000   420.0   200.0    -99   99    -99   99   0.0;    
    26    0       1.0   0.00     0.000     0.000    60.0    25.0    -99   99    -99   99   0.0;    
    27    0       1.0   0.00     0.000     0.000    60.0    25.0    -99   99    -99   99   0.0;    
    28    0       1.0   0.00     0.000     0.000    60.0    20.0    -99   99    -99   99   0.0     
    29    0       1.0   0.00     0.000     0.000   120.0    70.0    -99   99    -99   99   0.0;    
    30    0       1.0   0.00     0.000     0.000   200.0   600.0    -99   99    -99   99   0.0;    
    31    0       1.0   0.00     0.000     0.000   150.0    70.0    -99   99    -99   99   0.0;    
    32    0       1.0   0.00     0.000     0.000   210.0   100.0    -99   99    -99   99   0.0;   
    33    0       1.0   0.00     0.000     0.000    60.0    40.0    -99   99    -99   99   0.0];  
nomes = {
    'Barra 1'; 'Barra 2'; 'Barra 3'; 'Barra 4'; 'Barra 5'; 'Barra 6'; 'Barra 7'; 'Barra 8'; 'Barra 9'; 'Barra 10'; ...
    'Barra 11'; 'Barra 12'; 'Barra 13'; 'Barra 14'; 'Barra 15'; 'Barra 16'; 'Barra 17'; 'Barra 18'; 'Barra 19'; 'Barra 20'; ...
    'Barra 21'; 'Barra 22'; 'Barra 23'; 'Barra 24'; 'Barra 25'; 'Barra 26'; 'Barra 27'; 'Barra 28'; 'Barra 29'; 'Barra 30'; ...
    'Barra 31'; 'Barra 32'; 'Barra 33'};

%%	Dados das Linhas
%%
%%	De Para   r      x    bshl  tap  tapmin tapmax

linhas  = [
    1    2     0.0922  0.0470  0.00  1.0  1.0     1.0; 
    2    3     0.4930  0.2511  0.00  1.0  1.0     1.0; 
    3    4     0.3660  0.1864  0.00  1.0  1.0     1.0; 
    4    5     0.3811  0.1941  0.00  1.0  1.0     1.0; 
    5    6     0.8190  0.7070  0.00  1.0  1.0     1.0; 
    6    7     0.1872  0.6188  0.00  1.0  1.0     1.0; 
    7    8     0.7114  0.2351  0.00  1.0  1.0     1.0; 
    8    9     1.0300  0.7400  0.00  1.0  1.0     1.0; 
    9   10     1.0440  0.7400  0.00  1.0  1.0     1.0; 
   10   11     0.1966  0.0650  0.00  1.0  1.0     1.0; 
   11   12     0.3744  0.1238  0.00  1.0  1.0     1.0; 
   12   13     1.4680  1.1550  0.00  1.0  1.0     1.0; 
   13   14     0.5416  0.7129  0.00  1.0  1.0     1.0; 
   14   15     0.5910  0.5260  0.00  1.0  1.0     1.0; 
   15   16     0.7463  0.5454  0.00  1.0  1.0     1.0; 
   16   17     1.2890  1.7210  0.00  1.0  1.0     1.0; 
   17   18     0.7320  0.5740  0.00  1.0  1.0     1.0; 
    2   19     0.1640  0.1565  0.00  1.0  1.0     1.0; 
   19   20     1.5042  1.3554  0.00  1.0  1.0     1.0; 
   20   21     0.4095  0.4784  0.00  1.0  1.0     1.0; 
   21   22     0.7089  0.9373  0.00  1.0  1.0     1.0; 
    3   23     0.4512  0.3083  0.00  1.0  1.0     1.0; 
   23   24     0.8980  0.7091  0.00  1.0  1.0     1.0; 
   24   25     0.8960  0.7011  0.00  1.0  1.0     1.0; 
    6   26     0.2030  0.1034  0.00  1.0  1.0     1.0; 
   26   27     0.2842  0.1447  0.00  1.0  1.0     1.0; 
   27   28     1.0590  0.9337  0.00  1.0  1.0     1.0; 
   28   29     0.8042  0.7006  0.00  1.0  1.0     1.0; 
   29   30     0.5075  0.2585  0.00  1.0  1.0     1.0; 
   30   31     0.9744  0.9630  0.00  1.0  1.0     1.0; 
   31   32     0.3105  0.3619  0.00  1.0  1.0     1.0; 
   32   33     0.3410  0.5302  0.00  1.0  1.0     1.0];



%% Dados para curto-circuito  Geradores e transformadores


% Geradores
%%  Num   Tipo   Conexao   Rg(+)      Xg(+)        Rg(-)      Xg(-)           Rg(0)    Xg(0)       Xg(n) 
Geradores=  [
     1       2      2        0.0       0.1111        0.0        0.20            0.0    0.10         0.00];
     %14      1      2        0.01      0.1333        0.0        0.20            0.0    0.10         0.00 ];
        


%% Transformadores
%%  De   Para    Conexao-AT   Conexao-BT    Rg(+)      Xg(+)        Rg(-)      Xg(-)           Rg(0)    Xg(0) 
Trafos=  [ ];
   % 1     2          2             2        0.0        0.20        0.00        0.20            0.00     0.20];
return;