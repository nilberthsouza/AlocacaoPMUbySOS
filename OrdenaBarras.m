function [barras,linhas] = OrdenaBarras(barras,linhas);

for i=1:length(barras(:,1))
    BroBar=barras(i,1);
    %------
    poss=[];
    poss = find (linhas(:,1:2) == BroBar);
    linhas (poss) = i;
    %-----
    barras(i,1) = i;
end

return