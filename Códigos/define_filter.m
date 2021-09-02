%Física do filtro de Helmholtz - opcional. Caso se opte pela não utilização
%do filtro, pode-se usar r_filter =0 ou então trocar em Variáveis o valor
%de ur_var para p1 (ou definir u=p1)
if n_vars_densidade>1
    model.component('comp1').physics.create('hzeq2', 'HelmholtzEquation', 'geom1');
    model.component('comp1').physics('hzeq2').field('dimensionless').field('u_br');
    model.component('comp1').physics('hzeq2').selection.named('design');
    model.component('comp1').physics('hzeq2').feature('heq1').set('c', {'r_filter^2' '0' '0' 'r_filter^2'});
    model.component('comp1').physics('hzeq2').feature('heq1').set('a', 1);
    model.component('comp1').physics('hzeq2').feature('heq1').set('f', 'p2'); 
    
end
model.component('comp1').physics.create('hzeq', 'HelmholtzEquation', 'geom1');
model.component('comp1').physics('hzeq').selection.named('design');
model.component('comp1').physics('hzeq').feature('heq1').set('c', {'r_filter^2' '0' '0' 'r_filter^2'});
model.component('comp1').physics('hzeq').feature('heq1').set('a', 1);
model.component('comp1').physics('hzeq').feature('heq1').set('f', 'p1');