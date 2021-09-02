%Define algumas vari�veis �teis do modelo
model.component('comp1').variable.create('var1');

%Raio do filtro de Helmholtz. Definida inicialmente como h, que � o tamanho
%do elemento do FEM. � um bom valor para ser utilizado. Para ter-se um
%filtro independente da malha, � adequado alterar r_filter para um valor
%fixo um pouco superior ao h m�dio (por exemplo, 5E-2). Este valor fixo
%pode ser obtido analisando diferentes valores e o impacto na topologia.
model.component('comp1').variable('var1').set('r_filter', 'h');

%Define ur_var, a vari�vel de controle tratada, pronta para ser
%transformada em permeabilidade pela fun��o SIMP
model.component('comp1').variable('var1').set('ur_var', 'projection1(u)');
model.component('comp1').variable('var1').set('Br_var', 'projection1(u_br)');
model.component('comp1').variable('var1').set('theta_var', 'p3*2*pi');

model.component('comp1').variable('var1').set('Vgap', 'gap(1)'); %Volume (ou �rea, no caso) do entreferro

model.component('comp1').variable('var1').set('Vmag', 'mag(1)'); %Volume (ou �rea, no caso) de �m�

%Efici�ncias
model.component('comp1').variable('var1').set('Mag_ef', 'ext(mfnc.Wm*2)/mag(mfnc.normBr^2/(4*mu0_const))');
model.component('comp1').variable('var1').set('Est_ef', 'gap(mfnc.Wm*2)/ext(mfnc.Wm*2)');
model.component('comp1').variable('var1').set('Gen_ef', 'Mag_ef*Est_ef');

%Indu��o m�dia no entreferro
model.component('comp1').variable('var1').set('B_med', 'Av_gap(mfnc.normB)');

%Abaixo, vari�veis utilizadas ao se aplicar o m�todo do �m� virtual

model.component('comp1').variable('var1').set('virt_ef', 'mag(mfnc.Wm*2)/gap(Brem_virt^2/(4*mu0_const))'); %Efici�ncia geral do �m� virtual para gerar campo na regi�o de �m�s reais
model.component('comp1').variable('var1').set('Bstar', 'sqrt(virt_ef*Vgap/(4*Vmag))'); %Campo �timo a ser gerado pelo �m� virtual nas regi�es de �m� real
model.component('comp1').variable('var1').set('alpha', 'mfnc.normB/Bstar'); %Par�metro alpha (TCC Lu�s Cattelan)
model.component('comp1').variable('var1').set('theta_H', 'atan2(mfnc.By,mfnc.Bx)'); %�ngulo dos vetores de indu��o magn�tica

%�ngulo de reman�ncias. Utilizado para aplicar o produto escalar do m�todo do �m� virtual.
%Para supor reman�ncias ideais, sup�e-se que theta_rem = theta_H. 
%Se tem-se theta_rem pr�-definido, pode-se utilizar tal valor. Para
%theta_rem diferente em diferentes regi�es, o modelo deve ser adaptado,
%repartindo a integral em 'mag' em diferentes integrais para cada regi�o
%com diferente theta_rem
model.component('comp1').variable('var1').set('theta_rem', 'theta_H');
%Perda angular do m�todo do �m� virtual.
model.component('comp1').variable('var1').set('dcos', 'cos(theta_rem-theta_H)');

%Efici�ncia geral calculada a partir do m�todo do �m� virtual
model.component('comp1').variable('var1').set('eta_virtual', '(mag(alpha*dcos)/Vmag)^2*virt_ef');
%Indu��o m�dia no entreferro estipulada a partir do m�todo do �m� virtual
model.component('comp1').variable('var1').set('B_med_virtual', 'B_rem*Mag(mfnc.normB*dcos)/Vgap');


