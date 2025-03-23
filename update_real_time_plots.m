function update_real_time_plots(fig1, fig2, vehicle_path, times, velocities, angular_velocities, h_vehicle_path, h_velocity, h_angular_velocity, h_position, h_orientation, orientations)
    % 3D araç yolunu güncelle
    figure(fig1);
    if isvalid(h_vehicle_path)  % Grafik nesnesi varsa
        set(h_vehicle_path, 'XData', vehicle_path(:, 1), 'YData', vehicle_path(:, 2), 'ZData', vehicle_path(:, 3));
    else
        % Eğer grafik nesnesi yoksa yeniden oluştur
        h_vehicle_path = plot3(vehicle_path(:, 1), vehicle_path(:, 2), vehicle_path(:, 3), 'b-', 'LineWidth', 1);
        hold on;
        grid on;
        axis equal;
        xlabel('X Position (m)');
        ylabel('Y Position (m)');
        zlabel('Z Position (m)');
        title('3D Vehicle Path');
        legend('Vehicle Path');
    end
    drawnow;

    % Hız grafiği (u, v, w)
    figure(fig2);
    subplot(4, 1, 1); % Hız grafiği
    set(h_velocity(1), 'XData', times, 'YData', velocities(:, 1));  % u
    set(h_velocity(2), 'XData', times, 'YData', velocities(:, 2));  % v
    set(h_velocity(3), 'XData', times, 'YData', velocities(:, 3));  % w
    title('Velocities');
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    legend('u (surge)', 'v (sway)', 'w (heave)');
    grid on;

    % Açısal hız grafiği (p, q, r)
    subplot(4, 1, 2); % Açısal hız grafiği
    set(h_angular_velocity(1), 'XData', times, 'YData', angular_velocities(:, 1));  % p
    set(h_angular_velocity(2), 'XData', times, 'YData', angular_velocities(:, 2));  % q
    set(h_angular_velocity(3), 'XData', times, 'YData', angular_velocities(:, 3));  % r
    title('Angular Velocities');
    xlabel('Time (s)');
    ylabel('Angular Velocity (rad/s)');
    legend('p (roll rate)', 'q (pitch rate)', 'r (yaw rate)');
    grid on;

    % Pozisyon grafiği (x, y, z)
    subplot(4, 1, 3); % Pozisyon grafiği
    set(h_position(1), 'XData', times, 'YData', vehicle_path(:, 1));  % x
    set(h_position(2), 'XData', times, 'YData', vehicle_path(:, 2));  % y
    set(h_position(3), 'XData', times, 'YData', vehicle_path(:, 3));  % z
    title('Positions');
    xlabel('Time (s)');
    ylabel('Position (m)');
    legend('x', 'y', 'z');
    grid on;

    % Oryantasyon grafiği (phi, theta, psi)
    subplot(4, 1, 4); % Oryantasyon grafiği
    set(h_orientation(1), 'XData', times, 'YData', rad2deg(orientations(:, 1))); % phi (roll)
    set(h_orientation(2), 'XData', times, 'YData', rad2deg(orientations(:, 2))); % theta (pitch)
    set(h_orientation(3), 'XData', times, 'YData', rad2deg(orientations(:, 3))); % psi (yaw)
    title('Orientations');
    xlabel('Time (s)');
    ylabel('Angle (deg)');
    legend('\phi (roll)', '\theta (pitch)', '\psi (yaw)');
    grid on;

    drawnow;
end
