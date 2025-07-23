function populacao = geraPopulacaoInicial(num_populacao, num_medidores, Vet_bar)
% GERA_POPULACAOINICIAL Gera uma matriz de soluções aleatórias para alocação de PMUs.
%
% Entradas:
%   num_populacao   - Número de indivíduos (linhas da população)
%   num_medidores   - Número de PMUs (colunas por indivíduo)
%   Vet_bar         - Vetor com as barras disponíveis para alocação (1 x N)
%
% Saída:
%   populacao       - Matriz (num_populacao x num_medidores) com barras alocadas

    populacao = zeros(num_populacao, num_medidores);

    for i = 1:num_populacao
        barras_disponiveis = Vet_bar;  % reinicia as barras a cada indivíduo

        % Embaralha as barras disponíveis
        barras_disponiveis = barras_disponiveis(randperm(length(barras_disponiveis)));

        % Seleciona as primeiras num_medidores barras
        if length(barras_disponiveis) >= num_medidores
            populacao(i, :) = barras_disponiveis(1:num_medidores);
        else
            error('Número de barras disponíveis é menor que o número de medidores.');
        end
    end
end
