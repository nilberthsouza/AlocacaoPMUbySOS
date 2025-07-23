function solucao = geraSolucoes(num_medidores, Vet_bar)
% GERASOLUCOES Gera uma única solução aleatória (vetor linha) para alocação de PMUs.
%
% Entradas:
%   num_medidores - número de PMUs a serem alocadas
%   Vet_bar       - vetor com as barras disponíveis
%
% Saída:
%   solucao       - vetor linha com as barras alocadas (1 x num_medidores)

    if length(Vet_bar) < num_medidores
        error('Não há barras suficientes em Vet_bar para alocar todos os medidores.');
    end

    Vet_bar_embaralhado = Vet_bar(randperm(length(Vet_bar)));
    solucao = Vet_bar_embaralhado(1:num_medidores);
end
