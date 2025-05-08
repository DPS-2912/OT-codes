%% Least cost method
clc
clear all 

cost = [11 13 17 14 ; 16 18 14 10 ; 21 24 13 10]
supply = [10  5  9]
demand = [8 7 5 4]


[m,n] = size(cost);

% check balanced
a = sum(supply);
b = sum(demand);

if a==b
    fprintf('Problem Balanced\n');
elseif a>b   
    cost(:,end+1) = zeros(1,m);
    demand(end+1) = a-b;
else
    cost(end+1,:) = zeros(n,1);
    supply(end+1) = b-a;
end

[m,n] = size(cost);
zero_matrix = zeros(m,n); % zero matrix of updated size

least = cost;  %discarding cost elements to infinity...required original
              %cost at end while multiplication so copy made

while any(supply~=0) || any(demand~=0)
    cost
    minval = min(cost(:));   % (:) to get overall minimum
    [r,c] = find(cost == minval);
    y = min(supply(r),demand(c));
    [aloc , index] = max(y);
    rr = r(index);
    cc = c(index);

    %update demand and supply
    supply(rr) = supply(rr) - aloc ;
    demand(cc) = demand(cc) - aloc ;
    zero_matrix(rr,cc) = aloc ;
    %discard min val
    cost(rr,cc) = inf ;
end

zero_matrix
%check generate and degenrate 
% if allocations = n+m-1 then non degenerate

if nnz(zero_matrix) == m+n-1 
    disp("Non degenerate");
else
    disp("Degenrate");
end
output = least.*zero_matrix
finaloutput = sum(output(:))
