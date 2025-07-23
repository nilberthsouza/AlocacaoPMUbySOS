function [BestIndividuo,BaixarEstr,VezesFO] = EstruturaVizi(BarrasMedidores,NumeroMedidores,NumBarras,individuo,MatObserv1,BaixarEstr,stopp,BestIndividuo)
%---------------------------- teste 
%individuo(:,1)=0;
%teste=[3    94    35    48    77    65    95    85    74    78    51    21   107    88   104    47    60    45    44    53    93    81    27    72    82   113    98    96    49   37  ];
%individuo(teste,1)=1;   
%---------------------------
[avaliacaoFuncObj]= AvaliaFuncObj(NumBarras,individuo,MatObserv1); 
if avaliacaoFuncObj == 0
    BestIndividuo=BarrasMedidores;
    BaixarEstr='sim'
    return
end
NroEstruc=0; ss=0;  avaliacaoFuncObjAnt=100;
EstrutPorc= (10*NumeroMedidores/100);
EstrutPorc= ceil(EstrutPorc);
BarrasMedidoresCopy=[];
VezesFO=0;
while ss <  NumeroMedidores  
    %ss=ss+EstrutPorc; 
    
    ss=ss+1    % insvestigar condições do ss

NroEstruc=NroEstruc+1;  %---->  numero de estrutura
m=0; 
while m < stopp   
    m=m+1;
    VezesFO = VezesFO+1;
 BarrasMedidoresCopy=[];  
 BarrasMedidoresCopy=BarrasMedidores;
 %_--------------  Elige a possecao dos medidores a trocar ----------
 NumGerado=NroEstruc;  NumTotal=NumeroMedidores;
 [acumuladornum]= geranumerosdiferentes(NumGerado,NumTotal);
 mudarUM=acumuladornum;
 acumuladornum=[];
 %---------------- Elige os novos medidores a trocar --  
 individuo(:,1)=0;
 BarrasMedidoresCopy = Elige_med (NroEstruc,individuo,BarrasMedidoresCopy,MatObserv1); 
 individuo(:,1)=0; 
 individuo(BarrasMedidoresCopy,1)=1; 
 [avaliacaoFuncObj]= AvaliaFuncObj(NumBarras,individuo,MatObserv1);
%  if (avaliacaoFuncObj == 1) 
%      avaliacaoFuncObj
%  end
 BaixarEstr='nao';
    if avaliacaoFuncObj == 0         
        ss=NumeroMedidores
        m=stopp;
        BestIndividuo=[];
        BestIndividuo=BarrasMedidoresCopy;
        BarrasMedidores=BestIndividuo;
        NroEstruc;
        BaixarEstr='sim';        
    else        
        if (avaliacaoFuncObjAnt > avaliacaoFuncObj)
         if avaliacaoFuncObj == 1
             dsffd=9;
         end
         BarrasMedidores=BarrasMedidoresCopy;   
         avaliacaoFuncObjAnt=avaliacaoFuncObj;
         ss=0;  NroEstruc=0;
         m=stopp;
        end
    end
end
end
if ( ss == 3  &  m == 1000)
  stopp =stopp*4;  
end
return








