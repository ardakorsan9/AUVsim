function underwater_vehicle_simulation()
    % Global parametreleri başlat
    init_parameters();

    % Waypoints tanımlama
    waypoints = [40, 5, -10; 
                 25, 20, -15; 
                 30, 25, -20; 
                 40, 30, -25]; 

    % Başlangıç pozisyonu
    f_0 = zeros(12, 1); 

    % Simülasyon zamanı
    dt = 0.2; % Zaman adımı

    % Boş figürleri hazırla
    [fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position] = setup_plots(waypoints);

    % Waypoint döngüsünü çalıştır
    waypoint_simulation_loop(waypoints, f_0, dt, fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position);
end
