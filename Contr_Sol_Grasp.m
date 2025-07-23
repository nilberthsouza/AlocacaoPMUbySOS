function [Vet_Med,NumMedid]= Contr_Sol_Grasp(MatObserv1,NumMedid,NumBarras,Vet_bar);
[nL,nB]=size(MatObserv1);
Vet_Med=[];
for i=1:NumMedid
    q=rand(1);    
    if q > 0.2
        %-------------  Solucçao Aleatoria
        num=ceil((rand(1))*length(Vet_bar));        
        if num == 0
            num=1;
        end
        Vet_Med(i)=Vet_bar(num);
        Vet_bar(num)=[];  % elimina a barra selecionada
    else
        %-------------  Solucçao gulosa 
        for j=1:length(Vet_Med)            
            bar=Vet_Med(j);
            num=find(MatObserv1(:,bar) == 1);
            MatObserv1(num,:)=[];
            num=[];         
        end
        %-------------------------------------------------------------------------
        [nL,nB]=size(MatObserv1);
        if nL > 0
            for j=1:nL
                MatObserv1(j,nB+1)=sum( MatObserv1(j,:)); 
            end
            MatObserv12ORD=[];
            MatObserv12ORD=sort(MatObserv1,nB+1);
            MatObserv1=[];
            MatObserv1=MatObserv12ORD(:,1:nB);
            %------------------------------------------------------------------------- num=[];
            numm=ceil(((rand(1))*30/100)*nL);    %  30 % DE CANDIDATOS
            if numm == 0
                numm=1;
            end
            num=find(MatObserv1(numm,:) == 1);
            %-----------------------------------------------
            max_repet=[];
            for j=1:length(num)
                colun=num(j);        
                repet=find(MatObserv1(:,colun) == 1);
                max_repet(j)=length(repet);        
            end    
            maxNum1=max(max_repet);
            poss7=find(max_repet(:) == maxNum1);    
            [num_ger]= geranumerosdiferentes(1,length(poss7));
            poss8=poss7(num_ger);    
            Vet_Med(i)=num(poss8);  % acumula as barras novas
            num=find(Vet_bar(:) == Vet_Med(i));
            Vet_bar(num)=[]; 
        else
            NumMedid=length(Vet_Med);
            return
        end
    end
end
NumMedid=length(Vet_Med);
if length(Vet_Med) < NumMedid
    Vet_Med(end+1:NumMedid) = -1; % ou 0, ou NaN, ou algum valor que represente “vazio”
end
return