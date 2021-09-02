
function [f0val,fval] = toy1(x,model,index_p,len_U)

%Faz com que a variável p tenha valor de x_val na solução do estudo 1, para
%que então no estudo 2 defina-se a variável p1 como p (e portanto x_val).
U_new = zeros(len_U,1);
for i=1:length(index_p)
    U_new(index_p(i))=x(i);
end
model.sol('sol1').setU(U_new);
model.sol('sol1').createSolution;
model.sol('sol2').run();

%Função objetivo
obj = (mpheval(model,'sens2.gobj1','dataonly','on','dataset','dset2'));

f0val = (obj(1));

%Função(ões) de restrição. 
f_constraint = [(mpheval(model,'sens2.gobj2','dataonly','on','dataset','dset2'))];

fval = [f_constraint(1)];

%OBS: A função mpheval retorna um vetor com tamanho do vetor de variáveis
%do sistema, porém com o valor da função especificada. Por isso utiliza-se
%o (1).
end

