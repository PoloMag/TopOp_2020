
function [f0val,df0dx,fval,dfdx] = toy2(x,model,index_p,len_U,n_constraints)

%Faz com que a vari�vel p tenha valor de x_val na solu��o do estudo 1, para
%que ent�o no estudo 2 defina-se a vari�vel p1 como p (e portanto x_val).
U_new = zeros(len_U,1);
for i=1:length(index_p)
    U_new(index_p(i))=x(i);
end
model.sol('sol1').setU(U_new);
model.sol('sol1').createSolution;
model.sol('sol2').run();


cell_obj_func_size = 1+n_constraints;
cell_obj_func = cell(1,cell_obj_func_size);

for i=1:cell_obj_func_size-1
    cell_obj_func{i} = 'off';
end
cell_obj_func{cell_obj_func_size} = 'on'; 
model.study('std3').feature('sens').set('objectiveActive', cell_obj_func); 

model.sol('sol3').run();

    
obj = (mpheval(model,'sens2.gobj1','dataonly','on','dataset','dset3'));

f0val = (obj(1));


sens_f = mphgetu(model,'Type','Fsens','soltag','sol3');
df0dx = sens_f(~isnan(sens_f));


cell_obj_func{cell_obj_func_size} = 'off'; 

fval = zeros(n_constraints,1);
dfdx = zeros(n_constraints, length(df0dx));

for i=1:n_constraints
    cell_obj_func{i} = 'on';
    model.study('std3').feature('sens').set('objectiveActive', cell_obj_func); 
    model.sol('sol3').run();
    
    gobj = 'sens2.gconst%d';
    gobj = sprintf(gobj,i);
    f_constraint = (mpheval(model,gobj,'dataonly','on','dataset','dset3'));
    fval(i) = f_constraint(1);
    
    sens_c1 = mphgetu(model,'Type','Fsens','soltag','sol3');
    
    dfdx(i,:) =sens_c1(~isnan(sens_c1))';
    
    cell_obj_func{i} = 'off';
end

cell_obj_func{cell_obj_func_size} = 'on'; 
model.study('std3').feature('sens').set('objectiveActive', cell_obj_func); 


%OBS: A fun��o mpheval retorna um vetor com tamanho do vetor de vari�veis
%do sistema, por�m com o valor da fun��o especificada. Por isso utiliza-se
%o (1).


