function plot_vehicle_results(t, g, desired_position)
    % Visualization
    figure;
    subplot(4, 1, 1);
    plot(t, g(:, 1), t, repmat(desired_position(1), length(t), 1), '--', ...
         t, g(:, 2), t, repmat(desired_position(2), length(t), 1), '--', ...
         t, g(:, 3), t, repmat(desired_position(3), length(t), 1), '--');
    legend('x', 'desired x', 'y', 'desired y', 'z', 'desired z');
    xlabel('Time (s)');
    ylabel('Position (m)');
    title('Position vs Time');
    
    subplot(4, 1, 2);
    plot(t, g(:, 4), t, repmat(length(t), 1), '--', ...
         t, g(:, 5), t, repmat(length(t), 1), '--', ...
         t, g(:, 6), t, repmat(length(t), 1), '--');
    legend('phi', 'desired phi', 'theta', 'desired theta', 'psi', 'desired psi');
    xlabel('Time (s)');
    ylabel('Angle (rad)');
    title('Orientation vs Time');
    
    subplot(4, 1, 3);
    plot(t, g(:, 7:9));
    legend('u', 'v', 'w');
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    title('Velocity vs Time');

    subplot(4, 1, 4);
    plot(t, g(:, 10:12));
    legend('p', 'q', 'r');
    xlabel('Time (s)');
    ylabel('Angular Velocity (rad/s)');
    title('Angular Velocity vs Time');
end