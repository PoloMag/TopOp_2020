model.component('comp1').physics('mfnc').feature('mfc3').active(true); %ativa f�sica do ima virtual
model.component('comp1').physics('mfnc').feature('mfc4').active(false); %desativa f�sica do �m� real

%Se forem adicionadas f�sicas novas para o �m� (caso haja reman�ncias
%diferentes, em �ngulo ou m�dulo) pode-se adicion�-las aqui. Checar a tag
%das f�sicas (por exemplo, nessa f�sica padr�o de �m� � mfc4) e adicionar
%uma linha igual � �ltima por�m substituindo 'mfc4' pela tag desejada