function continuous_path_tracking(path, f_0, dt, fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position, h_orientation)
    num_points = size(path, 1);
    vehicle_path = [];
    times = [];
    velocities = [];
    angular_velocities = [];
    orientations = [];
    total_time = 0;
    lookahead_distance = 0.55; % Hedef noktalara yaklaşma mesafesi

    for i = 1:num_points
        % Hedef pozisyon
        desired_position = path(i, :)';

        % Lookahead kontrolü: Eğer araç hedef noktasına yeterince yakınsa bir sonraki noktaya geç
        while i < num_points && norm(desired_position - f_0(1:3)) < lookahead_distance
            i = i + 1;
            desired_position = path(i, :)';
        end
 
        % Dinamik sistemi çöz
        t_span = total_time:dt:(total_time + dt);
        [~, g] = ode45(@(t, g) underwater777_vehicle_dynamics(t, g, desired_position), t_span, f_0);

        % Sonuçları kaydet
        vehicle_path = [vehicle_path; g(end, 1:3)];
        times = [times; t_span(end)];
        velocities = [velocities; g(end, 7:9)];
        angular_velocities = [angular_velocities; g(end, 10:12)];
        orientations = [orientations; g(end, 4:6)]; % phi, theta, psi

        % Başlangıç durumunu güncelle
        f_0 = g(end, :)';
        total_time = total_time + dt;

        % Grafik güncellemeleri
        update_real_time_plots(fig1, fig2, vehicle_path, times, velocities, angular_velocities, ...
                               h_vehicle_path, h_velocity, h_angular_velocity, h_position, h_orientation, orientations);
        auv_animation(path, vehicle_path, velocities)
    end
end
