function init_parameters()
    % Define global variables
    global m W B g_m
    global xg yg zg
    global xb yb zb
    global Xuu Xwq Xqq Xvr Xrr
    global Yvv Yrr Yuv Ywp Yur Ypq
    global Zww Zqq Zuw Zuq Zvp Zrp
    global Kpp
    global Mww Mqq Mrp Muq Muw Mvp
    global Nvv Nrr Nuv Npq Nwp Nur
    global Ixx Iyy Izz
    global Kp_psi Kd_psi Kp_theta Kd_theta Kp_x Kd_x 
    global Xudot Yvdot Yrdot Zwdot Zqdot Kpdot Mwdot Mqdot Nvdot Nrdot
    global Yuudr Zuuds Muuds Nuudr

    % Initialize parameters
    g_m = 9.81;
    W = 3.05e2;
    B = 3.1e2;
    m = W / g_m;

    Ixx = 1.77e-1;   
    Iyy = 3.45;  
    Izz = 3.45;

    xg = 0.0;
    yg = 0.00;
    zg = 1.96e-2;

    xb = 0.0;
    yb = 0.00;
    zb = 0.0;

    Xuu = -1.62;
    Xwq = -3.55e1;
    Xqq = -1.93;
    Xvr = 3.55e1;
    Xrr = -1.93;

    Yvv = -1.31e3;
    Yrr = 6.32e-1;
    Yuv = -2.86e1;
    Ywp = 3.55e1;
    Yur = 5.22;
    Ypq = 1.93;

    Zww = -1.31e2;
    Zqq = -6.32e-1;
    Zuw = -2.86e1;
    Zuq = -5.22;
    Zvp = -3.55e1;
    Zrp = 1.93;

    Kpp = -1.3e-1;

    Mww = 3.18;
    Mqq = -1.88e2;
    Mrp = 4.86;
    Muq = -2;
    Muw = 2.40e1;
    Mvp = -1.93;

    Nvv = -3.18;
    Nrr = -9.40e1;
    Nuv = -2.40e1;
    Npq = -4.86;
    Nwp = -1.93;
    Nur = -2.00;

    Xudot = -9.30e-1;
    Yvdot = -3.55e1;
    Yrdot = 1.93;
    Zwdot = -3.55e1;
    Zqdot = -1.93;
    Kpdot = -7.04e-2;
    Mwdot = -1.93;
    Mqdot = -4.88;
    Nvdot = 1.93;
    Nrdot = -4.88;

    Yuudr = 9.64;
    Zuuds = -9.64;
    Muuds = -6.15;
    Nuudr = -6.15;

    Kp_theta = 100;
    Kd_theta = 15;

    Kp_psi = 25;
    Kd_psi = 7;

    Kp_x = 17;
    Kd_x = 4;
 
end
