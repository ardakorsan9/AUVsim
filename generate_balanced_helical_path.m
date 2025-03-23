function path = generate_balanced_helical_path(radius, pitch, num_turns, num_points)


%  t parametresi, heliksin açısal değişimini ifade eder
    t = linspace(0, num_turns * 2 * pi, num_points);  % Açısal değişim

    % X ve Y ekseninde heliks genişliğini artırmak için t faktörüyle genişletilmiş bir heliks
        x = 1 * (t);
    y = radius * sin(t) .* (1 + 0.05 * t);           % Y ekseni

    % Z ekseninde, heliks boyunca düzenli bir yükselme
    z = 1*(t);  
    path = [x', y', z'];  % X, Y ve Z eksenlerinde dengeli bir yol


end