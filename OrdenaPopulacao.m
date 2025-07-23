function [MatrizPopul,ResultadosIndividuos] = OrdenaPopulacao(MatrizPopul,ResultadosIndividuos,NumBarras,Populacao)
vetor=0;
vetor=MatrizPopul;
uu=NumBarras+1;
uu12=uu+4;
vetor(:,uu:uu12)=ResultadosIndividuos;
vetor1=SORTROWS(vetor,uu12);
MatrizPopul=[];  VetorNumeroMedid=[];  ResultadosIndividuos=[]; 
MatrizPopul=vetor1(1:Populacao,1:NumBarras);
ResultadosIndividuos=vetor1(1:Populacao,uu:uu12);
vetor=0;