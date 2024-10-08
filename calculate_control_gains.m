function [Kp_position_adaptive, Kd_position_adaptive, Kp_orientation_adaptive, Kd_orientation_adaptive] = calculate_control_gains(position_error, orientation_error, Kp_position, Kd_position, Kp_orientation, Kd_orientation)
    % Adaptif kontrol - hata büyüklüğüne göre Kp ve Kd ayarları
    adaptive_gain = 1 + norm(position_error) / 10;  % Hata büyüdükçe kazanç artar
    
    % Adaptif kazanç hesaplamaları
    Kp_position_adaptive = Kp_position * adaptive_gain;
    Kd_position_adaptive = Kd_position * adaptive_gain;
    Kp_orientation_adaptive = Kp_orientation * adaptive_gain;
    Kd_orientation_adaptive = Kd_orientation * adaptive_gain;
end
