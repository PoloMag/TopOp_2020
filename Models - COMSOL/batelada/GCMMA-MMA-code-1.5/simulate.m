model.physics('sens').feature('cvar1').set('initialValue', 1);
%model.physics('sens').feature('cvar2').set('initialValue', 1);
%model.physics('sens').feature('cvar3').set('initialValue', 1);
model.physics('sens2').feature('cvar1').set('initialValue', 0);
%model.physics('sens2').feature('cvar2').set('initialValue', 0);
%model.physics('sens2').feature('cvar3').set('initialValue', 0);
model.sol('sol1').run();
index_p = find(model.sol('sol1').getU());
len_U = length(model.sol('sol1').getU());
len_p = length(index_p);
model.physics('sens2').feature('cvar1').set('initialValue', 'p');
%model.physics('sens2').feature('cvar2').set('initialValue', 'p_Br_aux');
%model.physics('sens2').feature('cvar3').set('initialValue', 'theta_Br_aux');

gctoyinit;

model.param.set('psimp',p_simp);
model.param.set('r_filter_ur',r_filter_ur);
%model.param.set('r_filter_Br',r_filter_Br);
model.param.set('beta',beta);

live_plot = 0;

constraint = [0.5 0.016272 0.043463];
beta_jump = 300;

gctoymain;

p_simp=4;
model.param.set('psimp',p_simp);
beta = 8;
model.param.set('beta',beta);
gctoymain;
