clc
clear all;

A = [2 3 -1 4 ; 1 -2 6 -7];
B = [8 ; -3];
C = [2 3 4 7];

m = size(A,1);
n = size(A,2);
ad=A(:,pairs(i,:))

ncm = nchoosek(n,m);

pairs = nchoosek(1:n,m);
bfs=[];

for i=1:ncm 
    y = zeros(n,1);
    ad = A(:,pairs(i,:));
    x = inv(ad)*B;

    if (x>=0 & x~=inf) 
        y(pairs(i,:)) = x;
        bfs = [bfs,y];
    end
end
bfs

Z = @(X)C*X;
cost = Z(bfs);


[z_max,z_index]=max(cost);
point=bfs(:,z_index);
z_max
z_index
point
