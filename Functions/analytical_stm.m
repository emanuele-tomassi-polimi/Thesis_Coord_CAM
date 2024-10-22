function [X,V,P]=analytical_stm(X0,V0,T,mu)
% INPUT POSITION, VELOCITY, TOF, MU
% OUTPUT POSITION, VELOCITY, STM
r0=norm(X0);
v0=dot(X0,V0);
beta=2*mu/r0-dot(V0,V0);

% initialize:
u=0;
DU=0;

% correction for periodic orbits
if beta>0
    P=2*pi*mu*beta^(-3/2);
    n=floor(1/P*(T+P/2-2*v0/beta));
    DU=2*n*pi*beta^(-5/2);
    
end




continue_loop=1;
toll=1e-12;
loop_n=0;

while continue_loop
    q=(beta*u^2)/(1+beta*u^2);
    U0_w2=1-2*q;
    U1_w2=2*(1-q)*u;
    U=16/15*U1_w2^5*G_gen(5,0,5/2,q) + DU;
    U0=2*U0_w2^2-1;
    U1=2*U0_w2*U1_w2;
    U2=2*U1_w2^2;
    U3=beta*U+(1/3)*U1*U2;
    r=r0*U0+v0*U1+mu*U2;
    t=r0*U1+v0*U2+mu*U3;
    u_new=u-(t-T)/(4*(1-q)*r);
    loop_n=loop_n+1;
    
    if norm((u-u_new)/u_new)<toll || loop_n>100
        continue_loop=0;
    end
    
    u=u_new;
    
end

% Kepler Solution:
f=1-(mu/r0)*U2;
g=r0*U1+v0*U2;
F=-mu*U1/(r*r0);
G=1-(mu/r)*U2;

X=f*X0+g*V0;
V=F*X0+G*V0;

% Transition Matrix:
W=g*U2+3*mu*U;
M=[(U0/(r*r0)+1/r0^2+1/r^2)*F-mu/r^3*mu/r0^3*W, (F*U1)/r+(G-1)/r^2, (G-1)*U1/r-mu/r^3*W;...
    -(F*U1)/r0-(f-1)/r0^2, -F*U2, -(G-1)*U2;...
    (f-1)*U1/r0-mu/r0^3*W, (f-1)*U2, g*U2-W];


P_11=f*eye(3)+[X,V]*[M(2,1),M(2,2);...
                     M(3,1),M(3,2)]*[X0,V0]';
                 
P_12=g*eye(3)+[X,V]*[M(2,2),M(2,3);...
                     M(3,2),M(3,3)]*[X0,V0]';
                 
P_21=F*eye(3)-[X,V]*[M(1,1),M(1,2);...
                     M(2,1),M(2,2)]*[X0,V0]';
                 
P_22=G*eye(3)-[X,V]*[M(1,2),M(1,3);...
                     M(2,2),M(2,3)]*[X0,V0]';


P=[P_11,P_12;P_21,P_22];


end

%%

function [G]=G_gen(a,b,c,x)

k=1-2*(a-b);
l=2*(c-1);
d=4*c*(c-1);
n=4*b*(c-a);

A=1; B=1; G=1;



toll=1e-12;

continue_loop=1;
loop_n=0;
while continue_loop
    k=-k;
    l=l+2;
    d=d+4*l;
    n=n+(1+k)*l;
    A=d/(d-n*A*x);
    B=(A-1)*B;
    G_new=G+B;
    loop_n=loop_n+1;
    
    if norm((G-G_new)/G_new)<toll || loop_n>100
        continue_loop=0;
    end
    
    G=G_new;
end

end




%% G SPECIFIC FOR 1 CHOICE OF PARAMS

function [G]=G_5(q)
k=-9; l=3; d=15; n=0; A=1; B=1; G=1;


toll=1e-12;

continue_loop=1;
loop_n=0;
while continue_loop
    k=-k;
    l=l+2;
    d=d+4*l;
    n=n+(1+k)*l;
    A=d/(d-n*A*q);
    B=(A-1)*B;
    G_new=G+B;
    loop_n=loop_n+1;
    
    if norm((G-G_new)/G_new)<toll || loop_n>100
        continue_loop=0;
    end
    
    G=G_new;
end

end