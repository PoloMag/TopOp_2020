%Para fazer as an�lises para uma vari�vel p de uma itera��o k do algoritmo
%de otimiza��o, define-se o estudo 1 como um estudo auxiliar que define a
%vari�vel p. O estudo 2 e 3 definem a vari�vel p1 como p (do estudo 1,
%por�m seu valor foi alterado externamente pelos algoritmos toy). O estudo
%2 n�o calcular gradientes e o 3 sim.


%Estudo 1: Estudo auxiliar, n�o realiza c�lculos e sim apenas defini��es. -
%Tomar cuidado ao realizar altera��es.
model.study.create('std1');
model.study('std1').create('stat', 'Stationary');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature.remove('fcDef');

model.study('std1').feature('stat').set('usesol', true);
model.sol('sol1').attach('std1');
model.sol('sol1').feature('st1').label('Compile Equations: Stationary');
model.sol('sol1').feature('v1').label('Dependent Variables 1.1');
model.sol('sol1').feature('s1').active(false);


%Estudo 2: Estudo sem c�lculo sensitivo.
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');



model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').attach('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature.remove('fcDef');


model.sol('sol2').attach('std2');
model.sol('sol2').feature('st1').label('Compile Equations: Stationary');
model.sol('sol2').feature('v1').label('Dependent Variables 1.1');
model.sol('sol2').feature('v1').set('initsol', 'sol1');
model.sol('sol2').feature('v1').set('solnum', 'auto');
model.sol('sol2').feature('v1').set('notsolmethod', 'sol');
model.sol('sol2').feature('v1').set('notsol', 'sol1');
model.sol('sol2').feature('v1').set('notsolnum', 'auto');
model.sol('sol2').feature('s1').label('Stationary Solver 1.1');
model.sol('sol2').feature('s1').feature('dDef').label('Direct 1');
model.sol('sol2').feature('s1').feature('dDef').set('thresh', 0.1);
model.sol('sol2').feature('s1').feature('aDef').label('Advanced 1');
model.sol('sol2').feature('s1').feature('fc1').label('Fully Coupled 1.1');
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 150);
%model.sol('sol2').runAll; 

%Estudo 3: Estudo com c�lculo sensitivo.
model.study.create('std3');
model.study('std3').create('sens', 'Sensitivity');
model.study('std3').create('stat', 'Stationary');


if n_vars_densidade>1
    model.study('std1').feature('stat').set('activate', {'mfnc' 'off' 'sens' 'on' 'sens2' 'off' 'hzeq' 'off' 'hzeq2' 'off'});
    model.study('std2').feature('stat').set('activate', {'mfnc' 'on' 'sens' 'off' 'sens2' 'on' 'hzeq' 'on' 'hzeq2' 'on'});
    model.study('std3').feature('stat').set('activate', {'mfnc' 'on' 'sens' 'off' 'sens2' 'on' 'hzeq' 'on' 'hzeq2' 'on'});
else 
    model.study('std1').feature('stat').set('activate', {'mfnc' 'off' 'sens' 'on' 'sens2' 'off' 'hzeq' 'off'});
    model.study('std2').feature('stat').set('activate', {'mfnc' 'on' 'sens' 'off' 'sens2' 'on' 'hzeq' 'on'});
    model.study('std3').feature('stat').set('activate', {'mfnc' 'on' 'sens' 'off' 'sens2' 'on' 'hzeq' 'on'});
end


model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').attach('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').create('sn1', 'Sensitivity');
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.study('std3').feature('sens').set('gradientStep', 'stat');

%As pr�ximas linhas habilitam/desabilitam as fun��es das quais se obt�m o
%gradiente. 
%Para cada fun��o da qual se retira os gradientes, habilitar com 'on' aqui. Na d�vida, analisar a ordem das fun��es no pr�prio COMSOL.
% Nas fun��es dentro do algoritmo de otimiza�ao (toy2) � realizada a troca
% destas fun��es para que se obtenha o gradiente de cada fun��o
% individualmente
cell_obj_func_size = 1+n_constraints;
cell_obj_func = cell(1,cell_obj_func_size);

for i=1:cell_obj_func_size-1
    cell_obj_func{i} = 'off';
end
cell_obj_func{cell_obj_func_size} = 'on'; %Por default, ficar� habilitado para a retirada de gradiente da fun��o objetivo
model.study('std3').feature('sens').set('objectiveActive', cell_obj_func); 

%habilita o gradiente apenas para as vari�veis que interessam. No caso,
%desabilitar as variaveis respectivas � f�sica auxiliar sens1
cell_control_vars_size = 2*((n_blocks+n_vars_global)>0) + 2*(n_vars_densidade);
cell_control_vars = cell(1,cell_control_vars_size);
if (n_blocks+n_vars_global)>0
    cell_control_vars{1} = 'on';
    cell_control_vars{2} = 'off';
    i_init = 3;
else
    i_init = 1;
end
for i=i_init:(n_vars_densidade+2*((n_blocks+n_vars_global)>0))
    cell_control_vars{i} = 'on';
    cell_control_vars{i+n_vars_densidade} = 'off';
    
end

model.study('std3').feature('sens').set('controlVariableActive', cell_control_vars); %Calcula os gradientes apenas em rela��o � vari�vel p do sens2

model.study('std3').feature('stat').set('useinitsol', true);
model.study('std3').feature('stat').set('initmethod', 'sol');
model.study('std3').feature('stat').set('initstudy', 'std2');
model.study('std3').feature('stat').set('solnum', 'auto');
model.study('std3').feature('stat').set('usesol', true);
model.study('std3').feature('stat').set('notsolmethod', 'sol');
model.study('std3').feature('stat').set('notstudy', 'std2');
model.study('std3').feature('stat').set('notsolnum', 'auto');

model.sol('sol3').attach('std3');
model.sol('sol3').feature('st1').label('Compile Equations: Stationary');
model.sol('sol3').feature('v1').label('Dependent Variables 1.1');
model.sol('sol3').feature('v1').set('initmethod', 'sol');
model.sol('sol3').feature('v1').set('initsol', 'sol2');
model.sol('sol3').feature('v1').set('solnum', 'auto');
model.sol('sol3').feature('v1').set('notsolmethod', 'sol');
model.sol('sol3').feature('v1').set('notsol', 'sol2'); %Para poupar tempo eventualmente, o estudo 3 toma como valores iniciais os resultados do estudo 2
model.sol('sol3').feature('v1').set('notsolnum', 'auto');
model.sol('sol3').feature('s1').label('Stationary Solver 1.1');
model.sol('sol3').feature('s1').feature('dDef').label('Direct 1');
model.sol('sol3').feature('s1').feature('dDef').set('thresh', 0.1);
model.sol('sol3').feature('s1').feature('aDef').label('Advanced 1');
model.sol('sol3').feature('s1').feature('fc1').label('Fully Coupled 1.1');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 150);
model.sol('sol3').feature('s1').feature('sn1').set('sensfunc', 'all_obj_contrib');
