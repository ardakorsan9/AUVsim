function init_parameters()
    global m W B Xu Yv Zw Kp_roll Mpitch Nr Ixx Iyy Izz
    global Kp_position Kd_position Kp_orientation Kd_orientation
    global tau_m K_m K_t
    global xg yg zg  % Center of gravity coordinates
    global Xuu Yvv Zww Xwq Xvr Yrr Yur Ywp Zqq Zuq Zvp Zrp Kpp Mww Mqq Mrp Muq Muw Mvp Nvv Nrr Nuv Npq Nwp Nur 
    global Xrr Xqq Ypq Yuv Zuw 
    global yb zb xb

    % Physical and control parameters
    m = 18.826;  % Vehicle mass
    W = 299;  % Weight of the vehicle
    B = 306;  % Buoyancy force
    Xu = -162;  % Linear drag in X direction
    Yv = -131;  % Linear drag in Y direction
    Zw = -131;  % Linear drag in Z direction 
    Kp_roll = -0.0013;  % Roll moment due to roll rate (p)
    Mpitch = -9.40;  % Pitch moment due to pitch rate (q)
    Nr = -9.40;  % Yaw moment due to yaw rate (r)
    Ixx = 0.177;  % Moment of inertia around X axis
    Iyy = 3.45;  % Moment of inertia around Y axis
    Izz = 3.45;  % Moment of inertia around Z axis
    
    Kp_position = [30; 30; 30];  % Proportional gain for position control
    Kd_position = [15; 15; 15];  % Derivative gain for position control

    Kp_orientation = [10; 22; 45];  % Proportional gain for orientation control
    Kd_orientation = [5; 10; 15];  % Derivative gain for orientation control
   
    tau_m = 0.5;  % Motor time constant
    K_m = 1;  % Motor constant
    K_t = 10;  % Torque constant
    
    xg = 0.0;  % Center of gravity X coordinate
    yg = 0.0;  % Center of gravity Y coordinate
    zg = 0.0;  % Center of gravity Z coordinate

    % Added quadratic drag terms
    Xuu = -162;  % Quadratic drag in X direction
    Yvv = -131;  % vQuadratic drag in Y direction
    Zww = -131;  % Quadratic drag in Z direction

    % Cross-coupling terms (Coriolis and Centripetal effects)
    Xwq = -35.5;  % Coupling term between X velocity and pitch rate (w * q)
    Xvr = 35.5;  % Coupling term between X velocity and yaw rate (v * r)
    Yrr = 0.632;  % Coupling term between Y velocity and yaw rate (r * abs(r))
    Yur = 5.22;  % Coupling term between Y velocity and yaw rate (u * r)
    Ywp = 35.5;  % Coupling term between Y velocity and roll rate (w * p)
    Zqq = -0.632;  % Coupling term between Z velocity and pitch rate (q * abs(q))
    Zuq = -5.22;  % Coupling term between Z velocity and pitch rate (u * q)
    Zvp = -35.5;  % Coupling term between Z velocity and roll rate (v * p)
    Zrp = 1.93;  % Coupling term between Z velocity and yaw rate (r * p)
   
    % Roll dynamics coefficients
    Kpp = -0.0013;  % Roll moment due to roll rate (p * abs(p))
    
    % Pitch dynamics coefficients
    Mww = 3.18;  % Pitch moment due to w * abs(w)
    Mqq = -9.40;  % Pitch moment due to q * abs(q)
    Mrp = 4.86;  % Pitch moment due to roll rate (r * p)
    Muq = -2.00;  % Pitch moment due to u * q
    Muw = 24.0;  % Pitch moment due to u * w
    Mvp = -1.93;  % Pitch moment due to v * p
    

    Xqq = -19.3;
    Xrr = -19.3;
    Ypq = 1.93;
    Yuv = -28.6;
    Zuw = -28.6;
    yb = 0.00;
    zb = 0.0;
    xb = 0.0;

    % Yaw dynamics coefficients
    Nvv = -3.18;  % Yaw moment due to v * abs(v)
    Nrr = -9.40;  % Yaw moment due to r * abs(r)
    Nuv = -24.0;  % Yaw moment due to u * v
    Npq = -4.86;  % Yaw moment due to p * q
    Nwp = -1.93;  % Yaw moment due to w * p
    Nur = -2.00;  % Yaw moment due to u * r
end
