%Física utilizadas para método da Densidade
%sens1 - Física auxiliar de definição das variáves de controle
model.component('comp1').physics.create('sens', 'Sensitivity', 'geom1');
model.component('comp1').physics('sens').selection.all;

%sens2 - Física onde serão definidas as variáveis e funções a serem
%efetivamente utilizadas
model.component('comp1').physics.create('sens2', 'Sensitivity', 'geom1');
model.component('comp1').physics('sens2').selection.all;

define_control_vars;

for i=1:n_constraints
    
    const_tag_g = ['gconst' num2str(i)];
    
    model.component('comp1').physics('sens2').create(const_tag_g, 'GlobalObjective', -1);
    
    if i==2 && n_vars_densidade>1
        const_expression = ['design(Br_var) - Const_' num2str(i)];
    else
        const_expression = ['design(ur_var) - Const_' num2str(i)];
    end
    model.component('comp1').physics('sens2').feature(const_tag_g).set('objectiveExpression', const_expression);
    gobj_label = ['Constraint ' num2str(i)];
    model.component('comp1').physics('sens2').feature(const_tag_g).label(gobj_label);

end


model.component('comp1').physics('sens2').create('gobj1', 'GlobalObjective', -1);
model.component('comp1').physics('sens2').feature('gobj1').set('objectiveExpression', '-(gap_high(mfnc.normB)-gap_low(mfnc.normB))');
model.component('comp1').physics('sens2').feature('gobj1').label('Objective');