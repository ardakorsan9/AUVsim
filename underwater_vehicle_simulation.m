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
    
    % Araç yolu, hız ve açısal hız verileri için boş diziler
    vehicle_path = [];
    times = [];
    velocities = [];
    angular_velocities = [];

    % Her bir waypoint için simülasyonu çalıştır
    total_time = 0;

    for waypoint_index = 1:size(waypoints, 1)
        current_waypoint = waypoints(waypoint_index, :)';
        
        % Simülasyonu çalıştır ve sonuçları güncelle
        [vehicle_path, times, velocities, angular_velocities, total_time, f_0] = ...
            run_simulation_to_waypoint(current_waypoint, f_0, dt, total_time, ...
            vehicle_path, times, velocities, angular_velocities, ...
            fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position);
    end
end
