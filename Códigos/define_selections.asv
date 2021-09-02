%Cria seleções de regiões - complementar à mão
% No COMSOL, realizar a seleção à mão para as respectivas seleções (gap, mag, design..)
%Caso deseje-se, pode-se criar estas seleções na própria criação de
%geometrias, em 'Contribute to' (última linha do quadro Settings de cada parte da geometria criada)
% Esta possibilidade é recomendada quando se cria muitos blocos distintos
% para tal região (por exemplo a criação de diversos blocos de ímã. 
% Ler a documentação para tal implementação, que exige uma pequena mudança
% nesta parte de seleções. 
model.component('comp1').selection.create('all_domains', 'Explicit');
model.component('comp1').selection.create('gap', 'Explicit');
model.component('comp1').selection.create('gap_high', 'Explicit');
model.component('comp1').selection.create('gap_low', 'Explicit');
model.component('comp1').selection.create('mag', 'Explicit');
model.component('comp1').selection.create('design', 'Explicit');
model.component('comp1').selection.create('ext', 'Difference');

model.component('comp1').selection('all_domains').all;


model.component('comp1').selection('all_domains').label('ALL_Domains');
model.component('comp1').selection('gap').label('Gap');
model.component('comp1').selection('gap_high').label('Gap - Campo alto');
model.component('comp1').selection('gap_low').label('Gap - Campo baixo');
model.component('comp1').selection('mag').label('Mag');
model.component('comp1').selection('design').label('Design');

model.component('comp1').selection('ext').label('All');
model.component('comp1').selection('ext').set('add', {'all_domains'});
model.component('comp1').selection('ext').set('subtract', {'mag'});

model.component('comp1').cpl.create('intop1', 'Integration');
model.component('comp1').cpl('intop1').set('opname', 'gap');
model.component('comp1').cpl('intop1').selection.named('gap');
model.component('comp1').cpl('intop1').label('Integration GAP');

model.component('comp1').cpl.create('intop4', 'Integration');
model.component('comp1').cpl('intop4').set('opname', 'gap_high');
model.component('comp1').cpl('intop4').selection.named('gap_high');
model.component('comp1').cpl('intop4').label('Integration GAP - campo alto');

model.component('comp1').cpl.create('intop5', 'Integration');
model.component('comp1').cpl('intop5').set('opname', 'gap_low');
model.component('comp1').cpl('intop5').selection.named('gap_low');
model.component('comp1').cpl('intop5').label('Integration GAP - campo baixo');

model.component('comp1').cpl.create('intop2', 'Integration');
model.component('comp1').cpl('intop2').set('opname', 'mag');
model.component('comp1').cpl('intop2').selection.named('mag');
model.component('comp1').cpl('intop2').label('Integration MAG');


model.component('comp1').cpl.create('intop3', 'Integration');
model.component('comp1').cpl('intop3').set('opname', 'ext');
model.component('comp1').cpl('intop3').selection.named('ext');
model.component('comp1').cpl('intop3').label('Integration EXT');


model.component('comp1').cpl.create('aveop1', 'Average');
model.component('comp1').cpl('aveop1').set('opname', 'Av_gap');
model.component('comp1').cpl('aveop1').selection.named('gap');
model.component('comp1').cpl('aveop1').label('Av_gap');


%Objetivos e restrições

%for i=1:n_integral_objectives
%    tag1 = ['iobj' num2str(i)];
%    tag2 = ['Integral Objective ' num2str(i)];
%    model.component('comp1').cpl.create(tag1, 'Integration');
%    model.component('comp1').cpl(tag1).selection.named('gap_high');
%    model.component('comp1').cpl(tag1).label(tag2);
%    model.component('comp1').cpl(tag1).set('opname', tag1);
%end

%for i=1:n_constraints
%    tag1 = ['iconst' num2str(i)];
%    tag2 = ['Integral Constraint ' num2str(i)];
%    model.component('comp1').cpl.create(tag1, 'Integration');
%    model.component('comp1').cpl(tag1).selection.named('design');
%    model.component('comp1').cpl(tag1).label(tag2);
%    model.component('comp1').cpl(tag1).set('opname', tag1);
%end



