% 定义观测点的坐标和目标点到观测点的距离
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

% 定义目标函数
fun = @(x) sum((sqrt(sum((observed_points - x(1:3)).^2, 2)) - distances).^2);

% 初始猜测
x0 = [110.000*97.304; 27.000*111.263; 600];

% 设置模拟退火算法的参数
options = optimoptions('simulannealbnd', 'MaxIterations', 1000, 'Display', 'iter');

% 使用模拟退火算法求解最小化问题
[x_opt, ~, ~, output] = simulannealbnd(fun, x0, [], [], options);

disp('目标点坐标：');
disp(x_opt);

disp('模拟退火算法输出信息：');
disp(output);
