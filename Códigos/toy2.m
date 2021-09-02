
function [f0val,df0dx,fval,dfdx] = toy2(x,model,index_p,len_U)

%Faz com que a vari�vel p tenha valor de x_val na solu��o do estudo 1, para
%que ent�o no estudo 2 defina-se a vari�vel p1 como p (e portanto x_val).
U_new = zeros(len_U,1);
for i=1:length(index_p)
    U_new(index_p(i))=x(i);
end
model.sol('sol1').setU(U_new);
model.sol('sol1').createSolution;

model.study('std3').feature('sens').set('objectiveActive', {'on' 'off' 'off' 'off'});
model.sol('sol3').run();

    
obj = (mpheval(model,'sens2.gobj1','dataonly','on','dataset','dset3'));

f0val = (obj(1));


sens_f = mphgetu(model,'Type','Fsens','soltag','sol3');
df0dx = sens_f(~isnan(sens_f));

model.study('std3').feature('sens').set('objectiveActive', {'off' 'on' 'off' 'off'});
model.sol('sol3').run();

f_constraint = [(mpheval(model,'sens2.gobj2','dataonly','on','dataset','dset2'))];

fval = [f_constraint(1)];

%OBS: A fun��o mpheval retorna um vetor com tamanho do vetor de vari�veis
%do sistema, por�m com o valor da fun��o especificada. Por isso utiliza-se
%o (1).

sens_c1 = mphgetu(model,'Type','Fsens','soltag','sol3');

dfdx =[sens_c1(~isnan(sens_c1))'];

