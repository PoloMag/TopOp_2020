
%virtual Mag
model.param.set('Brem_virt', '1', 'Remanência do ímã virtual');

%física
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


%Abaixo, variáveis utilizadas ao se aplicar o método do ímã virtual

model.component('comp1').variable('var1').set('virt_ef', 'mag(mfnc.Wm*2)/gap(Brem_virt^2/(4*mu0_const))'); %Eficiência geral do ímã virtual para gerar campo na região de ímãs reais
model.component('comp1').variable('var1').set('Bstar', 'sqrt(virt_ef*Vgap/(4*Vmag))'); %Campo ótimo a ser gerado pelo ímã virtual nas regiões de ímã real
model.component('comp1').variable('var1').set('alpha', 'mfnc.normB/Bstar'); %Parâmetro alpha (TCC Luís Cattelan)
model.component('comp1').variable('var1').set('theta_H', 'atan2(mfnc.By,mfnc.Bx)'); %Ângulo dos vetores de indução magnética

%Ângulo de remanências. Utilizado para aplicar o produto escalar do método do ímã virtual.
%Para supor remanências ideais, supõe-se que theta_rem = theta_H. 
%Se tem-se theta_rem pré-definido, pode-se utilizar tal valor. Para
%theta_rem diferente em diferentes regiões, o modelo deve ser adaptado,
%repartindo a integral em 'mag' em diferentes integrais para cada região
%com diferente theta_rem
model.component('comp1').variable('var1').set('theta_rem', 'theta_H');
%Perda angular do método do ímã virtual.
model.component('comp1').variable('var1').set('dcos', 'cos(theta_rem-theta_H)');
%model.component('comp1').variable('var1').set('dcos', 'Max(cos(90[deg]-theta_H),cos(0-theta_H))');

%Eficiência geral calculada a partir do método do ímã virtual
model.component('comp1').variable('var1').set('eta_virtual', '(mag(alpha*dcos)/Vmag)^2*virt_ef');
%Indução média no entreferro estipulada a partir do método do ímã virtual
model.component('comp1').variable('var1').set('B_med_virtual', 'B_rem*Mag(mfnc.normB*dcos)/Vgap');


model.component('comp1').physics('mfnc').feature('mfc3').active(false); %desativa física do ímã 'real' (caso sejam adicionadas novas, pode-se coloar aqui)

%definir variável a partir da função max do produto escalar de Bv com as
%remanências possíveis