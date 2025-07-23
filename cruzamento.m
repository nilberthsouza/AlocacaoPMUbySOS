function [FilhoA,FilhoB] = cruzamento(FilhoA,FilhoB,NumBarras)
CopiaFilhoA=[];  CopiaFilhoB=[];
Aleat1=rand(1);
NroGenes=floor(Aleat1*NumBarras/10);   %--- numero de genes a cruzar
if  ( NroGenes == 0 )
NroGenes=1;    
end
Aleat1=rand(1);
GenInicio=floor(Aleat1*(NumBarras-NroGenes));
if  ( GenInicio == 0 )
GenInicio=1;    
end
GenFinal=GenInicio+NroGenes-1;
CopiaFilhoA=FilhoA;
CopiaFilhoB=FilhoB;
FilhoB(1,GenInicio:GenFinal)=CopiaFilhoA(1,GenInicio:GenFinal);
FilhoA(1,GenInicio:GenFinal)=CopiaFilhoB(1,GenInicio:GenFinal);
