Nova_linhas=0;
[iu uu]=size(MatObserv1);
Nova_linhas=MatObserv1(1:iu,2:uu); % coloca so os zeros e uns tira a primeira coluna
%Nova_linhas=MatObserv1;
[iu uu]=size(Nova_linhas);
%fid = fopen('linha_I.m','w');
fid = fopen('linha_I.xlc','w');
for i=1:iu    
   for j=1:uu  
          fprintf(fid,'%14.2f',Nova_linhas(i,j));          
         %fprintf(fid,'%14.8f',Nova_linhas(i,j));      
   end
   fprintf(fid,'\n');
end 
fclose(fid);
%%%%%%%%%%%%%%%%  Fim de save en formato .m
