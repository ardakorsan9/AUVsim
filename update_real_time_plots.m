function update_real_time_plots(fig1, fig2, vehicle_path, waypoints, times, velocities, angular_velocities)
    % 3D araç yolunu güncelle
    figure(fig1);
    plot3(vehicle_path(:, 1), vehicle_path(:, 2), vehicle_path(:, 3), 'b-', 'LineWidth', 1);
    drawnow;

    % Hız, açısal hız ve pozisyon grafiğini güncelle
    figure(fig2);
    
    % Hız grafiği (u, v, w)
    subplot(3, 1, 1);
    plot(times, velocities(:, 1), 'b', times, velocities(:, 2), 'g', times, velocities(:, 3), 'r');
    
    % Açısal hız grafiği (p, q, r)
    subplot(3, 1, 2);
    plot(times, angular_velocities(:, 1), 'b', times, angular_velocities(:, 2), 'g', times, angular_velocities(:, 3), 'r');
    
    % Pozisyon grafiği (x, y, z)
    subplot(3, 1, 3);
    plot(times, vehicle_path(:, 1), 'b', times, vehicle_path(:, 2), 'g', times, vehicle_path(:, 3), 'r');
    
    drawnow;
end