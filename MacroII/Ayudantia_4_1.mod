// Ayudantía 4: The basic New Keynesian model

//------------------------------------------
//
//Preamble
//------------------------------------------


// Variables
var pi, y_gap, rn, i, a, v; 
varexo eps_v eps_a;
//
// Parameters
parameters beta, alpha, epsilon, sigma, rho, phi_pi, theta, phi_y, PSI_yan, THETA, lambda, kappa, rho_v, rho_a, phi, mu, eta , vartheta_yn;
beta = 0.99;
alpha = 1/3;
epsilon = 6;
sigma= 1
theta = 0.6666666666666666;
phi=1 ;
phi_pi = 1.5; 
phi_y = 0.5/4;
PSI_yan = (1+phi)/(sigma*(1-alpha)+phi+alpha);
THETA = (1-alpha)/(1-alpha+alpha*epsilon);
lambda = (1-theta)*(1-beta*theta)*THETA/theta;
kappa = lambda*(sigma+(phi+alpha)/(1-alpha));
rho = 1/beta-1;
rho_v = 0; 
rho_a = 0; 
eta = 4
mu= log(epsilon/(epsilon-1))
vartheta_yn = -((1-alpha)*(mu-log(1-alpha)))/(sigma*(1-alpha)+phi+alpha) 

// end
//------------------------------------------
//
//Model
//------------------------------------------

model;

//1. New Keynesian Phillips Curve (21) 
pi = beta*pi(+1)+kappa*y_gap; 

//2. Dynamic IS Curve eq. (22) 
y_gap = y_gap(+1)-1/sigma*(i-pi(+1)-rn); // y_gap is output gap (22) 

//3. Taylor-Rule 
i = rho+phi_pi*pi+phi_y*y_gap+v; 

//4. natural rate of interest (23) 
rn=rho+sigma*PSI_yan*(a(+1)-a); 

i = rho+phi_pi*pi+phi_y*y_gap +v; 
v = rho_v*v(-1) + eps_v; // shock to i (bottom p. 50)

//6. TFP shock 
a = rho_a*a(-1) + eps_a; // technology shock (28)

//7.- Tasa real
r=i-pi(+1)

//8. Produccion
y = a +(1-alpha)*n

//9. Producto natural
ynat= Psi_yan*a + vartheta_yn

//10. brecha de producto
ygap=y-ynat

//11. Money Growth
mgrowth = 4*(y-y(-1)-eta*(i-i(-1))+pi-pi(-1)) $

//12
mr = 4*(y-eta*i)

//13.i anual
iann=4*i

//14.r anual
rann_t=4*rreal

//15.pi anual
piann=4*pi

end;
//

////////// steady states: all 0 due to linear model //////////
initval;
pi=0;
y_gap=0;
i=0;
rn=0; 
a=0;
v=0;
end;


vcov = [0.0625 0 ;
0 1];
