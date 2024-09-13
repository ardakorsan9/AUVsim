function update_real_time_plots(fig1, fig2, vehicle_path, times, velocities, angular_velocities, h_vehicle_path, h_velocity, h_angular_velocity, h_position)
    % 3D araç yolunu güncelle
    figure(fig1);
    % Mevcut grafiği güncelle
    set(h_vehicle_path, 'XData', vehicle_path(:, 1), 'YData', vehicle_path(:, 2), 'ZData', vehicle_path(:, 3));
    drawnow;

    % Hız, açısal hız ve pozisyon grafiğini güncelle
    figure(fig2);
    
    % Hız grafiği (u, v, w)
    set(h_velocity(1), 'XData', times, 'YData', velocities(:, 1));  % u
    set(h_velocity(2), 'XData', times, 'YData', velocities(:, 2));  % v
    set(h_velocity(3), 'XData', times, 'YData', velocities(:, 3));  % w
    
    % Açısal hız grafiği (p, q, r)
    set(h_angular_velocity(1), 'XData', times, 'YData', angular_velocities(:, 1));  % p
    set(h_angular_velocity(2), 'XData', times, 'YData', angular_velocities(:, 2));  % q
    set(h_angular_velocity(3), 'XData', times, 'YData', angular_velocities(:, 3));  % r
    
    % Pozisyon grafiği (x, y, z)
    set(h_position(1), 'XData', times, 'YData', vehicle_path(:, 1));  % x
    set(h_position(2), 'XData', times, 'YData', vehicle_path(:, 2));  % y
    set(h_position(3), 'XData', times, 'YData', vehicle_path(:, 3));  % z
    
    drawnow;
end
