
%virtual Mag
model.param.set('Brem_virt', '1', 'Reman�ncia do �m� virtual');

%f�sica
model.component('comp1').physics('mfnc').create('virtmag', 'MagneticFluxConservation', 2);
model.component('comp1').physics('mfnc').feature('virtmag').selection.named('gap');
model.component('comp1').physics('mfnc').feature('virtmag').set('ConstitutiveRelationH', 'RemanentFluxDensity');
model.component('comp1').physics('mfnc').feature('virtmag').set('Br', {'0'; 'Brem_virt'; '0'});
model.component('comp1').physics('mfnc').feature('virtmag').set('mur_mat', 'userdef');
model.component('comp1').physics('mfnc').feature('virtmag').set('minput_temperature_src', 'userdef');
%model.component('comp1').physics('mfnc').feature('virtmag').set('mur_crel_BH_RemanentFluxDensity_mat', 'userdef');
%model.component('comp1').physics('mfnc').feature('virtmag').set('mur_crel_BH_RemanentFluxDensity', {1; '0'; '0'; '0'; 1; '0'; '0'; '0'; 1});
%model.component('comp1').physics('mfnc').feature('virtmag').set('normBr_crel_BH_RemanentFluxDensity_mat', 'userdef');
%model.component('comp1').physics('mfnc').feature('virtmag').set('normBr_crel_BH_RemanentFluxDensity', 1);
%model.component('comp1').physics('mfnc').feature('virtmag').set('e_crel_BH_RemanentFluxDensity', [0; 1; 0]);
model.component('comp1').physics('mfnc').feature('virtmag').label('Magnetic Flux Conservation  - Virtual mag');


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
%model.component('comp1').variable('var1').set('dcos', 'Max(cos(90[deg]-theta_H),cos(0-theta_H))');

%Efici�ncia geral calculada a partir do m�todo do �m� virtual
model.component('comp1').variable('var1').set('eta_virtual', '(mag(alpha*dcos)/Vmag)^2*virt_ef');
%Indu��o m�dia no entreferro estipulada a partir do m�todo do �m� virtual
model.component('comp1').variable('var1').set('B_med_virtual', 'B_rem*Mag(mfnc.normB*dcos)/Vgap');


model.component('comp1').physics('mfnc').feature('mfc3').active(false); %desativa f�sica do �m� 'real' (caso sejam adicionadas novas, pode-se coloar aqui)

%definir vari�vel a partir da fun��o max do produto escalar de Bv com as
%reman�ncias poss�veis