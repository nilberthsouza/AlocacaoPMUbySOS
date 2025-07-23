function Distancias = calcula_distancias_organismos(org_i, org_j, Matriz_dist1, Matriz_dist2)
% CALCULA_DISTANCIAS_ORGANISMOS Calcula a distância entre pares de barras
%   Distancias = calcula_distancias_organismos(org_i, org_j, Matriz_dist1, Matriz_dist2)
%   retorna um vetor coluna com as distâncias entre cada par de barras
%   org_i(k) e org_j(k) usando a função calcularDistancia.
%
%   Entradas:
%     org_i       - vetor de barras do organismo i
%     org_j       - vetor de barras do organismo j
%     Matriz_dist1 - matriz de distâncias 1
%     Matriz_dist2 - matriz de distâncias 2
%
%   Saída:
%     Distancias  - vetor coluna com as distâncias entre os pares de barras

    numElementos = length(org_i);
    Distancias = zeros(numElementos, 1);

    for k = 1:numElementos
        Distancias(k) = calcularDistancia(org_i(k), org_j(k), Matriz_dist1, Matriz_dist2);
    end
end