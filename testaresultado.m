%testaresultado
individuo=zeros(NumBarras,1);
 %result= [ 2 6 14 16  28  29  32  33  45  52  68  103  126 140   141 ];  % resultado Elton 15 med.
 %result= [  63    78    68    76     32     10     57      7     77     25     74     66     79     58  ];
 %result= [   2 6 10 15 20 25 ]; 
 %result= [ 2 4 7 10 15  ];
 %result= [ 4     2    24  ];
 result= [ 23     3    10    12    14    22     7    20     9    16    32    15    21    17    18    25    24   ];
 %result= [32    16    15    14    20    22     9    17    10    18    25    24     7     3    23    12    21]; %17 medidores MatrizObservabilidade33bar
 %result=  [21    25    23    14    29     7    16    13    20    17    18    28    22     1    15    19     2]; %17 medidores MatrizObservabilidade30barInst1  paulo
 result=  [1	2	5	9	13	14	15	16	17	18	19	20	21	22	23	25	28	29 ];%18 medidores MatrizObservabilidade30barInst1  paulo
 
 for gt=1:(length(result))    
    df=result(gt);
    individuo(df,:)= 1;
end
%individuo(:,1)=1;
[avaliacaoFuncObj]= AvaliaFuncObj(NumBarras,individuo,MatObserv1)
