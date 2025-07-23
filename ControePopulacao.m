function [MatrizPopul,VetorNumeroMedid]=ControePopulacao(Populacao,NumBarras)
MatrizPopul = rand(Populacao,NumBarras);
acumulador=0;
for i=1:Populacao      % dimensao de matriz linhas
   for j=1:NumBarras     
      if  (  MatrizPopul(i,j) > 0.90)  
      MatrizPopul(i,j)=1;
      else
      MatrizPopul(i,j)=0;
      end
      acumulador=acumulador+MatrizPopul(i,j);
  end
      VetorNumeroMedid(i,1)=acumulador;
      acumulador=0;
end




