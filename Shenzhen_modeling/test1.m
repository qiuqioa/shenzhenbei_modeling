% 生成5x4的随机矩阵
time_reached= rand(5, 4);
time_reached_combination1=generate_all_combinations(time_reached);

function all_combinations = generate_all_combinations(matrix)
    % 获取矩阵的行数
    n = size(matrix, 1);
    
    % 初始化存储所有组合的矩阵
    all_combinations = [];
    
    % 对于每一行，生成所有可能的组合
    for i = 1:n
        row_combinations = generate_row_combinations(matrix(i, :));
        all_combinations = [all_combinations; row_combinations];
    end
end

% 生成一行的所有组合
function row_combinations = generate_row_combinations(row)
    % 获取行的长度
    len = length(row);
    
    % 初始化存储组合的矩阵
    row_combinations = zeros(len, len);
    
    % 生成所有可能的组合
    for i = 1:len
        combination = zeros(1, len);
        combination(i) = row(i);
        row_combinations(i, :) = combination;
    end
end




    