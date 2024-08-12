function init_parameters()
    global m W B Xu Yv Zw Kp_roll Mpitch Nr Ixx Iyy Izz
    global Kp_position Kd_position Kp_orientation Kd_orientation
    global tau_m K_m K_t
    global xg yg zg  % Add center of gravity parameters
    
 

    % Physical and control parameters
    m = 18.826; W = 299; B = 306;
    Xu = -162; Yv = -131; Zw = -131; 
    Kp_roll = -0.0013; Mpitch = -9.40; Nr = -9.40;
    Ixx = 0.177; Iyy = 3.45; Izz = 3.45;
    
    Kp_position = [30; 30; 30];  % Proportional gain
    Kd_position = [15; 15; 15];  % Derivative gain

    Kp_orientation = [10; 22; 45]; Kd_orientation = [5; 10; 15];
   
    tau_m = 0.5; K_m = 0.01; K_t = 0.1;
    xg = 0.0; yg = 0.0; zg = 0.0;  % Initialize center of gravity coordinates

end
