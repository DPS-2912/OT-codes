clc 
clear all 
A=[1 1 ; 2 1 ; 1 0 ; 0 1];
B=[40;60;0;0];
C=[8 1];

x1 = 0:0.1:max(B);

for i=1:4
    x2=(B(i)-(x1*A(i,1)))/A(i,2);
    x2=max(0,x2);
    plot(x1,x2);
    hold on
end

sol=[];
for i=1:4
    A1=A(i,:);
    B1=B(i);
    for j=i+1:4
        A2=A(j,:);
        B2=B(j);

        A3=[A1;A2];
        B3=[B1;B2];
        x=inv(A3)*B3;
        sol=[sol,x];
    end
end

sol;

pts=sol';
x=pts(:,1);
y=pts(:,2);

H1=find(x+y-40>0);
pts(H1,:)=[];

x=pts(:,1);
y=pts(:,2);
H2=find(2*x+y-60>0);
pts(H2,:)=[];

x=pts(:,1);
y=pts(:,2);
H3=find(x<0);
pts(H3,:)=[];

x=pts(:,1);
y=pts(:,2);
H4=find(y<0);
pts(H4,:)=[];

k=pts;
output=[];
for i=1:size(k,1)
    x=sum(k(i,:)*C');
    output=[output,x];
end

max(output)