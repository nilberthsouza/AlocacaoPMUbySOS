function [avaliacaoFuncObj] = AvaliaFuncObj(NumBarras,individuo,MatObserv1)
MatrizObservab=0; vetorResultado=0; poss=[];
[linhas11,colunas11 ]=size(MatObserv1);
numbarras=colunas11-1;
MatrizObservab(1:linhas11,1:numbarras)=MatObserv1(:,2:colunas11);
%individuo(:,1)=0; individuo(2,1)=1; individuo(19,1)=1;  individuo(1,1)=1;
vetorResultado=MatrizObservab*(individuo);
poss = find(vetorResultado(:,1)== 0);
avaliacaoFuncObj(1,1)=length(poss);
%---------------------------
%rr=10;
%for nn=1:rr
% poss=[];   
%poss = find(vetorResultado(:,1)== nn);
%avaliacaoFuncObj(1,nn)=length(poss);
%if (length(poss) == 0)
%    nn=1000;
%end
%end
% matriz que conta a sencivilidade dos medidores
for i=1:20
    poss34=[];
    poss34=find(vetorResultado(:) == i);
    Matriz_Senc(i,1)=i;
    Matriz_Senc(i,2)=length(poss34);
end
%------ contar cada mediddor quantas condicoes enxerga
for i=1:50
    poss=[];
    poss = find(vetorResultado(:,1)== i);
    VetorTemp(i,1)=i;
    VetorTemp(i,2)=length(poss);
end
VetorRedundancia=zeros(3,2);
VetorRedundancia=VetorTemp(1:3,1:2);
poss = find(vetorResultado(:,1) > 2);
VetorRedundancia(3,2)= length(poss);

return