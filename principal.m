%Programa principal
clear;
clc;
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

%MatObserv1=load('casoieee33P.m');  
MatObserv1 = load('casoieee14P.m');
%MatObserv1 = load('casoieee57P.m'); 


%MatObserv1=XLSREAD('MatrizObservabilidade30barInst1.xls');  % inicial=22.  rsta 17 instancia do paulo
%MatObserv1=XLSREAD('MatrizObservabilidade33bar.xls');  % inicial=20.  rsta 17 subtransmissao-distribuiç~ao
%MatObserv1=XLSREAD('Rede_720_30_IEEE.xls');  % inicial=4med. e 3med.  rsta 3 med
%MatObserv1=XLSREAD('Rede_1360_57_IEEE.xls');  % inicial=7med. e 6med.  rsta 5 med
%MatObserv1=load('Matr_esp.m');  % inicial=19med. e 18med.  rsta 19 med  20000 linhas  x 500 barras








%------  converte matriz observabilidade em binario
[linhas1,colunas1 ]=size(MatObserv1);

if linhas1 == 33
    load('Matriz_dist1_33_barras.m');  
    load('Matriz_dist2_33_barras.m');
    Matriz_dist1 = Matriz_dist1_33_barras;
    Matriz_dist2 = Matriz_dist2_33_barras;
end
if linhas1 == 14
    load('Matriz_dist1_14_barras.m');  
    load('Matriz_dist2_14_barras.m');
    Matriz_dist1 = Matriz_dist1_14_barras;
    Matriz_dist2 = Matriz_dist2_14_barras;
end
if linhas1 == 57
    load('Matriz_dist1_57_barras.m');  
    load('Matriz_dist2_57_barras.m');
    Matriz_dist1 = Matriz_dist1_57_barras;
    Matriz_dist2 = Matriz_dist2_57_barras;
end


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
Nro_Med=Nro_Inic_medid;
% Nro_Med=40;

prosseguir='sim';
for i=1:NumBarras
    Vet_bar(i)=i;
    individuo(i,1)=0; 
end
k=0; acum=0;
while (prosseguir == 'sim' )  
    % SOS
    NumGerado=Nro_Med;  % Não alterar
    
    %% Parâmetros do ciclo SOS
    num_ciclos = 2000;  % Número de iterações (ciclos do algoritmo)
    num_anticorpos = 20;  % candidatos na população
    
    clear populacao;

    %% Criar população, adcionar dentro de um for n solucoes
    for i = 1:num_anticorpos
        [populacao(i, :),NumMedid]= Contr_Sol_Grasp(MatObserv1(:,2:colunas1),NumGerado,NumBarras,Vet_bar); % atenção
        
        % Avalia a função objetivo 
        individuo(:,1)=0; 
        individuo(populacao(i,:),1)=1; 
        fobj_array(i) = AvaliaFuncObj(NumBarras,individuo,MatObserv1); % talvez precise transpor
    end

%% Início dos Ciclos do Algoritmo SOS
    for ciclo = 1:num_ciclos
        % Identifica o melhor candidato (solução) atual
        [fobj_best, idx_best] = min(fobj_array);
        melhor_solucao = populacao(idx_best, :);
        
        % Para cada organismo na população, realiza os três processos: Mutualismo, Comensalismo e Parasitismo
            
            %% FASE DE MUTUALISMO
             i = randi([1,num_anticorpos]);
    
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
            
    
            % Fatores bióticos aleatórios (1 ou 2)
            BF1 = randsample([1, 2], 1);
            BF2 = randsample([1, 2], 1);
    
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
    
            individuo(:,1)=0; 
            individuo(org_i_new,1)=1; 
            fobj_i_new = AvaliaFuncObj(NumBarras,individuo,MatObserv1);
            
            individuo(:,1)=0; 
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
            
            i = randi([1,num_anticorpos]);
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
            individuo(:,1) = 0;
            individuo(org_i_new,1) = 1;
            fobj_i_new = AvaliaFuncObj(NumBarras, individuo, MatObserv1);
    
            % Substitui se for melhor
            if fobj_i_new < fobj_array(i)
                populacao(i, :) = org_i_new;
                fobj_array(i) = fobj_i_new;
            end
    
    
    
    
    
            %% FASE DE PARASITISMO
            i = randi([1,num_anticorpos]);

            % Seleciona um organismo alvo diferente do i
            j_parasita = randi(num_anticorpos);
            while j_parasita == i
                j_parasita = randi(num_anticorpos);
            end
    
            % Criação do parasita a partir de org_i (cópia modificada)
            org_i = populacao(i, :);
            parasita = org_i;
    
            % Altera aleatoriamente uma posição no parasita
            indice_mutacao = randi(length(parasita));
            nova_barra = randi(linhas1); % Gera uma barra válida aleatória
            parasita(indice_mutacao) = nova_barra;
    
            % Corrige caso ultrapasse os limites
            parasita = fix_organim(parasita, org_i, linhas1);
            parasita = elimina_repeticoes(parasita, linhas1);
    
            % Avalia o parasita
            individuo(:,1) = 0;
            individuo(parasita,1) = 1;
            fobj_parasita = AvaliaFuncObj(NumBarras, individuo, MatObserv1);
    
            % Se for melhor que o hospedeiro (org_j), ele o substitui
            if fobj_parasita < fobj_array(j_parasita)
                populacao(j_parasita, :) = parasita;
                fobj_array(j_parasita) = fobj_parasita;
            end
    
    
         
    end

    %% Exibição dos resultados
    % Ordena a população com base na função objetivo (valor menor é melhor)
    [sorted_fobj, sorted_indices] = sort(fobj_array);
    populacao_ordenada = populacao(sorted_indices, :);


    % resultados = [populacao_ordenada(1, :), sorted_fobj(1)];


    %% retornar 1 vet med
    Vet_Med = populacao_ordenada(1, :);


    %% 
    %----------- VNS utiliza uma busca local
    BaixarEstr='nao'; % baixar estrutura
    BestIndividuo=[];
    individuo(:,1)=0;
    individuo(Vet_Med,1)=1;   

    [BestIndividuo,BaixarEstr,VezesFO]= EstruturaVizi(Vet_Med',NumMedid,NumBarras,individuo,MatObserv1,BaixarEstr,stopp,BestIndividuo);
    
    if  BaixarEstr == 'sim'
        k=k+1;
        Nro_Med=NumMedid-1
        nr=length(BestIndividuo);
        Lista_melhores(k,1:nr)=BestIndividuo'; 
        Vetor_Iter_melhores(k,1)= NumMedid;
        if VezesFO == []
            Vetor_Iter_melhores(k,2)= 0; 
        else
            Vetor_Iter_melhores(k,2)= VezesFO; 
        end
    else
        acum=acum+1; % vezes que não encontra uma melhor soluçao na busca VNS
    end
    if acum == 30
        prosseguir == 'nao'
    end
    
    if Nro_Med == 20; 
        break; 
    end
    if Nro_Med == 9
        etime(clock,t0)
        break
    end
        
end
%----- testando a soluç~ao encontrada
etime(clock,t0)

%[n1,n2]= size(Lista_melhores);
Vet_Med = BestIndividuo'
individuo (:,1) = 0;
individuo(Vet_Med,1)=1; 
[avaliacaoFuncObj,VetorRedundancia] = AvaliaFuncObj2(NumBarras,individuo,MatObserv1); 
VetorRedundancia


%[avaliacaoFuncObj]= AvaliaFuncObj(NumBarras,individuo,MatObserv1); 


