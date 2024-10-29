function underwater_vehicle_simulation()
    % Global parametreleri başlat
    init_parameters();

    dt = 0.2;  % Zaman adımı

    % Daha dengeli bir path oluşturzz
    radius = 10;
    pitch = 10;
    num_turns = 5;
    num_points = 100;
    path = generate_balanced_helical_path(radius, pitch, num_turns, num_points);

    % Başlangıç pozisyonunu path'in ilk noktasına ayarla
    f_0 = zeros(12, 1);
    f_0(1:3) = path(1, :)';  % İlk pozisyonu path'in ilk noktasına eşitle

    % Boş figürleri hazırla
    [fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position] = setup_plots(path);
    

    % Path takip simülasyonu
    continuous_path_tracking(path, f_0, dt, fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position);
end
