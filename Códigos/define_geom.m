
%Cria geometria
model.component('comp1').geom.create('geom1', 2);
model.component('comp1').geom('geom1').create('c1', 'Circle');
model.component('comp1').geom('geom1').run;


%Aqui, foi criada apenas uma geometria default de um círculo para que se
%possa realizar a definição da malha (esta precisa ser feita com uma geometria definida)

%Caso deseje-se, pode-se definir alguma geometria padrão e alterar este
%código para que já se crie tal.
%Pode-se deixar este código com esta geometria padrão e, após a aplicação
%do scrit 'pre.m', construir a geometria 'à mão' (diretamente no COMSOL).
%Pode-se também, em vez de aplicar o script pré, aplicar cada script
%separadamente e criar a geometria desejada quando quiser diretamente no
%COMSOL.