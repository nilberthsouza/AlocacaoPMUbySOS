function org_fixed = fix_organim(org_new, org_orig, nBarras)
% fix_organim — Substitui em org_new toda barra que ultrapassar nBarras
%               pelo valor correspondente em org_orig.
%
% USO:
%   org_fixed = fix_organim(org_new, org_orig, nBarras)
%
% ENTRADAS:
%   org_new   — vetor candidato (por ex. org_i_new)
%   org_orig  — vetor original (por ex. org_i, de onde vêm “pares”)
%   nBarras   — número máximo de barras válidas
%
% SAÍDA:
%   org_fixed — vetor com valores > nBarras substituídos pelos
%               valores na mesma posição de org_orig.

    % inicializa com o candidato
    org_fixed = org_new;

    % encontra posições inválidas (> nBarras)
    invalid_idx = org_fixed > nBarras;

    % substitui cada inválido pelo "par" no organismo original
    org_fixed(invalid_idx) = org_orig(invalid_idx);

    % (não tratamos repetições aqui; use elimina_repetições depois)
end
