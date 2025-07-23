function Nro_Inic_medid = Gera_Nro_Med (MatObserv12);
med=0;  poss =5;
[linhas1,colunas1 ]=size(MatObserv12);
N_curtos=zeros(1,colunas1);
N_curtos(2)=10;
while max(N_curtos(:)) > 0
    [linhas1,colunas1 ]=size(MatObserv12);
    for i=2:colunas1
        N_curtos(i)=sum(MatObserv12(:,i));
    end
    
    poss=find ( N_curtos(:) == max(N_curtos(:)));
    poss1=poss(1);
    k=0;
    for i=1:linhas1
        k=k+1;
        if ( MatObserv12(k,poss1) ) == 1
            MatObserv12(k,:)= [];
            k=k-1;
        end
    end
    med=med+1;
end
Nro_Inic_medid=med;