% function Distancia = calcularDistancia(BarraA, BarraB, matrizDist1, matrizDist2)
%     % Acessa a coluna correspondente ao valor de BarraA
%     coluna_desejada_De = matrizDist1(:, BarraA);
% 
%     % Procura a linha onde o valor na coluna é igual a BarraB
%     linha_encontrada_De = find(coluna_desejada_De == BarraB);
% 
%     % Procura a coluna correspondente ao valor de BarraA em matrizDist2
%     coluna_encontrada_De = matrizDist2(:, BarraA);
% 
%     % Acessa o valor na linha encontrada e na coluna correspondente
%     distancia_De = coluna_encontrada_De(linha_encontrada_De);
% 
%     disp(distancia_De);
%     % Retorna a distância
%     Distancia = distancia_De;
% end
function Distancia = calcularDistancia(BarraA, BarraB, matrizDist1, matrizDist2)
    % Se as barras forem iguais, a distância é zero
    if BarraA == BarraB
        Distancia = 0;
        return;
    end

    % Acessa a coluna correspondente ao valor de BarraA
    coluna_desejada_De = matrizDist1(:, BarraA);

    % Procura a linha onde o valor na coluna é igual a BarraB
    linha_encontrada_De = find(coluna_desejada_De == BarraB);

    % Verificação de erro
    if isempty(linha_encontrada_De)
        warning('BarraB (%d) não encontrada na coluna de BarraA (%d). Retornando Inf.', BarraB, BarraA);
        Distancia = Inf; % ou outro valor de penalidade
        return;
    elseif length(linha_encontrada_De) > 1
        warning('BarraB (%d) aparece mais de uma vez na coluna de BarraA (%d). Usando a primeira ocorrência.', BarraB, BarraA);
        linha_encontrada_De = linha_encontrada_De(1);
    end

    % Acessa o valor na linha encontrada
    coluna_encontrada_De = matrizDist2(:, BarraA);
    distancia_De = coluna_encontrada_De(linha_encontrada_De);

    Distancia = distancia_De;
end
