%min z = 2x1 + x2

% 3x1 + x2 >= 3
% 4x1 + 3x2 >= 6
% x1 + x2 >=3
% x1,x2 >= 0

% for dual simplex method sign should be <= , so multiply coefficients with
% -1 and also maximize the z
clc
clear all
A = [-3 -1 1 0 0 ; -4 -3 0 1 0 ; -1 -1 0 0 1];
B = [-3 ; -6 ; -3];
C = [-2 -1 0 0 0];
Y = [A B];
b_index = [3 4 5];

m = size(A, 1); % no of rows
n = size(A, 2); % no of cols


for s = 1 : 100
    cb = C(b_index);
    xb = Y(:, end);
    z = cb * xb
    zjcj = cb * Y(:, 1 : n) - C;

    if zjcj < 0
        disp("Not Optimal");
        break
    else
        disp("Optimality Achieved");
        if xb >= 0
            disp("Feasible Solution");
            break
        else
            [a, LV] = min(xb);

            for i = 1 : n
                if Y(LV, i) < 0
                    ratio(i) = abs(zjcj(i) / Y(LV, i));
                else
                    ratio(i) = inf;
                end
            end
        end

        [b, EV] = min(ratio);
        b_index(LV) = EV;
    end

    pivot = Y(LV, EV);
    Y(LV, :) = Y(LV, :) / pivot;

    for i = 1 : m
        if i ~= LV
            Y(i, :) = Y(i, :) - (Y(i, EV) * Y(LV, :));
        end
    end
end

solution = zeros(n, 1);
solution(b_index) = Y(:, end);

disp('Optimal values of variables (including slack variables):');
disp(solution);

Zmin = C * solution;
fprintf('Minimum value of Z = %f\n',Zmin);