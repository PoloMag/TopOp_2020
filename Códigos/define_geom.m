
%Cria geometria
model.component('comp1').geom.create('geom1', 2);
model.component('comp1').geom('geom1').create('c1', 'Circle');
model.component('comp1').geom('geom1').run;


%Aqui, foi criada apenas uma geometria default de um c�rculo para que se
%possa realizar a defini��o da malha (esta precisa ser feita com uma geometria definida)

%Caso deseje-se, pode-se definir alguma geometria padr�o e alterar este
%c�digo para que j� se crie tal.
%Pode-se deixar este c�digo com esta geometria padr�o e, ap�s a aplica��o
%do scrit 'pre.m', construir a geometria '� m�o' (diretamente no COMSOL).
%Pode-se tamb�m, em vez de aplicar o script pr�, aplicar cada script
%separadamente e criar a geometria desejada quando quiser diretamente no
%COMSOL.