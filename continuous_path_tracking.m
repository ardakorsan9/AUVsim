% continuous_path_tracking fonksiyonunu güncelle
function continuous_path_tracking(path, f_0, dt, fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position)
    

    num_points = size(path, 1);
    vehicle_path = [];
    times = [];
    velocities = [];
    angular_velocities = [];
    
    total_time = 0;
    lookahead_distance = 1;  % Lookahead mesafesini ekliyoruz

    for i = 1:num_points
        desired_position = path(i, :)';  % Sıradaki hedef noktayı güncelle

        % Eğer araç lookahead_distance içinde ise bir sonraki hedefe geç
        while i < num_points && norm(path(i + 1, :)' - f_0(1:3)) < lookahead_distance
            i = i + 1;
        end

        % ODE45 ile dinamik sistemi çöz
        t_span = total_time:dt:(total_time + dt);
        [~, g] = ode45(@(t, g) underwater_vehicle_dynamics(t, g, desired_position, [0; 0; 0]), t_span, f_0);

        % Verileri saklama
        vehicle_path = [vehicle_path; g(end, 1:3)];
        times = [times; t_span(end)];
        velocities = [velocities; g(end, 7:9)];
        angular_velocities = [angular_velocities; g(end, 10:12)];

        % Grafik güncellemeleri
        update_real_time_plots(fig1, fig2, vehicle_path, times, velocities, angular_velocities, h_vehicle_path, h_velocity, h_angular_velocity, h_position);
        auv_animation(path, vehicle_path, velocities)

        % Son pozisyonu güncelle
        f_0 = g(end, :)';
        total_time = total_time + dt;
    end
end