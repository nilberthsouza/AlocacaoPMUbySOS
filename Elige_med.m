function BarrasMedidoresCopy = Elige_med (NroEstruc,individuo,BarrasMedidoresCopy,MatObserv1);
[nL,nB]=size(MatObserv1);
MatObserv1Tem=MatObserv1;
MatObserv1=[];
MatObserv1=MatObserv1Tem(:,2:nB);
[nL,nB]=size(MatObserv1);
[acumuladornum]= geranumerosdiferentes(NroEstruc,length(BarrasMedidoresCopy));
BarrasMedidoresCopy(acumuladornum,2)=1;
acumuladornum=[];
%------------------------------------------------------------------
for i=1:length(BarrasMedidoresCopy)
    if BarrasMedidoresCopy(i,2) == 0
        bar=BarrasMedidoresCopy(i);
        num=find(MatObserv1(:,bar) == 1);
        MatObserv1(num,:)=[];
        num=[];
    end
end
%-------------------------------------------------------------------------
for e=1:NroEstruc
    
    [nL,nB]=size(MatObserv1);
    for i=1:nL
        MatObserv1(i,nB+1)=sum( MatObserv1(i,:)); 
    end
    MatObserv12ORD=[];
    MatObserv12ORD=sort(MatObserv1,nB+1);
    MatObserv1=[];
    MatObserv1=MatObserv12ORD(:,1:nB);
    %-----------------------------------------------    
    numm=ceil(((rand(1))*60/100)*nL);     %TROCAR A PORCENTAGEM DE BUSCA
    num=find(MatObserv1(numm,:) == 1);
    %-----------------------------------------------

    for i=1:length(num)
        colun=num(i);        
        repet=find(MatObserv1(:,colun) == 1);
        max_repet(i)=length(repet);        
    end    
    maxNum1=max(max_repet);
    poss7=find(max_repet(:) == maxNum1);    
    [num_ger]= geranumerosdiferentes(1,length(poss7));
    poss8=poss7(num_ger);    
    acumuladornum(e)=num(poss8);  % acumula as barras novas
    repet=[]; poss7=[]; poss8=[];
    repet=acumuladornum(e);
    repet=find(MatObserv1(:,repet) == 1);
    MatObserv1(repet,:)=[];
    max_repet=[];   
    %MatObserv1(:,colunas1-1:colunas1)=0;
    if length(MatObserv1) == 0
        hjk=9;
    end
end   
repett=find(BarrasMedidoresCopy(:,2) == 1);
if length(repett) ~= length(acumuladornum)
    fg=5;
end
poss=[];
for i=1:NroEstruc
    poss=repett(i);
    BarrasMedidoresCopy(poss,1)=acumuladornum(i);
end
aa=BarrasMedidoresCopy;
BarrasMedidoresCopy=[];
BarrasMedidoresCopy=aa(:,1);
return




