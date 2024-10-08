function waypoint_simulation_loop(waypoints, f_0, dt, fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position)
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
