%n_integral_objectives = 2; %numero de integrações em diferentes regiões feita para 


%Define parâmetros gerais
%model.param.set('r_filter', '0');
model.param.set('ur_ferro', '5000','Permebilidade relativa do aço magnético linear');
model.param.set('beta', '8','Parâmetro de suavidade do degrau de heaviside');
model.param.set('pb', '0.5','Centro do degrau de Heaviside');
model.param.set('psimp', '3','Parâmetro s da função SIMP');
model.param.set('B_rem', '1.41', 'Remanência dos ímãs utilizados');
model.param.set('mu_rec', '1.05','Permeabilidade de recuo dos ímãs utilizados');
model.param.set('Brem_virt', '1', 'Remanência do ímã virtual');

for i=1:n_constraints
    
    const_tag = ['Const_' num2str(i)];
    model.param.set(const_tag, '0.5','Restriçao i ( g_i(p)<=Const_i )');
end

%Cria componente 2D
model.component.create('comp1', true);

%Define geometria. Ler comentários do script "define_geom.m".
define_geom; 

%Define materiais
define_material;

% Cria funções para método da Densidade
define_func_densidade;

%Cria seleções de regiões - complementar à mão
define_selections;

%Define algumas variáveis úteis do modelo
define_var;

%Define a física MFNC da magnetostática
define_mfnc;

%Define as física de sensibilidade, assim como as variáveis de controle, a
%função objetivo e as funções de restrição.
define_sens;

%Define a física do filtro de Helmholtz
define_filter;

%Define malha. Sujeita a alterações, ler o script 'define_mesh.m'
define_mesh;

%Define os estudos a serem utilizados para o método da densidade. 
define_studies;

fprintf('Modelo criado. \n')
fprintf('Para abrir o COMSOL do modelo: mphlaunch\n')
fprintf('Criar geometria no comsol e atualizar as seleções de Gap, Mag e Design\n')
fprintf('Método criado com ímã real. Para usar ímã virtual: apply_virtual_mag \n')
fprintf('Método criado com aço otimizado linear. Para não linear: set_SIMP_NaoLinear\n \n \n')
