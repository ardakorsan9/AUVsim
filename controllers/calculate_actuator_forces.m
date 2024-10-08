function actuator_forces = calculate_actuator_forces(position_control, orientation_control)
    global K_t K_m tau_m

    % Kuvvet hesaplamasında tanh sınırlarını artırma
    alpha = 1.5;  % tanh fonksiyonunun sınırlarını artırmak için çarpan
    
    force_x = K_t * tanh(alpha * K_m * position_control(1) / tau_m);
    force_y = K_t * tanh(alpha * K_m * position_control(2) / tau_m);
    force_z = K_t * tanh(alpha * K_m * position_control(3) / tau_m);
    moment_k = K_t * tanh(alpha * K_m * orientation_control(1) / tau_m);
    moment_m = K_t * tanh(alpha * K_m * orientation_control(2) / tau_m);
    moment_n = K_t * tanh(alpha * K_m * orientation_control(3) / tau_m);

    actuator_forces = [force_x; force_y; force_z; moment_k; moment_m; moment_n];
end
