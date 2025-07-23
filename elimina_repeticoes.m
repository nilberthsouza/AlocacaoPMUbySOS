function organismo = elimina_repeticoes(organismo, linhas1)
%ELIMINA_REPETICOES Remove valores duplicados e inválidos de um organismo
%
%   organismo = elimina_repeticoes(organismo, linhas1)
%
%   Entradas:
%       organismo - Vetor (linha ou coluna) com os valores do organismo.
%       linhas1   - Valor inteiro representando o número máximo permitido (inclusive).
%
%   Saída:
%       organismo - Vetor ajustado, com todos os valores únicos e no intervalo [1, linhas1].
%
%   Observações:
%       - Substitui valores duplicados ou fora do intervalo por inteiros aleatórios únicos.
%       - Garante que o vetor final contenha apenas valores válidos e não repetidos.

    % Corrige valores fora do intervalo
    for i = 1:length(organismo)
        if organismo(i) < 1 || organismo(i) > linhas1
            novo_valor = randi([1, linhas1]);
            while ismember(novo_valor, organismo)
                novo_valor = randi([1, linhas1]);
            end
            organismo(i) = novo_valor;
        end
    end

    % Elimina repetições
    [~, idx_unicos] = unique(organismo, 'stable');
    idx_repetidos = setdiff(1:length(organismo), idx_unicos);

    for k = idx_repetidos
        novo_valor = randi([1, linhas1]);
        while ismember(novo_valor, organismo)
            novo_valor = randi([1, linhas1]);
        end
        organismo(k) = novo_valor;
    end
end
