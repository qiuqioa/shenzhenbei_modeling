observed_points = [
    110.241*97.304, 27.204*111.263, 0.824;
    110.780*97.304, 27.456*111.263, 0.727;
    110.712*97.304, 27.785*111.263, 0.742;
    110.251*97.304, 27.825*111.263, 0.850;
    110.524*97.304, 27.617*111.263, 0.786;
    110.467*97.304, 27.921*111.263, 0.678;
    110.047*97.304, 27.121*111.263, 0.575
];


%生成随机的排列组合方式

time_reached_combinations_1=time_reached_combinations(1:4096,:);
time_reached_combinations_2=time_reached_combinations(4097:8192,:);
time_reached_combinations_3=time_reached_combinations(8193:12288,:);
time_reached_combinations_4=time_reached_combinations(12289:16384,:);
%对于第一个残骸进行排序寻找
RSS_matrix_1=zeros(size(time_reached_combinations_1,1),1);

for num=1:size(time_reached_combinations_1,1)
    reached_times=time_reached_combinations_1(num,:)';
    RSS_matrix_1(num,1)=RSS_mat(observed_points,reached_times);
end

[min_val_1,min_idx_1]=min(RSS_matrix_1);
right_combination_1=time_reached_combinations_1(min_idx_1,:);


%对0....于第二个残骸进行排序寻找
RSS_matrix_2=zeros(size(time_reached_combinations_2,1),1);

for num=1:size(time_reached_combinations_2,1)
    reached_times=time_reached_combinations_2(num,:)';
    RSS_matrix_2(num,1)=RSS_mat(observed_points,reached_times);
end

[min_val_2,min_idx_2]=min(RSS_matrix_2);
right_combination_2=time_reached_combinations_2(min_idx_2,:);

%对于第三个残骸进行排序寻找
RSS_matrix_3=zeros(size(time_reached_combinations_3,1),1);

for num=1:size(time_reached_combinations_3,1)
    reached_times=time_reached_combinations_3(num,:)';
    RSS_matrix_3(num,1)=RSS_mat(observed_points,reached_times);
end

[min_val_3,min_idx_3]=min(RSS_matrix_3);
right_combination_3=time_reached_combinations_3(min_idx_3,:);


%对于第四个残骸进行排序寻找
RSS_matrix_4=zeros(size(time_reached_combinations_4,1),1);

for num=1:size(time_reached_combinations_4,1)
    reached_times=time_reached_combinations_4(num,:)';
    RSS_matrix_4(num,1)=RSS_mat(observed_points,reached_times);
end

[min_val_4,min_idx_4]=min(RSS_matrix_4);
right_combination_4=time_reached_combinations_4(min_idx_4,:);



function RSS=RSS_mat(observed_points,reached_time)

distances=reached_time.*0.340;
% 定义目标函数
fun = @(x) sum((sqrt(sum((observed_points - x(1:3)).^2, 2)) - distances).^2);

% 设置遗传算法的参数
options = optimoptions('ga', 'Display', 'iter');
options.MaxGenerations=500;

% 设置参数的上下界
lb = [10636.1540; 2927.1230; 0]; % 下界
ub = [10817.6260; 3108.0030; 100.0]; % 上界

% 使用遗传算法求解最小化问题
format long;
[x_opt, ~, ~, ~] = ga(fun, 3, [], [], [], [], lb, ub, [], options);
RSS= fun(x_opt);
end



