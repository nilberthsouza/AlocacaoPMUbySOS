function [passo,naomelhora]=mudapasso(passo,incumbemteantiga,incumbemte,naomelhora)
      if (incumbemteantiga < incumbemte)  % esta melhorando
        passo=0.1; 
      else
        naomelhora=naomelhora+1;
            if (naomelhora ==50)
            passo= passo+0.05;
            naomelhora=0;
            end
      end
        if (passo > 0.9)
         passo= 0.1;  
        end