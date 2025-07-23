clear;
clc;
caso = 'casoieee69';
[rede, barras, nomes, linhas] = feval(caso);

dadosArestas = [(1:size(linhas, 1))', linhas(:, 1:2)];  % Adiciona o número da aresta como primeira coluna

numArestas = size(dadosArestas, 1);
pesos = ones(numArestas, 1);  % todas as arestas com peso 1

% Criar nós como strings
nosIniciais = arrayfun(@(x) num2str(x), dadosArestas(:,2), 'UniformOutput', false);
nosFinais   = arrayfun(@(x) num2str(x), dadosArestas(:,3), 'UniformOutput', false);
todosNos    = unique([dadosArestas(:,2); dadosArestas(:,3)]);
rotulosNos  = arrayfun(@num2str, todosNos, 'UniformOutput', false);

% Criar grafo (não direcionado por padrão)
tipoGrafo = 'n';
if tipoGrafo == 's'
    G = digraph(nosIniciais, nosFinais, pesos, rotulosNos);
else
    G = graph(nosIniciais, nosFinais, pesos, rotulosNos);
end

% Mostrar o grafo
figure;
plot(G, 'Layout', 'force', 'EdgeLabel', G.Edges.Weight);
title('Grafo Malhado');

% Criar matriz quadrada de distâncias entre todos os nós
numNos = numel(todosNos);
distancias = inf(numNos);  % inicializa com infinito
for i = 1:numNos
    for j = 1:numNos
        if i == j
            distancias(i,j) = 0;
        else
            [~, d] = shortestpath(G, num2str(todosNos(i)), num2str(todosNos(j)));
            distancias(i,j) = d;
        end
    end
end



%%

% Função para gerar e exportar as matrizes de barras e distâncias ordenadas
% a partir de uma matriz quadrada de distâncias (distancias).
% Matriz de distâncias deve estar carregada no workspace com nome "distancias" (118x118).
% Verifica se a variável existe e é quadrada
if ~exist('distancias','var')
    error('Variável ''distancias'' não encontrada no workspace.');
end

[nRows, nCols] = size(distancias);
if nRows ~= nCols
    error('A matriz ''distancias'' precisa ser quadrada.');
end

n = nRows;  % número de barras 

% Pré-alocação das matrizes de saída
Matriz_dist1_300_barras = zeros(n);
Matriz_dist2_300_barras = zeros(n);

for i = 1:n
    %Ordena as distâncias da coluna i com ordem crescente
    [sortedDists, idxBarras] = sort(distancias(:, i));

    %Armazena no primeiro arquivo os índices das barras ordenadas
    Matriz_dist1_300_barras(:, i) = idxBarras;

    % Armazena no segundo arquivo as distâncias ordenadas
    Matriz_dist2_300_barras(:, i) = sortedDists;
end

save('Matriz_dist1_69_barras.m', 'Matriz_dist1_300_barras', '-ascii');
save('Matriz_dist2_69_barras.m', 'Matriz_dist2_300_barras', '-ascii');

fprintf('Arquivos gerados com sucesso.\n');

