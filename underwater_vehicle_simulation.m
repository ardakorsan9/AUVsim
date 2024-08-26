function underwater_vehicle_simulation()
    % Global variables initialization
    init_parameters();

    % Initial conditions and time span for the simulation
    f_0 = zeros(12, 1); 
    t_span = 0:0.1:100;

    % Desired position and orientation
    desired_position = [10; 10; 10];
    desired_orientation = [0; 0; 0];

    % ODE
    [t, g] = ode45(@(t, g) underwater_vehicle_dynamics(t, g, desired_position, desired_orientation), t_span, f_0);

    % Plot the results
    plot_vehicle_results(t, g, desired_position);
end