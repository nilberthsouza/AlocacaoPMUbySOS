%Programa principal
clear;
clc;

tic; % Inicia o cronômetro
    

%format compact;
format long;
disp('            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('            %% ____________________________________________________________ %%');
disp('            %%|              ALOCACAO OTIMA DE MEDIDORES PMU               |%%');
disp('            %%|                UNIVERSIDADE FEDERAL DE OURO PRETO          |%%');
disp('            %%|            Departamento de Engenharia Elétrica             |%%');
disp('            %%|____________________________________________________________|%%');
disp('            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');



%------------ PARAMETROS ----------------------
%t0 = clock; tol=0.0001;   fc=1;  iter=30;  resp=2; % PU = 1  se nao  PU = 2
%Barra_falta=143;   %143



individuo=0;  VetorNumeroMedid=0;
BarrasMedidores=[];  BestIndividuo=[];
%------------ LENDO ARQUIVOS ----------------------
%MatObserv1=XLSREAD('Rede_6barrasTese.xls');  % inicial=5.  rsta 2 da teses reis
%MatObserv1=readtable('casoColombian.xlsx');  % casoPeruvian
%MatObserv1=load('casoieee300P.m');  % inicial=7.  rsta 2 da teses reis

disp("Escolha qual caso deseja");
disp("1- IEEE 14 Barras");
disp("2- IEEE 30 Barras");
disp("3- IEEE 33 Barras");
disp("4- IEEE 57 Barras");
disp("5- IEEE 69 Barras");
disp("6- IEEE 118 Barras");
disp("7- IEEE 300 Barras");
disp("8- Caso Peruvian");
disp("9- Caso Colombian");
EscolhaMenu = input("Escolha: ");



switch(EscolhaMenu)
    case 1
        MatObserv1 = load('casoieee14P.m');
    case 2
        MatObserv1=load('casoieee30P.m');
    case 3
        MatObserv1 = load('casoieee33P.m');
    case 4
        MatObserv1 = load('casoieee57P.m');
    case 5
        MatObserv1 = load('casoieee69P.m');
    case 6
        MatObserv1 = load('casoieee118P.m');
    case 7
        MatObserv1 = load('casoieee300P.m');
    case 8
        MatObserv1 = load('casoPeruvianP.m');
    case 9
        MatObserv1 = load('casoColombianp.m');


end




%MatObserv1=XLSREAD('MatrizObservabilidade30barInst1.xls');  % inicial=22.  rsta 17 instancia do paulo
%MatObserv1=XLSREAD('MatrizObservabilidade33bar.xls');  % inicial=20.  rsta 17 subtransmissao-distribuiç~ao
%MatObserv1=XLSREAD('Rede_720_30_IEEE.xls');  % inicial=4med. e 3med.  rsta 3 med
%MatObserv1=XLSREAD('Rede_1360_57_IEEE.xls');  % inicial=7med. e 6med.  rsta 5 med
%MatObserv1=load('Matr_esp.m');  % inicial=19med. e 18med.  rsta 19 med  20000 linhas  x 500 barras


%% Variaveis controle geração de tabelas
 numero_minimo_pmu = inf; % precisa ser infinito 
 criterio_de_parada = 0;
 contador_teste = 0;
 Numero_tentativas_medidor = 100;  % máximo de tentativas sem sucesso
 tentativas_sem_sucesso = 0;       % contador de tentativas consecutivas sem solução

 % Tempo em que a última solução foi encontrada (em segundos)
 time_last_solution = 0;
 % Variáveis para Single PMU Outage
 outage_flag = false;
 medidores_single_outage = NaN;

copia = [];


%------  converte matriz observabilidade em binario
[linhas1,colunas1 ]=size(MatObserv1);

if linhas1 == 14
    load('Matriz_dist1_14_barras.m');  
    load('Matriz_dist2_14_barras.m');
    Matriz_dist1 = Matriz_dist1_14_barras;
    Matriz_dist2 = Matriz_dist2_14_barras;

    
    Nro_Med = 4;

    escala = linhas1 / 10;
    num_anticorpos = max(round(5 * escala), 20);      % mínimo de 20
    num_ciclos = max(round(30 * escala), 50);         % mínimo de 50
    MelhorarParasita = max(round(2.5 * escala * num_anticorpos), 20);  % mínimo de 20

end

if linhas1 == 30
    load('Matriz_dist1_30_barras.m');  
    load('Matriz_dist2_30_barras.m');
    Matriz_dist1 = Matriz_dist1_30_barras;
    Matriz_dist2 = Matriz_dist2_30_barras;

    Nro_Med=10;
    escala = linhas1 / 10;
    num_anticorpos = max(round(5 * escala), 20);      % mínimo de 20
    num_ciclos = max(round(30 * escala), 50);         % mínimo de 50
    MelhorarParasita = max(round(2.5 * escala * num_anticorpos), 20);  % mínimo de 20


end

if linhas1 == 33
    load('Matriz_dist1_33_barras.m');  
    load('Matriz_dist2_33_barras.m');
    Matriz_dist1 = Matriz_dist1_33_barras;
    Matriz_dist2 = Matriz_dist2_33_barras;
    Nro_Med = 11;

    escala = linhas1 / 10;
    num_anticorpos = max(round(5 * escala), 20);      % mínimo de 20
    num_ciclos = max(round(30 * escala), 50);         % mínimo de 50
    MelhorarParasita = max(round(2.5 * escala * num_anticorpos), 20);  % mínimo de 20

end

if linhas1 == 57
    load('Matriz_dist1_57_barras.m');  
    load('Matriz_dist2_57_barras.m');
    Matriz_dist1 = Matriz_dist1_57_barras;
    Matriz_dist2 = Matriz_dist2_57_barras;
    num_ciclos = 300;  % Número de iterações (ciclos do algoritmo)
    num_anticorpos = 60;  % candidatos na população
    Nro_Med=17; %caso 57 barras ;
    MelhorarParasita = 10*num_anticorpos;

end

if linhas1 == 70
    load('Matriz_dist1_69_barras.m');  
    load('Matriz_dist2_69_barras.m');
    Matriz_dist1 = Matriz_dist1_69_barras;
    Matriz_dist2 = Matriz_dist2_69_barras;
    escala = linhas1 / 10;
    num_anticorpos = max(round(5 * escala), 20);      % mínimo de 20
    num_ciclos = max(round(30 * escala), 50);         % mínimo de 50
    MelhorarParasita = max(round(2.5 * escala * num_anticorpos), 20);  % mínimo de 20
    Nro_Med=24;           %caso 57 barras ;
    num_anticorpos = 200;
    num_ciclos = 2000;
end
if linhas1 == 118
    load('Matriz_dist1_118_barras.m');  
    load('Matriz_dist2_118_barras.m');
    Matriz_dist1 = Matriz_dist1_118_barras;
    Matriz_dist2 = Matriz_dist2_118_barras;

    Nro_Med = 32;
    escala = linhas1 / 10;
    num_anticorpos = max(round(5 * escala), 20);      % mínimo de 20
    num_ciclos = max(round(30 * escala), 50);         % mínimo de 50
    MelhorarParasita = max(round(2.5 * escala * num_anticorpos), 20);  % mínimo de 20
end

if linhas1 == 300
    load('Matriz_dist1_300_barras.m');  
    load('Matriz_dist2_300_barras.m');
    Matriz_dist1 = Matriz_dist1_300_barras;
    Matriz_dist2 = Matriz_dist2_300_barras;
    
    Nro_Med = 87;
    escala = linhas1 / 10;
    num_anticorpos = max(round(5 * escala), 20);      % mínimo de 20
    num_ciclos = max(round(30 * escala), 50);         % mínimo de 50
    MelhorarParasita = max(round(2.5 * escala * num_anticorpos), 20);  % mínimo de 20

end

if linhas1 == 131
    load('Matriz_dist1_Peruvian.m');  
    load('Matriz_dist2_Peruvian.m');
    Matriz_dist1 = Matriz_dist1_Peruvian;
    Matriz_dist2 = Matriz_dist2_Peruvian;
    Nro_Med = 34;

    escala = linhas1 / 10;
    num_anticorpos = max(round(5 * escala), 20);      % mínimo de 20
    num_ciclos = max(round(30 * escala), 50);         % mínimo de 50
    MelhorarParasita = max(round(2.5 * escala * num_anticorpos), 20);  % mínimo de 20
end




if linhas1 == 93
    load('Matriz_dist1_Colombian.m');  
    load('Matriz_dist2_Colombian.m');
    Matriz_dist1 = Matriz_dist1_Colombian;
    Matriz_dist2 = Matriz_dist2_Colombian;

    Nro_Med = 21;
    escala = linhas1 / 10;
    num_anticorpos = max(round(5 * escala), 20);      % mínimo de 20
    num_ciclos = max(round(30 * escala), 50);         % mínimo de 50
    MelhorarParasita = max(round(2.5 * escala * num_anticorpos), 20);  % mínimo de 20
end


%disp("Você deseja entrar com o numero de medidores ou que o algoritmo")

%NumBarras=colunas1-1; 
mm=0;  eee=0;
for i=1:linhas1      % dimensao de matriz linhas
    mm=mm+1; 
    acumul=0;
    for j=2:colunas1 % a partir da coluna 2    
        if  (MatObserv1(i,j) == 0) 
            MatObserv12(mm,j)=0;                       
        else
            MatObserv12(mm,j)=1;
        end
    end            
end 
%----------------------------------------------------------------------------------
t0 = clock;
MatObserv1=[];
%MatObserv12(:,1)=[];
MatObserv1=MatObserv12;

% xxx = MatObserv1(170,:) - MatObserv1(171,:);
% poss = find (xxx(:) == 0);
% length(poss)

[MatObserv1] = Reduz_Matriz (MatObserv12); %Reduz linhas ou colunas repetidas ou uma dentro de outra
[linhas1,colunas1]=size(MatObserv1);
NumBarras=colunas1-1;

%testaresultado;
%--------------------------------- Algoritmo guloso ------------------------------------------------
%gravamatriz;
%testaresultado;
Nro_Inic_medid = Gera_Nro_Med (MatObserv1); % 
%Nro_Inic_medid = Gera_Nro_Med2 (MatObserv1); % 
Nro_Med_guloso=Nro_Inic_medid;
%------------------------------------------------------------------------------------------------------
stopp=1000;
  %Nro_Med=Nro_Inic_medid;
 %Nro_Med=4; %caso 14 barras ;
 % Nro_Med=13; %caso 33 barras ;
 %Nro_Med=18; %caso 57 barras ;
% Nro_Med=16;

patch = zeros(500,21);
prosseguir=1;
for i=1:NumBarras
    Vet_bar(i)=i;
    individuo(i,1)=0; 
end
k=0; acum=0;
while (prosseguir == 1 )  
    % SOS
    NumGerado=Nro_Med;  % Não alterar
    
    %% Parâmetros do ciclo SOS

    
    clear populacao;
    % if numero_minimo_pmu ~= 10000000
    %     clear copia;
    %     copia = [];
    % 
    % end

    %% Criar população, adcionar dentro de um for n solucoes
    populacao = zeros(num_anticorpos,NumGerado);
    for i = 1:num_anticorpos
        %[populacao(i, :),NumMedid]= Contr_Sol_Grasp(MatObserv1(:,2:colunas1),NumGerado,NumBarras,Vet_bar); % atenção
        populacao(i, :) = geraSolucoes(Nro_Med, Vet_bar);
        % Avalia a função objetivo 
        
        individuo = zeros(NumBarras, 1);
        individuo(:,1)=0; 
        individuo(populacao(i,:),1)=1; 
        fobj_array(i) = AvaliaFuncObj(NumBarras,individuo,MatObserv1); % talvez precise transpor
    end
    %% teste para carregar uma solução entre ciclos
    if contador_teste >=1
       sz = size(populacao);
        num_colunas = sz(2);
        tam_copia = length(copia);
        
        % Ajusta o tamanho de copia
        if tam_copia < num_colunas
            % Se copia for menor, mantém os valores originais nas posições excedentes
            populacao(1,:) = [copia, populacao(1, tam_copia+1 : end)];
        elseif tam_copia > num_colunas
            % Se copia for maior, descarta os últimos elementos
            populacao(1,:) = copia(1:num_colunas);
        else
            % Se for do mesmo tamanho, simplesmente substitui
            populacao(1,:) = copia;
        end
        
        % Atualiza a função objetivo
        fobj_array(1) = fobj_copia;


    end;


%% Início dos Ciclos do Algoritmo SOS
    for ciclo = 1:num_ciclos

        

        
        % Identifica o melhor candidato (solução) atual
        [fobj_best, idx_best] = min(fobj_array);
         melhor_solucao = populacao(idx_best, :);
        
        % Para cada organismo na população, realiza os três processos: Mutualismo, Comensalismo e Parasitismo
            % progresso = (ciclo / num_ciclos) * 100;
            %if mod(round(progresso), 5) == 0
            %disp(['Progresso: ', num2str(progresso), ' %.']);
            %end

            %% FASE DE MUTUALISMO

            for i = 1:length(num_anticorpos)
             %i = randi([1,num_anticorpos]);
    
            % Seleciona um parceiro (organismo j) diferente do i
            j = randi(num_anticorpos);
            while j == i
                j = randi(num_anticorpos);
            end
            
    
            % Cópias dos organismos i e j para atualização
            org_i = populacao(i, :);
            org_j = populacao(j, :);
    
            Distancias = calcula_distancias_organismos(org_i,org_j,Matriz_dist1,Matriz_dist2);
            Distancias = Distancias'; % Só transpoe
    
            % Vetor de efeito mútuo (média dos dois organismos)
            % Suponha que org_i, org_j e Distancias já estão definidos corretamente
            vetor_min = minimo_sem_repeticao(org_i, org_j,linhas1);
        
            % Passo 3: Soma com metade da distância arredondada
            meio_caminho = round(0.5 * Distancias);
            vetor_mutual = vetor_min + meio_caminho;
    
        vetor_mutual = elimina_repeticoes(vetor_mutual,linhas1);
            
    %% CLASSICO
            % Fatores bióticos aleatórios (1 ou 2)
            % BF1 = randsample([1, 2], 1);
            % BF2 = randsample([1, 2], 1);


            %% ADPTATIVO , 
            % Cálculo de BF1 e BF2 com base na função objetivo
            if fobj_best ~= 0
                BF1 = round(fobj_array(i) / fobj_best);
                BF2 = round(fobj_array(j) / fobj_best);
            else
                BF1 = 1;
                BF2 = 1;
            end
%% 
    
            % Xi + rand(0,1)*(melhor solulcao - BF1 * mutualvector)
    
            %BF*mutual
            factor_1= vetor_mutual*BF1;
            factor_1 = fix_organim(factor_1,vetor_mutual,linhas1);
            factor_1 = elimina_repeticoes(factor_1,linhas1);
            % Distancia melhorsolucao - fator
            a = calcula_distancias_organismos(melhor_solucao,factor_1,Matriz_dist1,Matriz_dist2);
            b = rand*a;
            c = round(b);
            org_i_new = org_i + c';
    
            org_i_new = fix_organim(org_i_new,org_i,linhas1);
    
    
            % Xj + rand(0,1)*(melhor solulcao - BF2 * mutualvector)
    
            %BF*mutual
            factor_2= vetor_mutual*BF2;
            factor_2 = fix_organim(factor_2,vetor_mutual,linhas1);
            factor_2 = elimina_repeticoes(factor_2,linhas1);
            % Distancia melhorsolucao - fator
            a = calcula_distancias_organismos(melhor_solucao,factor_1,Matriz_dist1,Matriz_dist2);
            b = rand*a;
            c = round(b);
            org_j_new = org_j + c';
    
            org_j_new = fix_organim(org_j_new,org_j,linhas1);
    
             % Avalia os novos candidatos (mutualismo
    
            clear individuo;
            individuo = zeros(NumBarras, 1); 
            individuo(org_i_new,1)=1; 
            fobj_i_new = AvaliaFuncObj(NumBarras,individuo,MatObserv1);
            
            clear individuo;
            individuo = zeros(NumBarras, 1);
            individuo(org_j_new,1)=1; 
            fobj_j_new = AvaliaFuncObj(NumBarras,individuo,MatObserv1);
            
            % Atualização condicional: só substitui se a nova solução for melhor
            if fobj_i_new < fobj_array(i)
                populacao(i, :) = org_i_new;
                fobj_array(i) = fobj_i_new;
            end
            if fobj_j_new < fobj_array(j)
                populacao(j, :) = org_j_new;
                fobj_array(j) = fobj_j_new;
            end
    
            
            %% FASE DE COMENSALISMO
            
            %i = randi([1,num_anticorpos]);
            j_comm = randi(num_anticorpos);
            while j_comm == i
                j_comm = randi(num_anticorpos);
            end
    
            % Organismos envolvidos
            org_i = populacao(i, :);
            org_j = populacao(j_comm, :);
    
            % Cálculo da diferença (melhor_solucao - org_j)
            diff = calcula_distancias_organismos(melhor_solucao, org_j, Matriz_dist1, Matriz_dist2);
            rand_vec = rand * diff;
            passo = round(rand_vec);
    
            % Novo organismo i
            org_i_new = org_i + passo';
            org_i_new = fix_organim(org_i_new, org_i, linhas1);
            org_i_new = elimina_repeticoes(org_i_new, linhas1);
    
            % Avaliação da nova solução
            clear individuo;
            individuo = zeros(NumBarras, 1);
            individuo(org_i_new,1) = 1;
            fobj_i_new = AvaliaFuncObj(NumBarras, individuo, MatObserv1);
    
            % Substitui se for melhor
            if fobj_i_new < fobj_array(i)
                populacao(i, :) = org_i_new;
                fobj_array(i) = fobj_i_new;
            end
    



%% FASE DE PARASITISMO
% Seleciona um organismo alvo diferente de i
j_parasita = randi(num_anticorpos);
while j_parasita == i
    j_parasita = randi(num_anticorpos);
end

% Criação do parasita inicial a partir de org_i (cópia modificada)
org_i = populacao(i, :);

% Primeira alteração: modifica 1 parâmetro
parasita = org_i;
indice_mutacao = randi(length(parasita));
nova_barra = randi(linhas1);
parasita(indice_mutacao) = nova_barra;

% Corrige o parasita
parasita = fix_organim(parasita, org_i, linhas1);
parasita = elimina_repeticoes(parasita, linhas1);

% Avalia o parasita inicial
individuo = zeros(NumBarras, 1);
individuo(parasita,1) = 1;
fobj_parasita = AvaliaFuncObj(NumBarras, individuo, MatObserv1);

% Inicia contador de critério de parada
criterio_sem_melhoria = 0;

while criterio_sem_melhoria < MelhorarParasita
    % Faz uma cópia do parasita atual
    novo_parasita = parasita;
    
    % Altera dois parâmetros aleatórios
    for f = 1:1
        indice_mutacao = randi(length(novo_parasita));
        nova_barra = randi(linhas1);
        novo_parasita(indice_mutacao) = nova_barra;
    end
    
    % Corrige o novo parasita
    novo_parasita = fix_organim(novo_parasita, org_i, linhas1);
    novo_parasita = elimina_repeticoes(novo_parasita, linhas1);

    % Avalia o novo parasita
    individuo = zeros(NumBarras, 1);
    individuo(novo_parasita,1) = 1;
    fobj_novo_parasita = AvaliaFuncObj(NumBarras, individuo, MatObserv1);

    % Verifica se é melhor que o parasita anterior
    if fobj_novo_parasita < fobj_parasita
        parasita = novo_parasita;
        fobj_parasita = fobj_novo_parasita;
        criterio_sem_melhoria = 0; % zera contador
    else
        criterio_sem_melhoria = criterio_sem_melhoria + 1;
    end
end

% Após o ciclo de parasitismo, verifica se o parasita final é melhor que o hospedeiro (j_parasita)
if fobj_parasita < fobj_array(j_parasita)
    populacao(j_parasita, :) = parasita;
    fobj_array(j_parasita) = fobj_parasita;
end

end

    end





    %% Exibição dos resultados
    % Ordena a população com base na função objetivo (valor menor é melhor)
    [sorted_fobj, sorted_indices] = sort(fobj_array);
    populacao_ordenada = populacao(sorted_indices, :);




     copia = populacao_ordenada(1, :);
     fobj_copia = sorted_fobj(1);

    


    %% retornar 1 vet med
    Vet_Med = populacao_ordenada(1, :);
    
    
  %% Preparação da Matriz de Observabilidade sem coluna excedente
    Observabilidade = MatObserv1;
    Observabilidade(:,1) = [];
    
    % Contadores e flags locais por ciclo
    printedSolutions = [];
    contador = 0;
    printedHeader = false;
    outage_this_cycle = false;
    
    % Varre todas as soluções com fobj == 0
    for iSol = 1:numel(sorted_fobj)
        if sorted_fobj(iSol) ~= 0
            continue;
        end
        
        individuo = zeros(NumBarras,1);
        individuo(populacao_ordenada(iSol,:),1) = 1;
        redundancia = Observabilidade * individuo;
        if any(redundancia <= 0)
            continue;
        end
        solSorted = sort(populacao_ordenada(iSol,:));
        
        if isempty(printedSolutions) || ~ismember(solSorted, printedSolutions, 'rows')
            % Registra o conjunto de medidores deste indivíduo
            printedSolutions = [printedSolutions; solSorted];
            
            % Verifica Single PMU Outage (todas as redundâncias >= 2)
            if ~outage_flag && all(redundancia >= 2)
                outage_flag = true;
                medidores_single_outage = Nro_Med;
            end
            
            % Imprime cabeçalho apenas uma vez quando há solução
            if ~printedHeader
                disp("--------------------------------------------------------------------------");
                disp("Soluções únicas com fobj == 0 e cobertura completa:");
                disp("--------------------------------------------------------------------------");
                printedHeader = true;
            end
            % Exibe solução e redundância
            fprintf("Solução #%d: [", contador+1);
            fprintf("%d,", populacao_ordenada(iSol,1:end-1));
            fprintf("%d]\n", populacao_ordenada(iSol,end));
            fprintf("Redundância: [");
            fprintf("%d,", redundancia(1:end-1));
            fprintf("%d]\n", redundancia(end));
            % Estatísticas de barras observadas
            medidores = unique(redundancia);
            barras = arrayfun(@(m) sum(redundancia==m), medidores);
            fprintf("-----------------------------------------------\n");
            fprintf("Barras observadas por n medidores:\n");
            fprintf("-----------------------------------------------\n");
            for k = 1:numel(medidores)
                fprintf(" -> %d barra(s) observada(s) por %d medidor(es)\n", barras(k), medidores(k));
            end
            fprintf("-----------------------------------------------\n");
            disp("--------------------------------------------------------------------------");
            
            contador = contador + 1;
        end
    end
    
       %% Atualização com base em resultados da varredura
    

    if contador >= 1
        % Exibe estatísticas e registra tempo deste ciclo
        disp(["Numero de Medidores antes da redução: ", num2str(Nro_Med)]);
        disp(["# de Soluções únicas encontradas: ", num2str(contador)]);
        
        % Reduz número de medidores e reseta tentativas sem sucesso
        Nro_Med = Nro_Med - 1;
        tentativas_sem_sucesso = 0;
        numero_minimo_pmu = min(numero_minimo_pmu, Nro_Med);
        
        % Informa redução e tempo gasto neste ciclo
        disp(['Reduzido para ', num2str(Nro_Med), ' medidores; tempo gasto neste ciclo: ']);
        tempo_decorrido = toc; % Para o cronômetro e obtém o tempo
fprintf('Tempo de execução: %f segundos\n', tempo_decorrido);
    else
        % Sem soluções: incrementa tentativas sem sucesso
        tentativas_sem_sucesso = tentativas_sem_sucesso + 1;
        if tentativas_sem_sucesso >= Numero_tentativas_medidor
            disp(['Sem soluções em ', num2str(Numero_tentativas_medidor), ' ciclos. Encerrando.']);
            break;
        end
        % Ainda assim, mostra tempo gasto no ciclo sem solução
        disp(['Nenhuma solução para ', num2str(Nro_Med), ' medidores; Melhor Fobj Nesse Ciclo: : ', num2str(sorted_fobj(1)) ' -.']);
    end
    
    % Inicia novo tempo de ciclo para próxima iteração
    %tempo_inicio_medidor = tic;

end

% Fim do loop: exibe resultado de Single PMU Outage 
if outage_flag
    disp(['Medidores necessários para Single PMU Outage: ', num2str(medidores_single_outage)]);
else
    disp('Nenhuma configuração suportou Single PMU Outage.');
end

tempo_decorrido = toc; % Para o cronômetro e obtém o tempo
fprintf('Tempo de execução: %f segundos\n', tempo_decorrido);