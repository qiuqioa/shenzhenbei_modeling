function target_point = trilaterate(observed_points, distances)
    % 初始化目标点坐标
    target_point = [0, 0, 0];

    % 循环计算每个观测点对目标点的影响
    for i = 1:size(observed_points, 1)
        % 计算当前观测点到目标点的距离
        d = distances(i);

        % 获取当前观测点的坐标
        observed_point = observed_points(i, :);

        % 更新目标点坐标
        target_point = target_point + (d / norm(observed_point - target_point)) * (target_point - observed_point);
    end
end