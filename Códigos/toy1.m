
function [f0val,fval] = toy1(x,model,index_p,len_U,n_constraints)

%Faz com que a vari�vel p tenha valor de x_val na solu��o do estudo 1, para
%que ent�o no estudo 2 defina-se a vari�vel p1 como p (e portanto x_val).
U_new = zeros(len_U,1);
for i=1:length(index_p)
    U_new(index_p(i))=x(i);
end
model.sol('sol1').setU(U_new);
model.sol('sol1').createSolution;
model.sol('sol2').run();

%Fun��o objetivo
obj = (mpheval(model,'sens2.gobj1','dataonly','on','dataset','dset2'));

f0val = (obj(1));

%Fun��o(�es) de restri��o.
fval = zeros(n_constraints,1);
for i=1:n_constraints
    gobj = 'sens2.gconst%d';
    gobj = sprintf(gobj,i);
    f_constraint = (mpheval(model,gobj,'dataonly','on','dataset','dset2'));
    fval(i) = f_constraint(1);
end



%OBS: A fun��o mpheval retorna um vetor com tamanho do vetor de vari�veis
%do sistema, por�m com o valor da fun��o especificada. Por isso utiliza-se
%o (1).
end

