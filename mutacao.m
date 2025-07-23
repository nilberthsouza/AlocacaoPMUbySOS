function [FilhoSelecA] = mutacao(FilhoSelecA,FilhoSelecB,passo,NumBarras)
Genesmutados=0;
T1=1/(sqrt(2*2)); T2=1/(sqrt(2*sqrt(2)));
Aleat1=rand(1); Aleat2=rand(1); 
landaNovo=exp((T1*Aleat1)+(T1*Aleat2));  % varia entre 1  -- 3
%landaNovo=landaAnt*exp((T1*Aleat1)+(T1*Aleat2))
Genesmutados=passo*landaNovo;
%-----  sorteia Genesmutados a trocar (binario)
Aleat1=[]; nn=0;
nn=floor((Genesmutados)*(NumBarras-1));
Aleat1=rand(nn,1);
Aleat1=floor(Aleat1*NumBarras);
nn=length(Aleat1);
for (n=1:nn)
poss=Aleat1(n,1);
    if (poss == 0)
      poss=1;  
    end
    if ( FilhoSelecA(1,poss)==1)
    FilhoSelecA(1,poss)=0;    
    else
    FilhoSelecA(1,poss)=1;    
    end
end







