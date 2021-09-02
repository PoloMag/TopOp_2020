%Cria��o de malha padr�o.
%Foi utilizada a malha mais fina das padr�es do COMSOL para a regi�o de
%design e uma um pouco mais robusta para o resto do espa�o.
%Pode ser alterada aqui ou no COMSOL diretamente, uma possibilidade
%positiva � deixar a malha em todo o espa�o como a mais fina. Ainda,
%pode-se alter�-la para que se tenha tamanhos diferentes dos padr�es
%sugeridos do COMSOL.
%Sugere-se ter uma malha fina para a regi�o de design.
model.component('comp1').mesh.create('mesh1');
model.component('comp1').mesh('mesh1').create('ftri1', 'FreeTri');
model.component('comp1').mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').selection.named('design');
model.component('comp1').mesh('mesh1').feature('size').set('hauto', 3);
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.component('comp1').mesh('mesh1').run;