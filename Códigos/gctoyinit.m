
%*** INPUT:
%
%   m    = The number of general constraints.
%   n    = The number of variables x_j.
%  iter  = Current iteration number ( =1 the first time mmasub is called).
%  xval  = Column vector with the current values of the variables x_j.
%  xmin  = Column vector with the lower bounds for the variables x_j.
%  xmax  = Column vector with the upper bounds for the variables x_j.
%  xold1 = xval, one iteration ago (provided that iter>1).
%  xold2 = xval, two iterations ago (provided that iter>2).
%  f0val = The value of the objective function f_0 at xval.
%  df0dx = Column vector with the derivatives of the objective function
%          f_0 with respect to the variables x_j, calculated at xval.
%  fval  = Column vector with the values of the constraint functions f_i,
%          calculated at xval.
%  dfdx  = (m x n)-matrix with the derivatives of the constraint functions
%          f_i with respect to the variables x_j, calculated at xval.
%          dfdx(i,j) = the derivative of f_i with respect to x_j.
%  low   = Column vector with the lower asymptotes from the previous
%          iteration (provided that iter>1).
%  upp   = Column vector with the upper asymptotes from the previous
%          iteration (provided that iter>1).
%  a0    = The constants a_0 in the term a_0*z.
%  a     = Column vector with the constants a_i in the terms a_i*z.
%  c     = Column vector with the constants c_i in the terms c_i*y_i.
%  d     = Column vector with the constants d_i in the terms 0.5*d_i*(y_i)^2.
%     
%*** OUTPUT:
%
%  xmma  = Column vector with the optimal values of the variables x_j
%          in the current MMA subproblem.
%  ymma  = Column vector with the optimal values of the variables y_i
%          in the current MMA subproblem.
%  zmma  = Scalar with the optimal value of the variable z
%          in the current MMA subproblem.
%  lam   = Lagrange multipliers for the m general MMA constraints.
%  xsi   = Lagrange multipliers for the n constraints alfa_j - x_j <= 0.
%  eta   = Lagrange multipliers for the n constraints x_j - beta_j <= 0.
%   mu   = Lagrange multipliers for the m constraints -y_i <= 0.
%  zet   = Lagrange multiplier for the single constraint -z <= 0.
%   s    = Slack variables for the m general MMA constraints.
%  low   = Column vector with the lower asymptotes, calculated and used
%          in the current MMA subproblem.
%  upp   = Column vector with the upper asymptotes, calculated and used
%          in the current MMA subproblem.
%
%epsimin = sqrt(m+n)*10^(-9);


n_blocks = 0; %numero de blocos, de forma a criar blocos com par�metros de aloca��o a serem utilizados. M�todo em conjunto com m�todo da densidade n�o se mostra muito bom. Cria 3 vari�veis por bloco.
n_vars_densidade = 1; %numero de vari�veis do m�todo da densidade. Se =0, n�o � feita otimiza��o de nenhum material. Se igual a 1, tem-se como padr�o o ferro, e se igual a 3 tem-se como padr�o ferro e �m� (com m�dulo e �ngulo). Se maior que 2, deve ser feito manualmente.
n_vars_global = 0; %numero de par�metros a serem otimizados. 
n_constraints = 1;


beta = 8; %projection constant
p_simp = 3; %density interpolation constant
r_filter_ur = 5E-3; %helmhotz filter radius (can get in function of h)
r_filter_Br = 0;

n = len_p + 3*n_blocks;

epsimin = 0.0000001;
xval    = (0.25)*ones(len_p,1);
xold1   = xval;
xold2   = xval;
xmin    =  zeros(len_p,1);%[(-0.2)  0.07  -pi/2 (-0.2) 0.07 -pi/2]';
xmax    =  ones(len_p,1);%[0.3  0.3  pi/2 0.3 0.3 pi/2]';
low     = xmin;
upp     = xmax;
c       = 1000*ones(m,1);%[1000  1000]';
d       = ones(m,1);%[1  1]';
a0      = 1;
a       = zeros(m,1);%[0  0]';
raa0    = 0.01;
raa     = 0.01*ones(m,1);%[1  1]';
raa0eps = 0.000001;
raaeps  = 0.000001*ones(m,1);%[1  1]';
outeriter = 0;
maxoutit  = 100;
minoutit = 15;
kkttol  = 1E-4;
%
%---------------------------------------------------------------------
