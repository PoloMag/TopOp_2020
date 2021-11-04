

gctoyinit;
for i=1:n_vars_densidade
    cvar = 'cvar%d';
    cvar = sprintf(cvar,i);
    model.physics('sens').feature(cvar).set('initialValue', 1);
    model.physics('sens2').feature(cvar).set('initialValue', 0);
end

    
    
index_p = find(model.sol('sol1').getU());
len_U = length(model.sol('sol1').getU());
len_p = length(index_p);

for i=1:n_vars_densidade
    cvar = 'cvar%d';
    cvar = sprintf(cvar,i);
    paux = 'p_aux%d';
    paux = sprintf(paux,i);
    model.physics('sens2').feature(cvar).set('initialValue', paux);
end




%Caso queira utilizar diferentes raios de filtro para diferentes
%vari�veis/filtros, definir manualmente:
%model.param.set('r_filter_ur',r_filter_ur); 
%model.param.set('r_filter_Br',r_filter_Br);

model.param.set('psimp',p_simp);
model.param.set('beta',beta);

live_plot = 0; %Caso queira habilitar visualiza��o em tempor real do comsol apenas pelo Matlab, mudar para 1. Observar no script Gctoymain qual imagem ser� mostrada.

gctoymain;


for i=1:len_p
if xval(i) > 0.5
xval(i) = 1;
else
xval(i) = 0;
end
end
p_simp = p_simp+1;
model.param.set('psimp',p_simp);
gctoymain;


for r=1:1
   p_simp=p_simp*2;
   model.param.set('psimp',p_simp);
   

   %beta = 2*beta;
   
   gctoymain;
   B = 0.0064289/(f0val);
   kkttol = kkttol*0.75;
end
p_simp=p_simp*2;
model.param.set('psimp',p_simp);
beta = 2*beta;
model.param.set('beta',beta);
gctoymain;
