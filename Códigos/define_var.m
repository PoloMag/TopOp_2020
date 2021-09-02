%Define algumas variáveis úteis do modelo
model.component('comp1').variable.create('var1');

%Raio do filtro de Helmholtz. Definida inicialmente como h, que é o tamanho
%do elemento do FEM. É um bom valor para ser utilizado. Para ter-se um
%filtro independente da malha, é adequado alterar r_filter para um valor
%fixo um pouco superior ao h médio (por exemplo, 5E-2). Este valor fixo
%pode ser obtido analisando diferentes valores e o impacto na topologia.
model.component('comp1').variable('var1').set('r_filter', 'h');

%Define ur_var, a variável de controle tratada, pronta para ser
%transformada em permeabilidade pela função SIMP
model.component('comp1').variable('var1').set('ur_var', 'projection1(u)');
model.component('comp1').variable('var1').set('Br_var', 'projection1(u_br)');
model.component('comp1').variable('var1').set('theta_var', 'p3*2*pi');

model.component('comp1').variable('var1').set('Vgap', 'gap(1)'); %Volume (ou área, no caso) do entreferro

model.component('comp1').variable('var1').set('Vmag', 'mag(1)'); %Volume (ou área, no caso) de ímã

%Eficiências
model.component('comp1').variable('var1').set('Mag_ef', 'ext(mfnc.Wm*2)/mag(mfnc.normBr^2/(4*mu0_const))');
model.component('comp1').variable('var1').set('Est_ef', 'gap(mfnc.Wm*2)/ext(mfnc.Wm*2)');
model.component('comp1').variable('var1').set('Gen_ef', 'Mag_ef*Est_ef');

%Indução média no entreferro
model.component('comp1').variable('var1').set('B_med', 'Av_gap(mfnc.normB)');

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

%Eficiência geral calculada a partir do método do ímã virtual
model.component('comp1').variable('var1').set('eta_virtual', '(mag(alpha*dcos)/Vmag)^2*virt_ef');
%Indução média no entreferro estipulada a partir do método do ímã virtual
model.component('comp1').variable('var1').set('B_med_virtual', 'B_rem*Mag(mfnc.normB*dcos)/Vgap');


