%% Task 1: Optimum point

nshifts = 6; % Number of shifts in a 24-hours period = worker groups
u = 1; % 8-hours salary unit (day-shift)

% Objective function in the form z = c'x:
c = u*[1 1 1 1.5 2 1.5]';

% Constraints in the form Ax >= b:
b = [700 500 600 300 100 50]';
A = eye(nshifts); 
for row = nshifts:-1:1
    if row == 1
        A(1,nshifts) = 1;
        break;
    end
    A(row,row - 1) = 1;
end

% Boundary constraints in the form lb <= x <= ub
lb = zeros(nshifts,1)'; 

options = optimoptions('linprog','Algorithm','dual-simplex','Diagnostics','on','Display','iter');
[x,fval,exitflag,output,lambda] = linprog(c, -A, -b, [], [], lb, [], options);

%% Task 2: Modifying constraints

b = [700 250 600 300 100 50]'; % Reduced number (half) of workers in the second shift period by half
[x,fval,exitflag,output,lambda] = linprog(c, -A, -b, [], [], lb, [], options);

%% Task 3: Using Interior-Point algorithm instead of Dual-Simplex

b = [700 500 600 300 100 50]';
options = optimoptions('linprog','Algorithm','interior-point','Diagnostics','on','Display','iter');
[x,fval,exitflag,output,lambda] = linprog(c, -A, -b, [], [], lb,[], options);