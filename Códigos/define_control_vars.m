vars = {};
vars_aux = {};
init_val = zeros(1,n_blocks+3*n_blocks);

for i=1:n_vars_densidade
    
    var_tag = ['cvar' num2str(i)];
    model.component('comp1').physics('sens').create(var_tag, 'ControlVariableField', 2);
    model.component('comp1').physics('sens').feature(var_tag).selection.named('design');
    
    var_aux_name = ['p_aux' num2str(i)];
    model.component('comp1').physics('sens').feature(var_tag).set('fieldVariableName', var_aux_name);

    model.component('comp1').physics('sens').feature(var_tag).set('initialValue', 0);
    model.component('comp1').physics('sens').feature(var_tag).set('shapeFunctionType', 'shdisc');
    model.component('comp1').physics('sens').feature(var_tag).set('order', 0);
    
    model.component('comp1').physics('sens2').create(var_tag, 'ControlVariableField', 2);
    model.component('comp1').physics('sens2').feature(var_tag).selection.named('design');
    %model.component('comp1').physics('sens2').feature(var_tag).set('shapeFunctionType', 'shdisc');
    %model.component('comp1').physics('sens2').feature(var_tag).set('order', 0);
    var_name = ['p' num2str(i)];
    model.component('comp1').physics('sens2').feature(var_tag).set('fieldVariableName', var_name); 
    model.component('comp1').physics('sens2').feature(var_tag).set('initialValue', var_aux_name);
    
end

model.component('comp1').physics('sens').create('gcvar1', 'GlobalControlVariables', -1);
model.component('comp1').physics('sens2').create('gcvar1', 'GlobalControlVariables', -1);
for i=1:n_vars_global
    vars_aux = [vars_aux, ['v_aux_' num2str(i)]];
    
    vars = [vars, ['v' num2str(i)]];
end


for i=1:n_blocks
    vars_aux = [vars_aux, ['x_aux_' num2str(i)]];
    vars_aux = [vars_aux, ['y_aux_' num2str(i)]];
    vars_aux = [vars_aux, ['z_aux_' num2str(i)]];
    
    vars = [vars, ['x' num2str(i)]];
    vars = [vars, ['y' num2str(i)]];
    vars = [vars, ['z' num2str(i)]];
    
    init_val = vars_aux;
end

model.component('comp1').physics('sens').feature('gcvar1').set('variableList', vars_aux);

model.component('comp1').physics('sens2').feature('gcvar1').set('variableList', vars);

model.component('comp1').physics('sens2').feature('gcvar1').set('initList', vars_aux);
