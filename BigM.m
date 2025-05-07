clc
clear all
M=1000;
A=[3, 4, 1, 0, 0 ;   1, 3, 0, -1, 1 ] ;
B=[6 ; 2];
C=[1 , 5 , 0 , 0 , -M] ;
Y=[A B];

%% To find the starting BFS
s=eye(size(A,1));
b_index=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            b_index=[b_index i];
        end
    end
end
b_index

m = size(A, 1); % no of rows
n = size(A, 2); % no of cols

for s = 1 : 100
    Y
    cb = C(b_index);
    xb = Y(:, end);
    z = cb * xb;
    zjcj = cb * Y(:, 1 : n) - C;
    

    if zjcj >= 0
        fprintf("\n============OPTIMALITY ACHIEVED============\n")
        break
    else
        [Entval,pvt_col] = min(zjcj);
        Column=Y(:,pvt_col);
        if all(Column<=0)
            fprintf('LPP has unbounded solution')
            break
        else
            for i=1:size(Column,1)
                if Column(i)>0
                    ratio(i)=xb(i)./Column(i);
                else
                    ratio(i) = inf ;
                end
            end
            [minRatio, pvt_row]=min(ratio);
            fprintf('Entering col is %d \n', pvt_col)
            fprintf('Leaving Row is %d \n', pvt_row)

        end
        pvt_ele = Y(pvt_row,pvt_col)
        fprintf('\n============Updation============\n')
        b_index(pvt_row) = pvt_col
        
        Y(pvt_row,:)=Y(pvt_row,:)/pvt_ele;
        for i=1:size(Y,1)
            if i~=pvt_row
                Y(i,:)=Y(i,:)-Y(i,pvt_col)*Y(pvt_row,:);
            end
        end
    end
end
solution = zeros(n, 1);
solution(b_index) = Y(:, end)
Zmax = C * solution;
fprintf('Maximum value of Z = %f\n',Zmax);
