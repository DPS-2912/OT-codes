clc
clear all

C = [1 2 3 0 0];
A = [1 2 0 1 0; 3 0 4 0 1];
B = [20; 30];

m = size(A, 1); % no of rows = 2
n = size(A, 2); % no of cols = 5

b_index = n - m + 1 : n; % 5-2+1 : 5 -> 4 : 5
Y = [A, B];

for s = 1 : 100
    cb = C(b_index);
    xb = Y(:, end);
    z = cb * xb
    zjcj = cb * Y(:, 1 : n) - C;
    
    if zjcj >= 0
        disp("Required Solution");
        break;
    else
        [u, EV] = min(zjcj);
        if (Y(:, EV)) < 0
            disp("Unbounded Solution");
        else
            for i = 1 : m
                if Y(i, EV) > 0
                    ratio(i) = xb(i) / Y(i, EV);
                else
                    ratio(i) = 10000;
                end
            end
        end
        
        [b, LV] = min(ratio);
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