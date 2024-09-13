function [fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position] = setup_plots(waypoints)
    % Waypoints ve araç yolu için figür
    fig1 = figure(1);
    plot3(waypoints(:, 1), waypoints(:, 2), waypoints(:, 3), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
    hold on;
    h_vehicle_path = plot3(nan, nan, nan, 'b-', 'LineWidth', 1);  % Boş bir plot, sadece güncellenecek
    xlabel('X Pozisyonu (m)');
    ylabel('Y Pozisyonu (m)');
    zlabel('Z Pozisyonu (m)');
    grid on;
    axis equal;
    title('AUV Waypoint Takibi');
    legend('Waypoints', 'AUV Yolu');  % Sadece bir kere legend ekle

    % Hız, açısal hız ve pozisyon için figür
    fig2 = figure(2);
    
    % Hız grafiği (u, v, w)
    subplot(3, 1, 1); hold on;
    h_velocity(1) = plot(nan, nan, 'b');  % u
    h_velocity(2) = plot(nan, nan, 'g');  % v
    h_velocity(3) = plot(nan, nan, 'r');  % w
    xlabel('Time (s)'); ylabel('Velocity (m/s)');
    legend('u', 'v', 'w');  % Legend sadece bir kez eklenir

    % Açısal hız grafiği (p, q, r)
    subplot(3, 1, 2); hold on;
    h_angular_velocity(1) = plot(nan, nan, 'b');  % p
    h_angular_velocity(2) = plot(nan, nan, 'g');  % q
    h_angular_velocity(3) = plot(nan, nan, 'r');  % r
    xlabel('Time (s)'); ylabel('Angular Velocity (rad/s)');
    legend('p', 'q', 'r');  % Legend sadece bir kez eklenir

    % Pozisyon grafiği (x, y, z)
    subplot(3, 1, 3); hold on;
    h_position(1) = plot(nan, nan, 'b');  % x
    h_position(2) = plot(nan, nan, 'g');  % y
    h_position(3) = plot(nan, nan, 'r');  % z
    xlabel('Time (s)'); ylabel('Position (m)');
    legend('x', 'y', 'z');  % Legend sadece bir kez eklenir
end
