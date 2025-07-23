function [acumuladornum] = geranumerosdiferentes(NumGerado,NumTotal)
  for ii=1:NumGerado
    elementogerdo=(rand(1,1))*NumTotal;  
    elementogerdo=ceil(elementogerdo);     
    acumuladornum(ii,1)=elementogerdo; 
    repet=[1;2];
    if ii >1
      while ( length(repet) ~= 0 )
        if ii >1        
            ww=ii-1; 
            repet=find(acumuladornum(1:ww,1) == elementogerdo);
            if (  length(repet) ~= 0)
            elementogerdo=(rand(1,1))*NumTotal; 
            elementogerdo=ceil(elementogerdo);
            else 
            acumuladornum(ii,1)=elementogerdo;
            end
        end
     end
    end  
  end