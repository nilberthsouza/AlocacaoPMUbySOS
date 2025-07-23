for i=1:50000
    for j=1:1001
        nun=rand(1);
        if nun >= 0.7
            Matriz(i,j)=1;
        else
            Matriz(i,j)=0;
        end
        nun=[];
    end
    i
end
%-----------------------------------
[iu uu]=size(Matriz);
Nova_linhas=Matriz;
%Nova_linhas=MatObserv1;
[iu uu]=size(Nova_linhas);
fid = fopen('Matr_esp.m','w');
%fid = fopen('Matriz_Esp.xlc','w');
for i=1:iu    
   for j=1:uu  
          fprintf(fid,'%14.0f',Nova_linhas(i,j));          
         %fprintf(fid,'%14.8f',Nova_linhas(i,j));      
   end
   fprintf(fid,'\n');
end 
fclose(fid);
%%%%%%%%%%%%%%%%  Fim de save en formato .m
break