model.component('comp1').physics('mfnc').feature('mfc3').active(true); %ativa física do ima virtual
model.component('comp1').physics('mfnc').feature('mfc4').active(false); %desativa física do ímã real

%Se forem adicionadas físicas novas para o ímã (caso haja remanências
%diferentes, em ângulo ou módulo) pode-se adicioná-las aqui. Checar a tag
%das físicas (por exemplo, nessa física padrão de ímã é mfc4) e adicionar
%uma linha igual à última porém substituindo 'mfc4' pela tag desejada