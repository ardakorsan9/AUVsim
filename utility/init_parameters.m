function init_parameters()
    global m W B Xu Yv Zw Kp_roll Mpitch Nr Ixx Iyy Izz
    global Kp_position Kd_position Kp_orientation Kd_orientation
    global tau_m K_m K_t
    global xg yg zg  % Center of gravity coordinates
    global Xuu Yvv Zww Xwq Xvr Yrr Yur Ywp Zqq Zuq Zvp Zrp Kpp Mww Mqq Mrp Muq Muw Mvp Nvv Nrr Nuv Npq Nwp Nur 
    global Xrr Xqq Ypq Yuv Zuw 
    global yb zb xb
    global Xudot Yvdot Yrdot Zwdot Zqdot Kpdot Mwdot Mqdot Nvdot Nrdot

    % Fiziksel ve kontrol parametreleri
    m = 18.826;  
    W = 299;  
    B = 306;  
    Xu = -162;  
    Yv = -131;  
    Zw = -131;  
    Kp_roll = -0.0013;  
    Mpitch = -9.40;  
    Nr = -9.40;  
    Ixx = 0.177;  
    Iyy = 3.45;  
    Izz = 3.45;  
    
    Kp_position = [50; 148; 178];  
    Kd_position = [70; 80; 95];  
    Kp_orientation = [50; 172; 187];  
    Kd_orientation = [85; 110; 125];  
    
    
    tau_m = 0.5;  
    K_m = 1;  
    K_t = 10;  
    
    xg = 0.0;  
    yg = 0.0;  
    zg = 0.0;  
    
    Xuu = -162;  
    Yvv = -131;  
    Zww = -131;  
    
    Xwq = -35.5;  
    Xvr = 35.5;  
    Yrr = 0.632;  
    Yur = 5.22;  
    Ywp = 35.5;  
    Zqq = -0.632;  
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
    
    Xqq = -19.3;
    Xrr = -19.3;
    Ypq = 1.93;
    Yuv = -28.6;
    Zuw = -28.6;
    yb = 0.00;
    zb = 0.0;
    xb = 0.0;

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
end