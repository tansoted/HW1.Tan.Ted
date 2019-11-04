% Figure Michell Toplogy of Order 4 (phi = pi/8, beta = pi/6£©
% By Ted Tan
% Order: q = 4; l = 0:q
clear all; clf; figure(1);

phi = pi/8;
beta = pi/6;
a = sin(beta)/sin(beta+phi); c = sin(phi)/sin(beta+phi);
r(:,1) = 1;
order = 4;
for i = 1:order;
    r(:,i+1) = a*r(:,i);
end
for i = 1:order;
    p(:,i) =c*r(:,i);
end

% Fixed nodes P_i
P(:,1) = [0;-r(:,order+1)];
P(:,2) = [cos(2*phi)*r(:,order+1);-sin(2*phi)*r(:,order+1)];
P(:,3) = [r(:,order+1);0];
P(:,4) = [cos(2*phi)*r(:,order+1);sin(2*phi)*r(:,order+1)];
P(:,5) = [0;r(:,order+1)];

% Free nodes Q_i
Q(:,1) = r(:,order)*[sin(phi);-cos(phi)];
Q(:,2) = r(:,order)*[cos(phi);-sin(phi)];
Q(:,3) = r(:,order)*[cos(phi); sin(phi)];
Q(:,4) = r(:,order)*[sin(phi); cos(phi)];
Q(:,5) = r(:,order-1)*[sin(2*phi);-cos(2*phi)];
Q(:,6) = r(:,order-1)*[1;0];
Q(:,7) = r(:,order-1)*[cos(2*phi); sin(2*phi)];
Q(:,8) = r(:,order-2)*[cos(phi);-sin(phi)];
Q(:,9) = r(:,order-2)*[cos(phi); sin(phi)];
Q(:,10) = r(:,order-3)*[1;0];
[dim,q] = size(Q), p = size(P,2), n = q+p; 

% Connectivity matrix
C(1,1) = 1; C(1,11) = -1; %bar
C(2,5) = 1; C(2,1) = -1;
C(3,8) = 1; C(3,5) = -1;
C(4,10) = 1; C(4,8) = -1;
C(5,2) = 1; C(5,12) = -1;
C(6,6) = 1; C(6,2) = -1;
C(7,9) = 1; C(7,6) = -1;
C(8,3) = 1; C(8,13) = -1;
C(9,7) = 1; C(9,3) = -1;
C(10,4) = 1; C(10,14) = -1; 
b = 10;

C(b+1,1) = 1; C(b+1,12) = -1; %string
C(b+2,5) = 1; C(b+2,2) = -1;
C(b+3,8) = 1; C(b+3,6) = -1;
C(b+4,10) = 1; C(b+4,9) = -1;
C(b+5,2) = 1; C(b+5,13) = -1;
C(b+6,6) = 1; C(b+6,3) = -1;
C(b+7,9) = 1; C(b+7,7) = -1;
C(b+8,3) = 1; C(b+8,14) = -1;
C(b+9,7) = 1; C(b+9,4) = -1;
C(b+10,4) = 1; C(b+10,15) = -1; 
s = 10;
m = b+s;
% Applied external force U=U_(dim x q)
U(1:dim,1:10)=0; U(2,10) = -1;

% Solve for the forces at equilibrium, and plot
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,1.0); grid on;



