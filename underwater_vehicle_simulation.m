function underwater_vehicle_simulation()
    % Global variables initialization
    init_parameters();

    % Initial conditions and time span for the simulation
    f_0 = zeros(12, 1); 
    t_span = 0:0.1:100;

    % Desired position and orientation
    desired_position = [1; 1; 1];
    desired_orientation = [0; 0; 0];

    % ODE options for solver tolerance
    options = odeset('RelTol',1e-3,'AbsTol',1e-6);
    [t, g] = ode45(@(t, g) underwater_vehicle_dynamics(t, g, desired_position, desired_orientation), t_span, f_0, options);

    % Plot the results
    plot_vehicle_results(t, g, desired_position);
end