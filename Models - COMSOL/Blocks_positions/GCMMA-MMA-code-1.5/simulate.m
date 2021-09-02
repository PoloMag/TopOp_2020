n_blocks = 2;

model.physics('sens').feature('cvar1').set('initialValue', 1);
%model.physics('sens').feature('cvar2').set('initialValue', 1);
%model.physics('sens').feature('cvar3').set('initialValue', 1);
model.physics('sens2').feature('cvar1').set('initialValue', 0);
%model.physics('sens2').feature('cvar2').set('initialValue', 0);
%model.physics('sens2').feature('cvar3').set('initialValue', 0);

string_var = [];
for i=1:n_blocks
	string_aux = {sprintf('phi%d',i);sprintf('x%d',i);sprintf('y%d',i)};
	string_var = [string_var ; string_aux];
end
model.component('comp1').physics('sens2').feature('gcvar1').set('variableList', string_var);
model.component('comp1').physics('sens2').feature('gcvar1').set('initList',  zeros(3*n_blocks,1));


model.sol('sol1').run();
index_p = find(model.sol('sol1').getU());
len_U = length(model.sol('sol1').getU());
len_p = length(index_p);

model.physics('sens2').feature('cvar1').set('initialValue', 'p');
%model.physics('sens2').feature('cvar2').set('initialValue', 'p_Br_aux');
%model.physics('sens2').feature('cvar3').set('initialValue', 'theta_Br_aux');

string_var = [];
for i=1:n_blocks
	string_aux = {sprintf('2*pi*phi%da',i);sprintf('(x%da*0.6)-0.3',i);sprintf('0.4*y%da',i)};
	string_var = [string_var ; string_aux];
end
model.component('comp1').physics('sens2').feature('gcvar1').set('initList',  string_var);


gctoyinit;


model.param.set('psimp',p_simp);
model.param.set('r_filter_ur',r_filter_ur);
%model.param.set('r_filter_Br',r_filter_Br);
model.param.set('beta',beta);

live_plot = 0;

constraint = [0.2 0.016272 0.043463];
beta_jump = 300;

gctoymain;

B = 0.0064289/(f0val)

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
