%Criação de malha padrão.
%Foi utilizada a malha mais fina das padrões do COMSOL para a região de
%design e uma um pouco mais robusta para o resto do espaço.
%Pode ser alterada aqui ou no COMSOL diretamente, uma possibilidade
%positiva é deixar a malha em todo o espaço como a mais fina. Ainda,
%pode-se alterá-la para que se tenha tamanhos diferentes dos padrões
%sugeridos do COMSOL.
%Sugere-se ter uma malha fina para a região de design.
model.component('comp1').mesh.create('mesh1');
model.component('comp1').mesh('mesh1').create('ftri1', 'FreeTri');
model.component('comp1').mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').selection.named('design');
model.component('comp1').mesh('mesh1').feature('size').set('hauto', 3);
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.component('comp1').mesh('mesh1').run;