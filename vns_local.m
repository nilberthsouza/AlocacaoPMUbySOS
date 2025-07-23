function sol_vns = vns_local(solucao, NumBarras, linhas1, MatObserv1)
    max_vizinhancas = 3;
    max_iter_vizinhanca = 10;

    sol_vns = solucao;
    individuo = zeros(NumBarras,1);
    individuo(sol_vns,1) = 1;
    fobj_atual = AvaliaFuncObj(NumBarras,individuo,MatObserv1);

    for vizinhanca = 1:max_vizinhancas
        for tentativa = 1:max_iter_vizinhanca
            nova_sol = sol_vns;
            if vizinhanca == 1  % Troca 1 barra
                idx = randi(length(sol_vns));
                nova_barra = randi(linhas1);
                while ismember(nova_barra, sol_vns)
                    nova_barra = randi(linhas1);
                end
                nova_sol(idx) = nova_barra;
            elseif vizinhanca == 2  % Troca 2 barras
                idxs = randperm(length(sol_vns), 2);
                for i = 1:2
                    nova_barra = randi(linhas1);
                    while ismember(nova_barra, nova_sol)
                        nova_barra = randi(linhas1);
                    end
                    nova_sol(idxs(i)) = nova_barra;
                end
            elseif vizinhanca == 3  % Embaralha
                nova_sol = sol_vns(randperm(length(sol_vns)));
            end

            nova_sol = sort(elimina_repeticoes(nova_sol, linhas1));
            individuo = zeros(NumBarras,1);
            individuo(nova_sol,1) = 1;
            nova_fobj = AvaliaFuncObj(NumBarras,individuo,MatObserv1);

            if nova_fobj < fobj_atual
                sol_vns = nova_sol;
                fobj_atual = nova_fobj;
                break;  % Volta pra vizinhança 1
            end
        end
    end
end
