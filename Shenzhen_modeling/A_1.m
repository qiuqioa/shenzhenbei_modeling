clc
clear
% 已知七个观测点的坐标 (x, y, z)
observed_points = [
    110.241*97.304, 27.204*111.263, 824;
    110.780*97.304, 27.456*111.263, 727;
    110.712*97.304, 27.785*111.263, 742;
    110.251*97.304, 27.825*111.263, 850;
    110.524*97.304, 27.617*111.263, 786;
    110.467*97.304, 27.921*111.263, 678;
    110.047*97.304, 27.121*111.263, 575
];

% 目标点到观测点的距离
times_reached=[100.767,112.220,188.020,258.985,118.443,266.871,163.024];
% 通过音爆时间算出观测点和目标点的距离
distances = times_reached.*340;

% 使用多圆定位法计算目标点坐标
target_point = trilaterate(observed_points, distances);

% 显示结果
disp('目标点坐标：');
disp(target_point);



%所用的函数脚本

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



