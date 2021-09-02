%Cria��o da f�sica de eletromagnetismo - Caso n�o seja usada a f�sica MFNC,
%comentar o c�digo a seguir e criar manualmente a f�sica utilizada
model.component('comp1').physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');

model.component('comp1').physics('mfnc').create('mfc3', 'MagneticFluxConservation', 2);
model.component('comp1').physics('mfnc').create('mfc4', 'MagneticFluxConservation', 2);
model.component('comp1').physics('mfnc').create('mfc2', 'MagneticFluxConservation', 2);
%Define um ponto com potencial = 0, essencial para converg�ncia do modelo
%Caso seja definida uma aresta com potencial 0, normalmente aplicado em
%problemas com simetria, n�o � necess�rio.
model.component('comp1').physics('mfnc').create('zsp1', 'ZeroMagneticScalarPotential', 0);
try 
    model.component('comp1').physics('mfnc').feature('zsp1').selection.set([1]);
catch 
    model.component('comp1').physics('mfnc').feature('zsp1').selection.set([]);
end


%Regi�o de design. Principal parte para m�todo da densidade.

%Regi�o de design 2. F�sica que utiliza tamb�m a segunda vari�vel de
%densidade como �m� a ser otimizado
if n_vars_densidade>1
    model.component('comp1').physics('mfnc').feature('mfc2').selection.named('design');
    model.component('comp1').physics('mfnc').feature('mfc2').set('ConstitutiveRelationH', 'RemanentFluxDensity');
    model.component('comp1').physics('mfnc').feature('mfc2').set('mur_mat', 'userdef');
    model.component('comp1').physics('mfnc').feature('mfc2').set('minput_temperature_src', 'userdef');
    model.component('comp1').physics('mfnc').feature('mfc2').set('Br', {'B_rem*Double_simp(Br_var,ur_var)*cos(theta_var)'; 'B_rem*Double_simp(Br_var,ur_var)*sin(theta_var)'; '0'});
    model.component('comp1').physics('mfnc').feature('mfc2').set('mur', {'ur_ferro*Double_simp(Br_var,ur_var)'; '0'; '0'; '0'; 'ur_ferro*Double_simp(Br_var,ur_var)'; '0'; '0'; '0'; 'ur_ferro*Double_simp(Br_var,ur_var)'});
    model.component('comp1').physics('mfnc').feature('mfc2').label('Design Region - Magnetic Flux Conservation');
else %Apenas para ferro
    model.component('comp1').physics('mfnc').create('mfc2', 'MagneticFluxConservation', 2);
    model.component('comp1').physics('mfnc').feature('mfc2').selection.named('design');
    model.component('comp1').physics('mfnc').feature('mfc2').set('mur_mat', 'userdef');
    model.component('comp1').physics('mfnc').feature('mfc2').set('mur', {'simp_linear(ur_var)'; '0'; '0'; '0'; 'simp_linear(ur_var)'; '0'; '0'; '0'; 'simp_linear(ur_var)'});
    model.component('comp1').physics('mfnc').feature('mfc2').set('minput_temperature_src', 'userdef');
    model.component('comp1').physics('mfnc').feature('mfc2').label('Design Region - Magnetic Flux Conservation');
end



%virtual Mag
model.component('comp1').physics('mfnc').feature('mfc3').selection.named('gap');
model.component('comp1').physics('mfnc').feature('mfc3').set('ConstitutiveRelationH', 'RemanentFluxDensity');
model.component('comp1').physics('mfnc').feature('mfc3').set('Br', {'0'; 'Brem_virt'; '0'});
model.component('comp1').physics('mfnc').feature('mfc3').set('mur_mat', 'userdef');
model.component('comp1').physics('mfnc').feature('mfc3').set('minput_temperature_src', 'userdef');
%model.component('comp1').physics('mfnc').feature('mfc3').set('mur_crel_BH_RemanentFluxDensity_mat', 'userdef');
%model.component('comp1').physics('mfnc').feature('mfc3').set('mur_crel_BH_RemanentFluxDensity', {1; '0'; '0'; '0'; 1; '0'; '0'; '0'; 1});
%model.component('comp1').physics('mfnc').feature('mfc3').set('normBr_crel_BH_RemanentFluxDensity_mat', 'userdef');
%model.component('comp1').physics('mfnc').feature('mfc3').set('normBr_crel_BH_RemanentFluxDensity', 1);
%model.component('comp1').physics('mfnc').feature('mfc3').set('e_crel_BH_RemanentFluxDensity', [0; 1; 0]);
model.component('comp1').physics('mfnc').feature('mfc3').label('Magnetic Flux Conservation  - Virtual mag');

model.component('comp1').physics('mfnc').feature('mfc3').active(false);

%real_mag
model.component('comp1').physics('mfnc').feature('mfc4').selection.named('mag');
model.component('comp1').physics('mfnc').feature('mfc4').set('ConstitutiveRelationH', 'RemanentFluxDensity');
model.component('comp1').physics('mfnc').feature('mfc4').set('mur_mat', 'userdef');
model.component('comp1').physics('mfnc').feature('mfc4').set('minput_temperature_src', 'userdef');
model.component('comp1').physics('mfnc').feature('mfc4').set('Br', {'B_rem*cos(0)'; 'B_rem*sin(0)'; '0'});
model.component('comp1').physics('mfnc').feature('mfc4').set('mur', {'mu_rec'; '0'; '0'; '0'; 'mu_rec'; '0'; '0'; '0'; 'mu_rec'});
%model.component('comp1').physics('mfnc').feature('mfc4').set('mur_crel_BH_RemanentFluxDensity_mat', 'userdef');
%model.component('comp1').physics('mfnc').feature('mfc4').set('mur_crel_BH_RemanentFluxDensity', {'mu_rec'; '0'; '0'; '0'; 'mu_rec'; '0'; '0'; '0'; 'mu_rec'});
%model.component('comp1').physics('mfnc').feature('mfc4').set('normBr_crel_BH_RemanentFluxDensity_mat', 'userdef');
%model.component('comp1').physics('mfnc').feature('mfc4').set('normBr_crel_BH_RemanentFluxDensity', 'B_rem');
%model.component('comp1').physics('mfnc').feature('mfc4').set('e_crel_BH_RemanentFluxDensity', [0; 1; 0]);
model.component('comp1').physics('mfnc').feature('mfc4').label('Magnetic Flux Conservation - Mag ');