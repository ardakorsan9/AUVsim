function [fig1, fig2] = setup_plots(waypoints)
    % Anlık güncellemeler için grafik figürlerini hazırlama

    % Waypoints ve araç yolu için figür
    fig1 = figure(1);
    plot3(waypoints(:, 1), waypoints(:, 2), waypoints(:, 3), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
    hold on;
    xlabel('X Pozisyonu (m)');
    ylabel('Y Pozisyonu (m)');
    zlabel('Z Pozisyonu (m)');
    grid on;
    axis equal;
    title('AUV Waypoint Takibi');
    
    % Hız, açısal hız ve pozisyon için figür
    fig2 = figure(2);
    subplot(3, 1, 1); hold on;
    xlabel('Time (s)'); ylabel('Velocity (m/s)');
    
    subplot(3, 1, 2); hold on;
    xlabel('Time (s)'); ylabel('Angular Velocity (rad/s)');
    
    subplot(3, 1, 3); hold on;
    xlabel('Time (s)'); ylabel('Position (m)');
end