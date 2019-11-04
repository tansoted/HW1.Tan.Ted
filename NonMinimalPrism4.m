% Non minimal tensigrity prism with 4 bar in Figure 3.43
% Ted Tan
clear; clf; figure(1);
% In non minimal prims, alpha is in the in the interval of [pi/2-pi/p,
% pi/2]; where p is the num of bars
alpha = input('Input a twist angle:\n'); 
bar = 4;
height = input('Input the height of the stucture:\n');
while alpha < (pi/2-pi/4) || alpha > (pi/2)
    disp('ERROR!!!');
    disp('In non minimal prims, alpha is in the in the interval of [pi/4, pi/2]')
    alpha = input('Input a twist angle:\n'); 
end
Q(:,1) = [0;0;0];
Q(:,2) = [1;0;0];
Q(:,3) = [1;1;0]; 
Q(:,4) = [0;1;0]; 
q0 = [1/2;1/2;height]; % Middle Point 
% height = 1
Rotate = [cos(alpha) -sin(alpha);sin(alpha) cos(alpha);0 0];
for i = 5:8
    Q(:,i) = [(Q(:,i-4)-q0)'*Rotate(:,1)+q0(1);(Q(:,i-4)-q0)'*Rotate(:,2)+q0(2);height];
end
P = [];
[dim,q]=size(Q); p=size(P,2); n=q+p; 

% Connectivity matrix
C(1,1) = 1; C(1,8) = -1;       % bars 
C(2,2) = 1; C(2,5) = -1;
C(3,3) = 1; C(3,6) = -1;
C(4,4) = 1; C(4,7) = -1; 
b = 4;
C(b+1,1) = 1; C(b+1,2) = -1;       % strings 
C(b+2,2) = 1; C(b+2,3) = -1;    
C(b+3,3) = 1; C(b+3,4) = -1;    
C(b+4,4) = 1; C(b+4,1) = -1;    
C(b+5,5) = 1; C(b+5,6) = -1;    
C(b+6,6) = 1; C(b+6,7) = -1;    
C(b+7,7) = 1; C(b+7,8) = -1;    
C(b+8,8) = 1; C(b+8,5) = -1;    
C(b+9,1) = 1; C(b+9,5) = -1; 
C(b+10,2) = 1; C(b+10,6) = -1; 
C(b+11,3) = 1; C(b+11,7) = -1; 
C(b+12,4) = 1; C(b+12,8) = -1; 
C(b+13,1) = 1; C(b+13,6) = -1; 
C(b+14,2) = 1; C(b+14,7) = -1; 
C(b+15,3) = 1; C(b+15,8) = -1; 
C(b+16,4) = 1; C(b+16,5) = -1; 
s=16; m=b+s;

% Applied external force U=U_(dim x q)
U(1:dim,1:8) = 0; 
U(3,1) = 1; U(3,2) = 1; U(3,3) = 1; U(3,4) = 1;
U(3,5) = -1; U(3,6) = -1; U(3,7) = -1; U(3,8) = -1;
% % Solve for the forces at equilibrium, and plot
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,1.0); grid on;
