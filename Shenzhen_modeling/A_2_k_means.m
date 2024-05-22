% 设备坐标和音爆时间数据
data = [
    110.241*97.304, 27.204*111.263, 0.824, 100.767, 164.229, 214.850, 270.065;
    110.780*97.304, 27.456*111.263, 0.727, 92.453, 112.220, 169.362, 196.583;
    110.712*97.304, 27.785*111.263, 0.742, 75.560, 110.696, 156.936, 188.020;
    110.251*97.304, 27.825*111.263, 0.850, 94.653, 141.409, 196.517, 258.985;
    110.524*97.304, 27.617*111.263, 0.786, 78.600, 86.216, 118.443, 126.669;
    110.467*97.304, 27.921*111.263, 0.678, 67.274, 166.270, 175.482, 266.871;
    110.047*97.304, 27.121*111.263, 0.575, 103.738, 163.024, 206.789, 210.306
];

% 声波传播速度
v = 0.340;

% 获取所有音爆时间
all_times = data(:, 4:end);

% 将所有时间展开成一维数组并对应到设备
times_vector = all_times(:);
device_indices = repmat((1:size(data, 1))', [1, size(all_times, 2)])';
device_indices = device_indices(:);

% 运行 K-means 聚类
k = 4;  % 残骸数量
[idx, C] = kmeans(times_vector, k);

% 将聚类结果还原成原始矩阵的形式
time_clusters = reshape(idx, size(all_times));
centroids = reshape(C, [1, k]);

% 初始猜测
initial_guess = [
    mean(data(:, 1)), mean(data(:, 1)), mean(data(:, 1)), mean(data(:, 1)), ... % 经度初始猜测
    mean(data(:, 2)), mean(data(:, 2)), mean(data(:, 2)), mean(data(:, 2)), ... % 纬度初始猜测
    mean(data(:, 3)), mean(data(:, 3)), mean(data(:, 3)), mean(data(:, 3)), ... % 高程初始猜测
    mean(data(:, 4)), mean(data(:, 4)), mean(data(:, 4)), mean(data(:, 4))  ... % 音爆时间初始猜测
];

% 设置优化选项
options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'Display', 'iter');

% 优化
[optimal_params, fval] = fminunc(@(params)objective(params, data, v, time_clusters), initial_guess, options);

% 解析结果
format long
x_k = optimal_params(1:4);
y_k = optimal_params(5:8);
z_k = optimal_params(9:12);
t_k = optimal_params(13:16);

% 输出结果
disp('残骸位置 (经度):'); disp(x_k/97.304);
disp('残骸位置 (纬度):'); disp(y_k/111.263);
disp('残骸位置 (高程):'); disp(z_k*1000);
disp('音爆时间:'); disp(t_k);



function total_error = objective(params, data, v, cluster_assignments)
    % 分解参数
    x_k = params(1:4);    % 4个残骸的经度
    y_k = params(5:8);    % 4个残骸的纬度
    z_k = params(9:12);   % 4个残骸的高程
    t_k = params(13:16);  % 4个残骸的音爆时间
    
    total_error = 0;
    for i = 1:size(data, 1)
        x_i = data(i, 1);    % 第i个设备的经度
        y_i = data(i, 2);    % 第i个设备的纬度
        z_i = data(i, 3);    % 第i个设备的高程
        t_ij = data(i, 4:end);  % 第i个设备记录的音爆时间
        
        for j = 1:4
            assigned_cluster = cluster_assignments(i, j);
            % 计算距离
            dist = sqrt((x_i - x_k(assigned_cluster))^2 + (y_i - y_k(assigned_cluster))^2 + (z_i - z_k(assigned_cluster))^2);
            % 计算理论音爆时间
            t_calc = t_k(assigned_cluster) + dist / v;
            % 累加误差平方
            total_error = total_error + (t_ij(j) - t_calc)^2;
        end
    end
end
