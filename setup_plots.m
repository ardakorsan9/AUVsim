function [fig1, fig2, h_vehicle_path, h_velocity, h_angular_velocity, h_position] = setup_plots(path)
    % Waypoints ve araç yolu için figür
    fig1 = figure(1);
    plot3(path(:, 1), path(:, 2), path(:, 3), 'k-', 'LineWidth', 2); % Path planını ince çizgi olarak göster
    hold on;
    xlabel('X Pozisyonu (m)');
    ylabel('Y Pozisyonu (m)');
    zlabel('Z Pozisyonu (m)');
    grid on;
    axis equal;
    title('AUV Path Takibi');
    
    % Araç yolu için boş bir plot oluştur (başlangıçta boş)
    h_vehicle_path = plot3(nan, nan, nan, 'b-', 'LineWidth', 1);  % Başlangıçta boş çizim
    legend('Path Plan', 'AUV Path');
    
    % Hız, açısal hız ve pozisyon için figür
    fig2 = figure(2);
    
    % Hız grafiği (u, v, w)
    subplot(3, 1, 1); hold on;
    h_velocity(1) = plot(nan, nan, 'b');  % u için çizim
    h_velocity(2) = plot(nan, nan, 'g');  % v için çizim
    h_velocity(3) = plot(nan, nan, 'r');  % w için çizim
    xlabel('Time (s)'); ylabel('Velocity (m/s)');
    legend('u', 'v', 'w');  % Hız grafiği için legend ekleme
    
    % Açısal hız grafiği (p, q, r)
    subplot(3, 1, 2); hold on;
    h_angular_velocity(1) = plot(nan, nan, 'b');  % p için çizim
    h_angular_velocity(2) = plot(nan, nan, 'g');  % q için çizim
    h_angular_velocity(3) = plot(nan, nan, 'r');  % r için çizim
    xlabel('Time (s)'); ylabel('Angular Velocity (rad/s)');
    legend('p', 'q', 'r');  % Açısal hız için legend ekleme
    
    % Pozisyon grafiği (x, y, z)
    subplot(3, 1, 3); hold on;
    h_position(1) = plot(nan, nan, 'b');  % x için çizim
    h_position(2) = plot(nan, nan, 'g');  % y için çizim
    h_position(3) = plot(nan, nan, 'r');  % z için çizim
    xlabel('Time (s)'); ylabel('Position (m)');
    legend('x', 'y', 'z');  % Pozisyon için legend ekleme
end