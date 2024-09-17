function [vehicle_path, times, velocities, angular_velocities, total_time] = run_simulation_to_waypoint(current_waypoint, f_0, dt, total_time, vehicle_path, times, velocities, angular_velocities, fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position)
    % Waypoint'e ulaşana kadar simülasyonu çalıştır
    distance_to_waypoint = norm(current_waypoint - f_0(1:3)); 
    while distance_to_waypoint > 0.5
        t_span = total_time:dt:(total_time + dt);

        % Anlık çözüm (ODE45)
        [~, g] = ode45(@(t, g) underwater_vehicle_dynamics(t, g, current_waypoint, [0; 0; 0]), t_span, f_0);

        % Verileri güncelle
        vehicle_path = [vehicle_path; g(end, 1:3)];
        times = [times; t_span(end)];
        velocities = [velocities; g(end, 7:9)];
        angular_velocities = [angular_velocities; g(end, 10:12)];

        % Gerçek zamanlı grafikleri güncelle
        update_real_time_plots(fig1, fig2, vehicle_path, times, velocities, angular_velocities, h_vehicle_path, h_velocity, h_angular_velocity, h_position);

        % Son durumu bir sonraki adıma geçiş için başlat
        f_0 = g(end, :)';
        distance_to_waypoint = norm(current_waypoint - f_0(1:3));
        total_time = total_time + dt;
    end
end
