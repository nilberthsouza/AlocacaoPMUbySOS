function MatObserv1 = Reduz_Matriz (MatObserv12);
%---------------------- Caso matriz possua linhas zeradas-------------------------
[linhas1,colunas1]=size(MatObserv12);
for i=1:linhas1
    MatObserv12(i,colunas1+1)=sum( MatObserv12(i,:)); 
end
MatObserv12ORD=sort(MatObserv12,colunas1+1);
num=MatObserv12ORD(1,colunas1+1);
while num == 0  % apaga as linhas zeradas
    MatObserv12ORD(1,:)=[];
    num=MatObserv12ORD(1,colunas1+1);
end
%MatObserv1=MatObserv12ORD(:,1:colunas1);   
%[linhas1,colunas1]=size(MatObserv1); 
MatObserv12ORD(:,colunas1+2)=0;

% MatObserv12ORD=[];
% MatObserv12ORD=MatObserv12;
% MatObserv12ORD(:,colunas1+2)=0;


%----------------------------Caso matriz possua linhas iguais ------------------------
[linhas1,pp]=size(MatObserv12ORD);
for j=1:(linhas1-1)
    if MatObserv12ORD(j,colunas1+2) == 0
        num1=MatObserv12ORD(j,colunas1+1);
        poss1=find(MatObserv12ORD(j,1:colunas1) == 1);
        poss=find(MatObserv12ORD(j:linhas1,colunas1+1) == num1);
        for i=2:(length(poss))
            poss8=poss(i)+j-1;
            poss2=find(MatObserv12ORD(poss8,1:colunas1) == 1);
            if poss1 == poss2
                MatObserv12ORD(poss8,colunas1+2)=1;
            end
            poss2=[];
        end  
        poss1=[];
        poss=[];
    end
end
poss=[];
poss=find(MatObserv12ORD(:,colunas1+2) == 1);
MatObserv12ORD(poss,:)=[];

%------------------------------------------------------------------------------------------------------
MatObserv1=[];
MatObserv1=MatObserv12ORD(:,1:colunas1);   
[linhas1,colunas1]=size(MatObserv1); 
MatObserv12ORD=[];
MatObserv12ORD=MatObserv1;
%------------------------------Caso a matris possui colunas iguais  e colunas zeradas -----------------------------------------------------
for j=1:colunas1    
    MatObserv12ORD(linhas1+1,j)=sum(MatObserv12ORD(:,j));
end
poss76=find(MatObserv12ORD(linhas1+1,:) == 0);
poss76(1)=[];
MatObserv12ORD(:,poss76) =[];
[yu,colunas1]=size(MatObserv12ORD);
poss76=[];
%--------------------------------------------------------------
k=0; apag_bar=[];
for j=2:colunas1    
    num1=MatObserv12ORD(linhas1+1,j);
    poss=find(MatObserv12ORD(linhas1+1,j:colunas1) == num1);
    poss1=find(MatObserv12ORD(1:linhas1,j) == 1);
    for i=2:(length(poss))
        poss8=poss(i)+j-1;
        poss2=find(MatObserv12ORD(:,poss8) == 1);
        if poss1 == poss2
            k=k+1;
            apag_bar(k)=poss8;
        end
        poss2=[];
    end  
    poss1=[];
    poss=[];    
end
MatObserv12ORD(:,apag_bar)=[];
MatObserv1=[];
MatObserv1=MatObserv12ORD(1:linhas1,:);
MatObserv12ORD=[];
%----------------------------Caso matriz possua linhas que contem outras linhas ------------------------
% MatObserv12ORD=MatObserv1;
% [linhas1,colunas1]=size(MatObserv12ORD);
% for i=1:linhas1
%     %MatObserv12(i,colunas1+1)=sum( MatObserv12(i,:));
%     MatObserv12ORD(i,colunas1+1)=0;
% end
% for i=1:(linhas1-1) 
%     %num1=MatObserv12ORD(i,colunas1+1);
%     poss1=[];  
%     poss1=find(MatObserv12ORD(i,1:colunas1) == 1);
%     for k=i+1:linhas1
%         poss2=[]; zeros2=[]; zeros1=[];
%         poss2=find(MatObserv12ORD(k,1:colunas1) == 1); 
%         if length(poss1) >= length(poss2)
%             for j=1:length(poss2)
%                 if length(find(poss1(:) == poss2(j))) == 1
%                     poss2(j)=0;
%                 end
%             end
%             zeros2=find(poss2(:)> 0);
%             if  length(zeros2) == 0
%                 MatObserv12ORD(i,1:colunas1+1)=1;
%             end
%         else
%             for j=1:length(poss1)
%                 if length(find(poss2(:) == poss1(j))) == 1
%                     poss1(j)=0;
%                 end
%             end
%             zeros1=find(poss1(:)> 0);
%             if  length(zeros1) == 0
%                 MatObserv12ORD(k,1:colunas1+1)=1;
%             end
%         end 
%     end
% end
% poss=[];
% poss=find(MatObserv12ORD(:,colunas1+1) == 1);
% MatObserv12ORD(poss,:)=[];
% MatObserv1=[];
% MatObserv1=MatObserv12ORD(:,1:colunas1);
return
%------------------------------------------------------------------------------------------------------
