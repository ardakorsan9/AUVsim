function underwater777_vehicle_simulation()
    % Parametreleri yükle
    init_parameters();

    % Zaman adımı
    dt = 0.075;

    % Başlangıç koşulları
    f_0 = zeros(12, 1); % [x y z phi theta psi u v w p q r]

    % Yol oluşturma
    radius = 5; 
    pitch = 2; 
    num_turns = 3; 
    num_points = 1000;
    path = generate_balanced_helical_path(radius, pitch, num_turns, num_points);

    % Başlangıç pozisyonu ve oryantasyonu ayarla
    delta_pos = path(2, :) - path(1, :);
    initial_theta = atan2(delta_pos(3), norm(delta_pos(1:2))); % Pitch angle
    initial_psi = atan2(delta_pos(2), delta_pos(1));          % Yaw angle

    f_0(1:3) = path(1, :)'; % Başlangıç pozisyonu
    f_0(5) = -initial_theta; % Theta (pitch)
    f_0(6) = initial_psi;    % Psi (yaw)

    % Grafik pencerelerini başlat
    [fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position, h_orientation] = setup_plots(path);

    % Sürekli yol takibi
    continuous_path_tracking(path, f_0, dt, fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position, h_orientation);
end
