%% Steepest Descent Method
clc
clear all

f = @(x,y) 3*x^2+4*x*y+2*y^2+4*x+6;
a = 0 ;
b = 0 ;
grad = @(x,y) [6*x+4*y+4 , 4*x+4*y];
tol = 0.001;

%% if tolerance given
while norm(grad(a,b)) > tol
    d = -grad(a,b)/norm(grad(a,b));
    f1 = @(z) 3*(a+z*d(1))^2+4*(a+z*d(1))*(b+z*d(2))+2*(b+z*d(2))^2+4*(a+z*d(1))+6;
    z = fminbnd(f1,0,10000);
    a=a+z*d(1);
    b=b+z*d(2);
    f(a,b);
end
a 
b
f(a,b)

%% if iterations given

%for i=1:4
%    d = -grad(a,b)/norm(grad(a,b));
%    f1 = @(z) 3*(a+z*d(1))^2+4*(a+z*d(1))*(b+z*d(2))+2*(b+z*d(2))^2+4*(a+z*d(1))+6;
%    z = fminbnd(f1,0,10000);
%    a=a+z*d(1);
%    b=b+z*d(2);
%    f(a,b)
%end