function g_dot = underwater_vehicle_dynamics(t, g, desired_position, desired_orientation)
    global m W B 
    global xg yg zg 
    global xb yb zb 
    global Xuu Xwq Xqq Xvr Xrr 
    global Yvv Yrr Yuv Ywp Yur Ypq 
    global Zww Zqq Zuw Zuq Zvp Zrp 
    global Kpp 
    global Mww Mqq Mrp Muq Muw Mvp 
    global Nvv Nrr Nuv Npq Nwp Nur 
    global Ixx Iyy Izz 
    global Xudot Yvdot Yrdot Zwdot Zqdot Kpdot Mwdot Mqdot Nvdot Nrdot
    global Kp_position Kd_position
    global Kp_orientation Kd_orientation

    % Extract state variables
    x = g(1);
    y = g(2);
    z = g(3);
    phi = g(4);
    theta = g(5);
    psi = g(6);
    u = g(7);
    v = g(8);
    w = g(9);
    p = g(10);
    q = g(11);
    r = g(12); 

    % Pozisyon hataları ve türevleri
    position_error = desired_position - [x; y; z];
    velocity = [u; v; w];
    position_error_dot = -velocity;

    % Oryantasyon hataları ve türevleri
    orientation_error = desired_orientation - [phi; theta; psi];
    angular_velocity = [p; q; r];
    orientation_error_dot = -angular_velocity;

    % PD kontrolcünün kontrol sinyalleri
    position_control = Kp_position .* position_error + Kd_position .* position_error_dot;
    orientation_control = Kp_orientation .* orientation_error + Kd_orientation .* orientation_error_dot;

    % Kontrol sinyallerine doygunluk ekle
    max_control = 50; % Maksimum kontrol sinyali
    position_control = max(min(position_control, max_control), -max_control);
    orientation_control = max(min(orientation_control, max_control), -max_control);
    
    % Compute forces and moments using control inputs and other terms
    X = (W - B) * sin(theta) + Xuu * u * abs(u) + (Xwq - m) * w * q + (Xvr + m) * v * r + (Xqq + m * xg) * q^2 + (Xrr + m * xg) * r^2 - m * yg * p * q - m * zg * p * r + position_control(1);
    Y = -(W - B) * cos(theta) * sin(phi) + Yvv * v * abs(v) + Yrr * r * abs(r) + (Yur - m) * u * r + (Ywp - m) * w * p + (Ypq - m * xg) * p * q + m * zg * q * r + m * yg * p^2 + Yuv * u * v + position_control(2);
    Z = -(W - B) * cos(theta) * cos(phi) + Zww * w * abs(w) + Zqq * q * abs(q) + (Zuq + m) * u * q + (Zvp - m) * v * p + (Zrp - m * xg) * r * p - m * yg * r * q + m * zg * p^2 + m * zg * q^2 + Zuw * u * w + position_control(3);
    K = -(yg*W-yb*B)*cos(theta)*cos(phi) + (zg*W-zb*B)*cos(theta)*sin(phi) + Kpp * p * abs(p) + (Iyy - Izz) * q * r - m * v * p + m * u * q - m * zg * w * p + m * zg * u * r + orientation_control(1);
    M = (zg*W-zb*B)*sin(theta) + (xg*W-xb*B)*cos(theta)*cos(phi) + Mww * w * abs(w) + Mqq * q * abs(q) + (Mvp + m * xg) * v * p + (Mrp - Ixx + Izz) * r * p + (Muq - m * xg) * u * q + Muw * u * w + m * zg * r * v - m * zg * q * w + orientation_control(2);
    N = -(xg*W-xb*B)*cos(theta)*sin(phi) - (yg*W-yb*B)*sin(theta) + Nvv * v * abs(v) + Nrr * r * abs(r) + (Nwp + m * xg) * w * p + (Npq - Iyy + Ixx) * p * q + (Nur - m * xg) * u * r + Nuv * u * v + m * yg * q * w - m * yg * r * v + orientation_control(3);

    % Matrix A
    A = [m - Xudot, 0, 0, 0, m * zg, -m * yg;
         0, m - Yvdot, 0, -m * zg, 0, m * xg - Yrdot;
         0, 0, m - Zwdot, m * yg, -m * xg - Zqdot, 0;
         0, -m * zg, m * yg, Ixx - Kpdot, 0, 0;
         m * zg, 0, -m * xg - Mwdot, 0, Iyy - Mqdot, 0;
         -m * yg, m * xg - Nvdot, 0, 0, 0, Izz - Nrdot];

    % Force vector T
    J = [X; Y; Z; K; M; N];

    % State derivatives
    C = A\J;

    % g_dot calculations
    g_dot = zeros(12, 1);
    g_dot(1) = u*cos(psi)*cos(theta) + v*(-sin(psi)*cos(phi) + cos(psi)*sin(theta)*sin(phi)) + w*(sin(psi)*sin(phi) + cos(psi)*sin(theta)*cos(phi));
    g_dot(2) = u*sin(psi)*cos(theta) + v*(cos(psi)*cos(phi) + sin(psi)*sin(theta)*sin(phi)) + w*(-cos(psi)*sin(phi) + sin(psi)*sin(theta)*cos(phi));
    g_dot(3) = -u*sin(theta) + v*cos(theta)*sin(phi) + w*cos(theta)*cos(phi);
    g_dot(4) = p + q*sin(phi)*tan(theta) + r*cos(phi)*tan(theta);
    g_dot(5) = q*cos(phi) - r*sin(phi);
    g_dot(6) = (q*sin(phi))/cos(theta) + (r*cos(phi))/cos(theta);
    g_dot(7) = C(1);
    g_dot(8) = C(2);
    g_dot(9) = C(3);
    g_dot(10) = C(4);
    g_dot(11) = C(5);
    g_dot(12) = C(6);
end