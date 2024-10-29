function path = generate_balanced_helical_path(radius, pitch, num_turns, num_points)
  %  Heliks path oluşturma (X, Y ve Z'de dengeli mesafe)
    t = linspace(0, num_turns * 2 * pi, num_points);
    x = 1 * (t);
    y = 2 * (t);
    z = 1*(t);  % Z ekseni boyunca yükselme
%  
%       t = linspace(0, num_turns * 2 * pi, num_points);  % Açısal değişim
%       x = radius * cos(t) .* (1 + 0.05 * t);           % X ekseni, spiral genişlik için bir faktör
%       y = radius * sin(t) .* (1 + 0.05 * t);           % Y ekseni, spiral genişlik için bir faktör
%       z = linspace(0, num_turns * pitch, num_points);  % Z ekseninde yükselme
%    

 % t parametresi, heliksin açısal değişimini ifade eder
%     t = linspace(0, num_turns * 2 * pi, num_points);  % Açısal değişim
% 
%     % X ve Y ekseninde heliks genişliğini artırmak için t faktörüyle genişletilmiş bir heliks
%         x = 1 * (t);
%     y = radius * sin(t) .* (1 + 0.05 * t);           % Y ekseni
% 
%     % Z ekseninde, heliks boyunca düzenli bir yükselme
%     z = 1*(t)  
    path = [x', y', z'];  % X, Y ve Z eksenlerinde dengeli bir yol


end
