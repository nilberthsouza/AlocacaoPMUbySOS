function Nro_Inic_medid = Gera_Nro_Med (MatObserv12);
med=0;
while length(MatObserv12) ~= 0
    [linhas1,colunas1 ]=size(MatObserv12);
    for i=1:linhas1
        MatObserv12(i,colunas1+1)=sum( MatObserv12(i,:)); 
    end
    MatObserv12ORD=SORTROWS(MatObserv12,colunas1+1);
    num=MatObserv12ORD(1,colunas1+1);
    while num == 0  % apaga as linhas zeradas
       MatObserv12ORD(1,:)=[];
       num=MatObserv12ORD(1,colunas1+1);
    end
        uns_um=find(MatObserv12ORD(1,1:colunas1) == 1);
        for i=1:num
            repet=[];
            colun=uns_um(i);
            repet=find(MatObserv12ORD(:,colun) == 1);
            n_repet(i)=length(repet);    
        end
        col_elimin=find( n_repet(:) == max(n_repet));
        col_elimin1=col_elimin(1,1);
        coluna=uns_um(col_elimin1);
        poss=[];
        poss=find(MatObserv12ORD(:,coluna) == 1);
        MatObserv12ORD(poss,:)=[];
        med=med+1;
        MatObserv12=[];
        MatObserv12=MatObserv12ORD;
        MatObserv12(:,colunas1+1)=[];
        MatObserv12ORD=[];
        n_repet=[];
    
    end
end
Nro_Inic_medid=med;
return

