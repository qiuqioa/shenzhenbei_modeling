
time_reached= rand(5, 4);
time_reached_combinations2=generate_combinations(time_reached);

function combinations = generate_combinations(matrix)
    % 获取矩阵的行数和列数
    [nx, ny] = size(matrix);
    
    % 对于每一行，将元素进行排序
    sorted_rows = cell(nx, 1);
    for i = 1:nx
        sorted_rows{i} = sort(matrix(i, :));
    end
    
    % 递归生成所有组合
    combinations = {};
    generate_combinations_recursive(sorted_rows, 1, nx, [], combinations);
end

function generate_combinations_recursive(sorted_rows, idx, nx, current_combination, all_combinations)
    % 当前行的排序后的元素数组
    current_row = sorted_rows{idx};
    
    % 递归终止条件：已经遍历到了最后一行
    if idx > nx
        all_combinations{end + 1} = current_combination;
        return;
    end
    
    % 遍历当前行的所有元素
    for i = 1:length(current_row)
        % 检查当前元素是否已经存在于当前组合中，若存在则跳过
        if any(current_row(i) == current_combination)
            continue;
        end
        
        % 生成新的组合
        new_combination = [current_combination, current_row(i)];
        
        % 递归调用生成下一行的组合
        generate_combinations_recursive(sorted_rows, idx + 1, nx, new_combination, all_combinations);
    end
end
