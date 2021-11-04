%n_integral_objectives = 2; %numero de integra��es em diferentes regi�es feita para 


%Define par�metros gerais
%model.param.set('r_filter', '0');
model.param.set('ur_ferro', '5000','Permebilidade relativa do a�o magn�tico linear');
model.param.set('beta', '8','Par�metro de suavidade do degrau de heaviside');
model.param.set('pb', '0.5','Centro do degrau de Heaviside');
model.param.set('psimp', '3','Par�metro s da fun��o SIMP');
model.param.set('B_rem', '1.41', 'Reman�ncia dos �m�s utilizados');
model.param.set('mu_rec', '1.05','Permeabilidade de recuo dos �m�s utilizados');
model.param.set('Brem_virt', '1', 'Reman�ncia do �m� virtual');

for i=1:n_constraints
    
    const_tag = ['Const_' num2str(i)];
    model.param.set(const_tag, '0.5','Restri�ao i ( g_i(p)<=Const_i )');
end

%Cria componente 2D
model.component.create('comp1', true);

%Define geometria. Ler coment�rios do script "define_geom.m".
define_geom; 

%Define materiais
define_material;

% Cria fun��es para m�todo da Densidade
define_func_densidade;

%Cria sele��es de regi�es - complementar � m�o
define_selections;

%Define algumas vari�veis �teis do modelo
define_var;

%Define a f�sica MFNC da magnetost�tica
define_mfnc;

%Define as f�sica de sensibilidade, assim como as vari�veis de controle, a
%fun��o objetivo e as fun��es de restri��o.
define_sens;

%Define a f�sica do filtro de Helmholtz
define_filter;

%Define malha. Sujeita a altera��es, ler o script 'define_mesh.m'
define_mesh;

%Define os estudos a serem utilizados para o m�todo da densidade. 
define_studies;

fprintf('Modelo criado. \n')
fprintf('Para abrir o COMSOL do modelo: mphlaunch\n')
fprintf('Criar geometria no comsol e atualizar as sele��es de Gap, Mag e Design\n')
fprintf('M�todo criado com �m� real. Para usar �m� virtual: apply_virtual_mag \n')
fprintf('M�todo criado com a�o otimizado linear. Para n�o linear: set_SIMP_NaoLinear\n \n \n')
