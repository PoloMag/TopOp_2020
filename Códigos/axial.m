function out = model
%
% axial.m
%
% Model exported on Aug 18 2021, 18:48 by COMSOL 5.3.0.316.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('F:\GitHub\Top_op2020\Models - COMSOL');

model.label('axial.mph');

model.comments(['Untitled\n\n']);

model.param.set('r_filter', '0');
model.param.set('ur', '5000');
model.param.set('beta', '8', ['Par' native2unicode(hex2dec({'00' 'e2'}), 'unicode') 'metro de suavidade do degrau de heaviside']);
model.param.set('pb', '0.5', 'Centro do degrau de Heaviside');
model.param.set('psimp', '3', ['Par' native2unicode(hex2dec({'00' 'e2'}), 'unicode') 'metro s da fun' native2unicode(hex2dec({'00' 'e7'}), 'unicode')  native2unicode(hex2dec({'00' 'e3'}), 'unicode') 'o SIMP']);
model.param.set('B_rem', '1.41', ['Reman' native2unicode(hex2dec({'00' 'ea'}), 'unicode') 'ncia dos ' native2unicode(hex2dec({'00' 'ed'}), 'unicode') 'm' native2unicode(hex2dec({'00' 'e3'}), 'unicode') 's utilizados']);
model.param.set('mu_rec', '1.05', ['Permeabilidade de recuo dos ' native2unicode(hex2dec({'00' 'ed'}), 'unicode') 'm' native2unicode(hex2dec({'00' 'e3'}), 'unicode') 's utilizados']);
model.param.set('Const_1', '0.5', ['Vari' native2unicode(hex2dec({'00' 'e1'}), 'unicode') 'vel de restri' native2unicode(hex2dec({'00' 'e7'}), 'unicode') 'ao 1 ( g(p)<=Const_1 )']);
model.param.set('ur_ferro', '5000', ['Permebilidade relativa do a' native2unicode(hex2dec({'00' 'e7'}), 'unicode') 'o magn' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'tico linear']);
model.param.set('Brem_virt', '1', ['Reman' native2unicode(hex2dec({'00' 'ea'}), 'unicode') 'ncia do ' native2unicode(hex2dec({'00' 'ed'}), 'unicode') 'm' native2unicode(hex2dec({'00' 'e3'}), 'unicode') ' virtual']);

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 2);

model.component('comp1').func.create('an1', 'Analytic');
model.component('comp1').func.create('an2', 'Analytic');
model.component('comp1').func.create('an3', 'Analytic');
model.component('comp1').func.create('an6', 'Analytic');
model.component('comp1').func.create('int1', 'Interpolation');
model.component('comp1').func.create('an5', 'Analytic');
model.component('comp1').func('an1').label('Heaviside Projection 1');
model.component('comp1').func('an1').set('funcname', 'projection1');
model.component('comp1').func('an1').set('expr', '(tanh(beta*(p-pb)) + tanh(beta*pb)) / (tanh(beta*(1-pb)) + tanh(beta*pb))');
model.component('comp1').func('an1').set('args', {'p'});
model.component('comp1').func('an1').set('plotargs', {'p' '0' '1'});
model.component('comp1').func('an2').label('Double_SIMP');
model.component('comp1').func('an2').set('funcname', 'Double_simp');
model.component('comp1').func('an2').set('expr', '(x^psimp)*((1-y)^psimp)');
model.component('comp1').func('an2').set('args', {'x' 'y'});
model.component('comp1').func('an2').set('plotargs', {'x' '0' '1'; 'y' '0' '1'});
model.component('comp1').func('an3').label('SIMP_nolinear');
model.component('comp1').func('an3').set('funcname', 'SIMP_nolinear');
model.component('comp1').func('an3').set('expr', '1-p^psimp+(p^psimp)*an5(H)');
model.component('comp1').func('an3').set('args', {'p' 'H'});
model.component('comp1').func('an3').set('argunit', '1,A/m');
model.component('comp1').func('an3').set('fununit', '1');
model.component('comp1').func('an3').set('plotargs', {'p' '0' '1'; 'H' '0' '316803.620'});
model.component('comp1').func('int1').set('funcname', 'BH_Bakker');
model.component('comp1').func('int1').set('table', {'0.000' '0.000';  ...
'79.577' '0.212';  ...
'100.182' '0.266';  ...
'126.122' '0.332';  ...
'158.778' '0.414';  ...
'199.890' '0.514';  ...
'251.646' '0.632';  ...
'316.804' '0.768';  ...
'398.832' '0.917';  ...
'502.100' '1.070';  ...
'632.106' '1.214';  ...
'795.775' '1.335';  ...
'1001.821' '1.423';  ...
'1261.218' '1.481';  ...
'1587.779' '1.517';  ...
'1998.896' '1.545';  ...
'2516.461' '1.571';  ...
'3168.036' '1.602';  ...
'3988.321' '1.638';  ...
'5020.999' '1.680';  ...
'6321.063' '1.727';  ...
'7957.747' '1.777';  ...
'10018.210' '1.825';  ...
'12612.179' '1.871';  ...
'15877.793' '1.911';  ...
'19988.957' '1.947';  ...
'25164.606' '1.982';  ...
'31680.362' '2.018';  ...
'39883.213' '2.055';  ...
'50209.990' '2.093';  ...
'63210.632' '2.128';  ...
'79577.472' '2.162';  ...
'100182.101' '2.195';  ...
'126121.793' '2.230';  ...
'158777.930' '2.272';  ...
'199889.571' '2.324';  ...
'251646.061' '2.389';  ...
'316803.620' '2.471'});
model.component('comp1').func('int1').set('defineprimfun', true);
model.component('comp1').func('int1').set('defineinv', true);
model.component('comp1').func('int1').set('extrap', 'interior');
model.component('comp1').func('an5').set('expr', 'int1(x)/(x*mu0_const)');
model.component('comp1').func('an5').set('argunit', 'A/m');
model.component('comp1').func('an5').set('plotargs', {'x' '0' '316803.620'});

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').create('c1', 'Circle');
model.component('comp1').geom('geom1').run;

model.component('comp1').selection.create('all_domains', 'Explicit');
model.component('comp1').selection('all_domains').all;
model.component('comp1').selection.create('gap', 'Explicit');
model.component('comp1').selection.create('mag', 'Explicit');
model.component('comp1').selection.create('design', 'Explicit');
model.component('comp1').selection.create('ext', 'Difference');
model.component('comp1').selection('all_domains').label('ALL_Domains');
model.component('comp1').selection('gap').label('Gap');
model.component('comp1').selection('mag').label('Mag');
model.component('comp1').selection('design').label('Design');
model.component('comp1').selection('ext').label('All');
model.component('comp1').selection('ext').set('add', {'all_domains'});
model.component('comp1').selection('ext').set('subtract', {'mag'});

model.component('comp1').variable.create('var1');
model.component('comp1').variable('var1').set('r_filter', 'h');
model.component('comp1').variable('var1').set('ur_var', 'projection1(u)');
model.component('comp1').variable('var1').set('Br_var', 'projection1(u_br)');
model.component('comp1').variable('var1').set('theta_var', 'p3*2*pi');
model.component('comp1').variable('var1').set('Vgap', 'gap(1)');
model.component('comp1').variable('var1').set('Vmag', 'mag(1)');
model.component('comp1').variable('var1').set('Mag_ef', 'ext(mfnc.Wm*2)/mag(mfnc.normBr^2/(4*mu0_const))');
model.component('comp1').variable('var1').set('Est_ef', 'gap(mfnc.Wm*2)/ext(mfnc.Wm*2)');
model.component('comp1').variable('var1').set('Gen_ef', 'Mag_ef*Est_ef');
model.component('comp1').variable('var1').set('B_med', 'Av_gap(mfnc.normB)');
model.component('comp1').variable('var1').set('virt_ef', 'mag(mfnc.Wm*2)/gap(Brem_virt^2/(4*mu0_const))');
model.component('comp1').variable('var1').set('Bstar', 'sqrt(virt_ef*Vgap/(4*Vmag))');
model.component('comp1').variable('var1').set('alpha', 'mfnc.normB/Bstar');
model.component('comp1').variable('var1').set('theta_H', 'atan2(mfnc.By,mfnc.Bx)');
model.component('comp1').variable('var1').set('theta_rem', 'theta_H');
model.component('comp1').variable('var1').set('dcos', 'cos(theta_rem-theta_H)');
model.component('comp1').variable('var1').set('eta_virtual', '(mag(alpha*dcos)/Vmag)^2*virt_ef');
model.component('comp1').variable('var1').set('B_med_virtual', 'B_rem*Mag(mfnc.normB*dcos)/Vgap');

model.component('comp1').view('view1').tag('view4');
model.view.create('view2', 2);
model.view.create('view3', 2);

model.material.create('mat1', 'Common', '');
model.component('comp1').material.create('mat2', 'Common');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.component('comp1').material('mat2').propertyGroup('def').func.create('eta', 'Piecewise');
model.component('comp1').material('mat2').propertyGroup('def').func.create('Cp', 'Piecewise');
model.component('comp1').material('mat2').propertyGroup('def').func.create('rho', 'Analytic');
model.component('comp1').material('mat2').propertyGroup('def').func.create('k', 'Piecewise');
model.component('comp1').material('mat2').propertyGroup('def').func.create('cs', 'Analytic');
model.component('comp1').material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive index');

model.component('comp1').cpl.create('intop1', 'Integration');
model.component('comp1').cpl.create('intop2', 'Integration');
model.component('comp1').cpl.create('intop3', 'Integration');
model.component('comp1').cpl.create('aveop1', 'Average');
model.component('comp1').cpl.create('intop4', 'Integration');
model.component('comp1').cpl.create('intop5', 'Integration');
model.component('comp1').cpl('intop1').selection.named('gap');
model.component('comp1').cpl('intop2').selection.named('mag');
model.component('comp1').cpl('intop3').selection.named('ext');
model.component('comp1').cpl('aveop1').selection.named('gap');
model.component('comp1').cpl('intop4').selection.named('gap');
model.component('comp1').cpl('intop5').selection.named('design');

model.component('comp1').physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');
model.component('comp1').physics('mfnc').create('mfc3', 'MagneticFluxConservation', 2);
model.component('comp1').physics('mfnc').feature('mfc3').selection.named('gap');
model.component('comp1').physics('mfnc').create('mfc4', 'MagneticFluxConservation', 2);
model.component('comp1').physics('mfnc').feature('mfc4').selection.named('mag');
model.component('comp1').physics('mfnc').create('mfc2', 'MagneticFluxConservation', 2);
model.component('comp1').physics('mfnc').feature('mfc2').selection.named('design');
model.component('comp1').physics('mfnc').create('zsp1', 'ZeroMagneticScalarPotential', 0);
model.component('comp1').physics('mfnc').feature('zsp1').selection.set([1]);
model.component('comp1').physics.create('sens', 'Sensitivity', 'geom1');
model.component('comp1').physics('sens').create('cvar1', 'ControlVariableField', 2);
model.component('comp1').physics('sens').feature('cvar1').selection.named('design');
model.component('comp1').physics('sens').feature('cvar1').set('fieldVariableName', 'p_aux1');
model.component('comp1').physics('sens').create('cvar2', 'ControlVariableField', 2);
model.component('comp1').physics('sens').feature('cvar2').selection.named('design');
model.component('comp1').physics('sens').feature('cvar2').set('fieldVariableName', 'p_aux2');
model.component('comp1').physics('sens').create('cvar3', 'ControlVariableField', 2);
model.component('comp1').physics('sens').feature('cvar3').selection.named('design');
model.component('comp1').physics('sens').feature('cvar3').set('fieldVariableName', 'p_aux3');
model.component('comp1').physics('sens').create('gcvar1', 'GlobalControlVariables', -1);
model.component('comp1').physics.create('sens2', 'Sensitivity', 'geom1');
model.component('comp1').physics('sens2').create('cvar1', 'ControlVariableField', 2);
model.component('comp1').physics('sens2').feature('cvar1').selection.named('design');
model.component('comp1').physics('sens2').feature('cvar1').set('fieldVariableName', 'p1');
model.component('comp1').physics('sens2').create('cvar2', 'ControlVariableField', 2);
model.component('comp1').physics('sens2').feature('cvar2').selection.named('design');
model.component('comp1').physics('sens2').feature('cvar2').set('fieldVariableName', 'p2');
model.component('comp1').physics('sens2').create('cvar3', 'ControlVariableField', 2);
model.component('comp1').physics('sens2').feature('cvar3').selection.named('design');
model.component('comp1').physics('sens2').feature('cvar3').set('fieldVariableName', 'p3');
model.component('comp1').physics('sens2').create('gcvar1', 'GlobalControlVariables', -1);
model.component('comp1').physics('sens2').create('gobj2', 'GlobalObjective', -1);
model.component('comp1').physics('sens2').create('gobj1', 'GlobalObjective', -1);
model.component('comp1').physics.create('hzeq2', 'HelmholtzEquation', 'geom1');
model.component('comp1').physics('hzeq2').field('dimensionless').field('u_br');
model.component('comp1').physics('hzeq2').selection.named('design');
model.component('comp1').physics.create('hzeq', 'HelmholtzEquation', 'geom1');
model.component('comp1').physics('hzeq').selection.named('design');

model.component('comp1').mesh('mesh1').create('ftri1', 'FreeTri');
model.component('comp1').mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').selection.named('design');

model.view('view2').axis.set('xmin', -1.4800664186477661);
model.view('view2').axis.set('xmax', 1.4800664186477661);
model.view('view3').axis.set('xmin', -1.5904254913330078);
model.view('view3').axis.set('xmax', 1.5904254913330078);
model.component('comp1').view('view4').label('View 4');
model.component('comp1').view('view4').axis.set('xmin', -1.6280730962753296);
model.component('comp1').view('view4').axis.set('xmax', 1.6280730962753296);
model.component('comp1').view('view4').axis.set('ymin', -1.100000023841858);
model.component('comp1').view('view4').axis.set('ymax', 1.100000023841858);
model.component('comp1').view('view4').axis.set('abstractviewlratio', -0.3140365481376648);
model.component('comp1').view('view4').axis.set('abstractviewrratio', 0.3140365481376648);
model.component('comp1').view('view4').axis.set('abstractviewbratio', -0.050000011920928955);
model.component('comp1').view('view4').axis.set('abstractviewtratio', 0.050000011920928955);
model.component('comp1').view('view4').axis.set('abstractviewxscale', 0.0036544851027429104);
model.component('comp1').view('view4').axis.set('abstractviewyscale', 0.0036544851027429104);

model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('emissivity', '0.5');
model.material('mat1').propertyGroup('def').set('density', '8700[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('linzRes').set('rho0', '');
model.material('mat1').propertyGroup('linzRes').set('alpha', '');
model.material('mat1').propertyGroup('linzRes').set('Tref', '');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.667e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '3.862e-3[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '293.15[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.component('comp1').material('mat2').label('Air');
model.component('comp1').material('mat2').set('family', 'air');
model.component('comp1').material('mat2').propertyGroup('def').func('eta').set('arg', 'T');
model.component('comp1').material('mat2').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.component('comp1').material('mat2').propertyGroup('def').func('Cp').set('arg', 'T');
model.component('comp1').material('mat2').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/8.314/T');
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('dermethod', 'manual');
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('argders', {'pA' 'd(pA*0.02897/8.314/T,pA)'; 'T' 'd(pA*0.02897/8.314/T,T)'});
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('plotargs', {'pA' '0' '1'; 'T' '0' '1'});
model.component('comp1').material('mat2').propertyGroup('def').func('k').set('arg', 'T');
model.component('comp1').material('mat2').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*287*T)');
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('args', {'T'});
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('dermethod', 'manual');
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('argders', {'T' 'd(sqrt(1.4*287*T),T)'});
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('plotargs', {'T' '0' '1'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat2').propertyGroup('def').set('dynamicviscosity', 'eta(T[1/K])[Pa*s]');
model.component('comp1').material('mat2').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.component('comp1').material('mat2').propertyGroup('def').set('heatcapacity', 'Cp(T[1/K])[J/(kg*K)]');
model.component('comp1').material('mat2').propertyGroup('def').set('density', 'rho(pA[1/Pa],T[1/K])[kg/m^3]');
model.component('comp1').material('mat2').propertyGroup('def').set('thermalconductivity', {'k(T[1/K])[W/(m*K)]' '0' '0' '0' 'k(T[1/K])[W/(m*K)]' '0' '0' '0' 'k(T[1/K])[W/(m*K)]'});
model.component('comp1').material('mat2').propertyGroup('def').set('soundspeed', 'cs(T[1/K])[m/s]');
model.component('comp1').material('mat2').propertyGroup('def').addInput('temperature');
model.component('comp1').material('mat2').propertyGroup('def').addInput('pressure');
model.component('comp1').material('mat2').propertyGroup('RefractiveIndex').set('n', '');
model.component('comp1').material('mat2').propertyGroup('RefractiveIndex').set('ki', '');
model.component('comp1').material('mat2').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat2').propertyGroup('RefractiveIndex').set('ki', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});

model.component('comp1').cpl('intop1').label('Integration GAP');
model.component('comp1').cpl('intop1').set('opname', 'gap');
model.component('comp1').cpl('intop2').label('Integration MAG');
model.component('comp1').cpl('intop2').set('opname', 'mag');
model.component('comp1').cpl('intop3').label('Integration EXT');
model.component('comp1').cpl('intop3').set('opname', 'ext');
model.component('comp1').cpl('aveop1').label('Av_gap');
model.component('comp1').cpl('aveop1').set('opname', 'Av_gap');
model.component('comp1').cpl('intop4').label('Integral Objective 1');
model.component('comp1').cpl('intop4').set('opname', 'iobj1');
model.component('comp1').cpl('intop5').label('Integral Constraint 1');
model.component('comp1').cpl('intop5').set('opname', 'iconst1');

model.component('comp1').physics('mfnc').feature('mfc3').set('ConstitutiveRelationH', 'RemanentFluxDensity');
model.component('comp1').physics('mfnc').feature('mfc3').set('Br', {'0'; 'Brem_virt'; '0'});
model.component('comp1').physics('mfnc').feature('mfc3').active(false);
model.component('comp1').physics('mfnc').feature('mfc3').label('Magnetic Flux Conservation  - Virtual mag');
model.component('comp1').physics('mfnc').feature('mfc4').set('ConstitutiveRelationH', 'RemanentFluxDensity');
model.component('comp1').physics('mfnc').feature('mfc4').set('Br', {'B_rem*cos(0)'; 'B_rem*sin(0)'; '0'});
model.component('comp1').physics('mfnc').feature('mfc4').set('mur', {'mu_rec'; '0'; '0'; '0'; 'mu_rec'; '0'; '0'; '0'; 'mu_rec'});
model.component('comp1').physics('mfnc').feature('mfc4').label('Magnetic Flux Conservation - Mag ');
model.component('comp1').physics('mfnc').feature('mfc2').set('ConstitutiveRelationH', 'RemanentFluxDensity');
model.component('comp1').physics('mfnc').feature('mfc2').set('Br', {'B_rem*Double_simp(Br_var,ur_var)*cos(theta_var)'; 'B_rem*Double_simp(Br_var,ur_var)*sin(theta_var)'; '0'});
model.component('comp1').physics('mfnc').feature('mfc2').set('mur', {'ur_ferro*Double_simp(Br_var,ur_var)'; '0'; '0'; '0'; 'ur_ferro*Double_simp(Br_var,ur_var)'; '0'; '0'; '0'; 'ur_ferro*Double_simp(Br_var,ur_var)'});
model.component('comp1').physics('mfnc').feature('mfc2').label('Design Region - Magnetic Flux Conservation');
model.component('comp1').physics('sens').feature('cvar1').set('shapeFunctionType', 'shdisc');
model.component('comp1').physics('sens').feature('cvar1').set('order', 0);
model.component('comp1').physics('sens').feature('cvar2').set('shapeFunctionType', 'shdisc');
model.component('comp1').physics('sens').feature('cvar2').set('order', 0);
model.component('comp1').physics('sens').feature('cvar3').set('shapeFunctionType', 'shdisc');
model.component('comp1').physics('sens').feature('cvar3').set('order', 0);
model.component('comp1').physics('sens').feature('gcvar1').set('variableList', 'aaaa');
model.component('comp1').physics('sens2').feature('cvar1').set('initialValue', 'p_aux1');
model.component('comp1').physics('sens2').feature('cvar2').set('initialValue', 'p_aux2');
model.component('comp1').physics('sens2').feature('cvar3').set('initialValue', 'p_aux3');
model.component('comp1').physics('sens2').feature('gcvar1').set('variableList', 'bbb');
model.component('comp1').physics('sens2').feature('gobj2').set('objectiveExpression', 'iconst - Const_1');
model.component('comp1').physics('sens2').feature('gobj2').label('Constraint1');
model.component('comp1').physics('sens2').feature('gobj1').set('objectiveExpression', 'iobj1');
model.component('comp1').physics('sens2').feature('gobj1').label('Objective');
model.component('comp1').physics('hzeq2').feature('heq1').set('c', {'r_filter^2' '0' '0' 'r_filter^2'});
model.component('comp1').physics('hzeq2').feature('heq1').set('a', 1);
model.component('comp1').physics('hzeq2').feature('heq1').set('f', 'p2');
model.component('comp1').physics('hzeq').feature('heq1').set('c', {'r_filter^2' '0' '0' 'r_filter^2'});
model.component('comp1').physics('hzeq').feature('heq1').set('a', 1);
model.component('comp1').physics('hzeq').feature('heq1').set('f', 'p1');

model.component('comp1').mesh('mesh1').feature('size').set('hauto', 3);
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.component('comp1').mesh('mesh1').run;

model.component('comp1').physics('mfnc').feature('mfc3').set('mur_mat', 'userdef');
model.component('comp1').physics('mfnc').feature('mfc4').set('mur_mat', 'userdef');
model.component('comp1').physics('mfnc').feature('mfc2').set('mur_mat', 'userdef');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('activate', {'mfnc' 'off' 'sens' 'on' 'sens2' 'off' 'hzeq' 'off' 'hzeq2' 'off'});
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').set('activate', {'mfnc' 'on' 'sens' 'off' 'sens2' 'on' 'hzeq' 'on'});
model.study.create('std3');
model.study('std3').create('sens', 'Sensitivity');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').set('activate', {'mfnc' 'on' 'sens' 'off' 'sens2' 'on' 'hzeq' 'on'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').attach('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').attach('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').create('sn1', 'Sensitivity');
model.sol('sol3').feature('s1').feature.remove('fcDef');

model.study('std1').feature('stat').set('usesol', true);
model.study('std3').feature('sens').set('gradientStep', 'stat');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').label('Dependent Variables 1.1');
model.sol('sol1').feature('s1').active(false);
model.sol('sol2').attach('std2');
model.sol('sol2').feature('v1').label('Dependent Variables 1.1');
model.sol('sol2').feature('v1').set('control', 'user');
model.sol('sol2').feature('v1').set('initsol', 'sol1');
model.sol('sol2').feature('v1').set('solnum', 'auto');
model.sol('sol2').feature('v1').set('notsolmethod', 'sol');
model.sol('sol2').feature('v1').set('notsol', 'sol1');
model.sol('sol2').feature('v1').set('notsolnum', 'auto');
model.sol('sol2').feature('v1').feature('comp1_gcvar11').set('scalemethod', 'none');
model.sol('sol2').feature('v1').feature('comp1_gcvar12').set('scalemethod', 'none');
model.sol('sol2').feature('s1').label('Stationary Solver 1.1');
model.sol('sol2').feature('s1').feature('dDef').label('Direct 1');
model.sol('sol2').feature('s1').feature('aDef').label('Advanced 1');
model.sol('sol2').feature('s1').feature('fc1').label('Fully Coupled 1.1');
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 150);
model.sol('sol3').attach('std3');
model.sol('sol3').feature('s1').feature('sn1').set('sensfunc', 'comp1.sens2.iobj2');

out = model;
