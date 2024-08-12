function g_dot = underwater_vehicle_dynamics(t, g, desired_position, desired_orientation)
    global m W B Xu Yv Zw Kp_roll Mpitch Nr Ixx Iyy Izz
    global Kp_position Kd_position Kp_orientation Kd_orientation
    global xg yg zg;
    % State variables extraction
    x = g(1); y = g(2); z = g(3);
    phi = g(4); theta = g(5); psi = g(6);
    u = g(7); v = g(8); w = g(9);
    p = g(10); q = g(11); r = g(12);
  
    % Error calculations
    position_error = desired_position - [x; y; z];
    orientation_error = desired_orientation - [phi; theta; psi];

    % PD controllers
    position_control = Kp_position .* position_error - Kd_position .* [u; v; w];
    orientation_control = Kp_orientation .* orientation_error - Kd_orientation .* [p; q; r];

    % Forces and moments calculation
    X = (W - B) * sin(theta) + Xu * u + position_control(1);
    Y = -(W - B) * cos(theta) * sin(phi) + Yv * v + position_control(2);
    Z = -(W - B) * cos(theta) * cos(phi) + Zw * w + position_control(3);
    K = Kp_roll * p + orientation_control(1);
    M = Mpitch * q + orientation_control(2);
    N = Nr * r + orientation_control(3);

    % System dynamics matrix A and force/moment vector J
    A = [m - Xu, 0, 0, 0, m * zg, -m * yg;
         0, m - Yv, 0, -m * zg, 0, m * xg;
         0, 0, m - Zw, m * yg, -m * xg, 0;
         0, -m * zg, m * yg, Ixx, 0, 0;
         m * zg, 0, -m * xg, 0, Iyy, 0;
         -m * yg, m * xg, 0, 0, 0, Izz];
    J = [X; Y; Z; K; M; N];

    % Solve linear system
    C = A\J;

    % Rotation matrix for converting body rates to Euler angle rates
    R = [cos(psi)*cos(theta), cos(psi)*sin(theta)*sin(phi) - sin(psi)*cos(phi), cos(psi)*sin(theta)*cos(phi) + sin(psi)*sin(phi);
         sin(psi)*cos(theta), sin(psi)*sin(theta)*sin(phi) + cos(psi)*cos(phi), sin(psi)*sin(theta)*cos(phi) - cos(psi)*sin(phi);
         -sin(theta), cos(theta)*sin(phi), cos(theta)*cos(phi)];

    % Euler matrix for angular velocity conversion
    JJ = [1, sin(phi)*tan(theta), cos(phi)*tan(theta); 
          0, cos(phi), -sin(phi); 
          0, sin(phi)/cos(theta), cos(phi)/cos(theta)];

    % Update state derivatives
    g_dot = zeros(12, 1);
    g_dot(1:3) = R * [u; v; w];  % Position derivatives are the velocities
    g_dot(4:6) = JJ * [p; q; r];  % Orientation derivatives are the angular velocities
    g_dot(7:9) = [C(1); C(2); C(3)];  % Velocity derivatives
    g_dot(10:12) = C(4:6);  % Angular velocity derivatives

    return
end
