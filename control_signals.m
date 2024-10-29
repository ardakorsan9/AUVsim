function [position_control, orientation_control] = control_signals(g, desired_position, desired_orientation)
    global Kp_position Kd_position Ki_position
    global Kp_orientation Kd_orientation Ki_orientation


    % Durum değişkenlerini çıkarma
    x = g(1); y = g(2); z = g(3);
    phi = g(4); theta = g(5); psi = g(6);
    u = g(7); v = g(8); w = g(9);  % Lineer hızlar
    p = g(10); q = g(11); r = g(12);  % Açısal hızlar

    % Hata hesaplamaları
    position_error = desired_position - [x; y; z];
    orientation_error = desired_orientation - [phi; theta; psi];

    % Integral hatalarını biriktirmek için kalıcı değişkenler
    persistent integral_position_error integral_orientation_error
    if isempty(integral_position_error)
        integral_position_error = [0; 0; 0];
        integral_orientation_error = [0; 0; 0];
    end

    % Integral hatalarını güncelle
    integral_position_error = integral_position_error + position_error;
    integral_orientation_error = integral_orientation_error + orientation_error;

    % PID pozisyon ve oryantasyon kontrolü
    position_control = Kp_position .* position_error - Kd_position .* [u; v; w] + Ki_position .* integral_position_error;
    orientation_control = Kp_orientation .* orientation_error - Kd_orientation .* [p; q; r] + Ki_orientation .* integral_orientation_error;


end