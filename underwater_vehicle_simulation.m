function underwater_vehicle_simulation()
    % Define global variables
    global m W B % aracın kütlesi-ağırlık-batmazlık kuvveti
    global xg yg zg % Kütle merkezinin x,y,z eks.deki koord
    global xb yb zb % Batmazlık merkezinin x,y,z eks.deki koord
    global Xuu Xwq Xqq Xvr Xrr % X yönündeki hidrodinamik katsayılar.
    global Yvv Yrr Yuv Ywp Yur Ypq % Y yönündeki hidrodinamik katsayılar.
    global Zww Zqq Zuw Zuq Zvp Zrp % Z yönündeki hidrodinamik katsayılar.
    global Kpp %(roll) için hidrodinamik katsayı.
    global Mww Mqq Mrp Muq Muw Mvp %pitch) için hidrodinamik katsayılar.
    global Nvv Nrr Nuv Npq Nwp Nur %Yaw hareketi (dönüş) için hidrodinamik katsayılar
    global Ixx Iyy Izz %Aracın x, y, z eksenlerindeki atalet momentleri
    global Xudot Yvdot Yrdot Zwdot Zqdot Kpdot Mwdot Mqdot Nvdot Nrdot
    global Kp_position Kd_position %Pozisyon kontrolü için PD kazançları
    global Kp_orientation Kd_orientation %Oryantasyon kontrolü için PD kazançları

    % Initialize parameters
    m = 18.826;
    Ixx = 0.177;
    Iyy = 3.45;
    Izz = 3.45;

    W = 299;
    B = 306;
    xg = 0.0;
    yg = 0.00;
    zg = 0.0;

    xb = 0.0;
    yb = 0.00;
    zb = 0.0;

    Xuu = -162;
    Xwq = -35.5;
    Xqq = -19.3;
    Xvr = 35.5;
    Xrr = -19.3;
    Yvv = -131;
    Yrr = 0.632;
    Yuv = -28.6;
    Ywp = 35.5;
    Yur = 5.22;
    Ypq = 1.93;

    Zww = -131;
    Zqq = -0.632;
    Zuw = -28.6;
    Zuq = -5.22;
    Zvp = -35.5;
    Zrp = 1.93;

    Kpp = -0.0013;

    Mww = 3.18;
    Mqq = -9.40;
    Mrp = 4.86;
    Muq = -2.00;
    Muw = 24.0;
    Mvp = -1.93;

    Nvv = -3.18;
    Nrr = -9.40;
    Nuv = -24.0;
    Npq = -4.86;
    Nwp = -1.93;
    Nur = -2.00;

    Xudot = -26.2;
    Yvdot = -395;
    Yrdot = 32.4;
    Zwdot = -395;
    Zqdot = -32.4;
    Kpdot = 0;
    Mwdot = -32.4;
    Mqdot = -127;
    Nvdot = 32.4;
    Nrdot = -127;

    % PD kontrol kazançları
    Kp_position = [10; 35; 45]; % Pozisyon kontrolü için PD kazançları
    Kd_position = [5; 28; 30];
    Kp_orientation = [10; 22; 33]; % Oryantasyon kontrolü için PD kazançları
    Kd_orientation = [5; 10; 15];

    % Initial conditions
    f_0 = [0 0 0 0 0 0 0 0 0 0 0 0]; % [x y z phi theta psi u v w p q r]
    t_span = 0:0.1:100; % Simulate for 100 seconds with 0.1s step size

    % Desired position
    desired_position = [15; 7; 5]; % Desired x, y, z positions
    desired_orientation = [0; 0; 0]; % Desired roll, pitch, yaw angles

    % Solve the differential equations
    [t, g] = ode45(@(t, g) underwater_vehicle_dynamics(t, g, desired_position, desired_orientation), t_span, f_0);

    % Plot results
    plot_vehicle_results(t, g, desired_position);
end