function vetor_min = minimo_sem_repeticao(org1, org2, linhas1)
%MINIMO_SEM_REPETICAO Combina dois organismos tomando o menor valor por posição
% e elimina repetições, garantindo unicidade dos elementos no vetor resultante.
%
%   vetor_min = minimo_sem_repeticao(org1, org2, linhas1)
%
%   Entradas:
%       org1    - Vetor (linha ou coluna) com os valores do primeiro organismo.
%       org2    - Vetor com os valores do segundo organismo (mesmo tamanho de org1).
%       linhas1 - Número total de elementos possíveis (ex: número de linhas do banco de dados).
%
%   Saída:
%       vetor_min - Vetor resultante contendo os menores elementos entre org1 e org2,
%                   sem repetições. Elementos repetidos são substituídos pelos seus pares,
%                   se possível, ou por valores aleatórios únicos entre 1 e linhas1.
%
%   Observações:
%       - A função garante que o vetor final não contenha valores repetidos.
%       - Os valores gerados aleatoriamente sempre estarão no intervalo [1, linhas1].
%
%   Exemplo:
%       org1 = [5 8 12];
%       org2 = [3 8 10];
%       linhas1 = 15;
%       resultado = minimo_sem_repeticao(org1, org2, linhas1);
%
%       % resultado pode ser algo como: [3 10 12], sem valores duplicados.

    vetor_min = min(org1, org2);
    [~, idx_unicos] = unique(vetor_min, 'stable');
    idx_repetidos = setdiff(1:length(vetor_min), idx_unicos);

    for k = idx_repetidos
        valor_original = vetor_min(k);

        if org1(k) == org2(k) && org1(k) == valor_original
            % Gera número aleatório inteiro que não esteja no vetor
            novo_valor = randi([1, linhas1]);
            while ismember(novo_valor, vetor_min)
                novo_valor = randi([1, linhas1]);
            end
            vetor_min(k) = novo_valor;
        else
            % Tenta usar o valor do outro organismo
            if org1(k) == valor_original
                substituto = org2(k);
            else
                substituto = org1(k);
            end

            % Se o substituto ainda não estiver no vetor, usa ele
            if ~ismember(substituto, vetor_min)
                vetor_min(k) = substituto;
            else
                % Se também já estiver, gera número aleatório
                novo_valor = randi([1, linhas1]);
                while ismember(novo_valor, vetor_min)
                    novo_valor = randi([1, linhas1]);
                end
                vetor_min(k) = novo_valor;
            end
        end
    end
end