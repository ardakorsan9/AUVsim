function auv_animation(path, vehicle_path, velocities)
    % Başlangıçta tek bir grafik oluştur ve sadece bir kez aç
    persistent fig h_body h_head velocity_text X Y Z

    % Eğer figür ve nesneler daha önce oluşturulmadıysa, başlat
    if isempty(fig) || ~isvalid(fig)
        fig = figure('Name', 'AUV Path Takip Animasyonu');
        plot3(path(:, 1), path(:, 2), path(:, 3), 'k-', 'LineWidth', 2);  % Path çizimi
        hold on;
        xlabel('X Pozisyonu (m)');
        ylabel('Y Pozisyonu (m)');
        zlabel('Z Pozisyonu (m)');
        grid on;
        axis equal;
        title('AUV Path Takip Animasyonu');

        % AUV modelini tanımla (silindirik bir su altı aracı)
        [X, Y, Z] = cylinder([0.3, 0.3, 0.1]);
        Z = Z * 2 - 1;
        h_body = surf(X, Y, Z, 'FaceColor', [0, 0.5, 0], 'EdgeColor', 'none');
        h_head = plot3(nan, nan, nan, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
        velocity_text = text(0, 0, 0, '', 'FontSize', 12, 'Color', 'b');
    end

    % Yön vektörünü hesapla
    direction = velocities(end, :) / norm(velocities(end, :));
    
    % Eğer direction sıfır vektörüyse, birim matris kullan
    if all(direction == 0)
        R = eye(3);  % Sıfır vektör için birim dönüşüm matrisi kullan
    else
        R = vrrotvec2mat(vrrotvec([0 0 1], direction));  % Z ekseninden direction vektörüne dönüşüm
    end

    % Gövde ve baş kısmını yeni konuma göre güncelle
    set(h_body, 'XData', X + vehicle_path(end, 1), ...
                'YData', Y + vehicle_path(end, 2), ...
                'ZData', Z + vehicle_path(end, 3));
    set(h_head, 'XData', vehicle_path(end, 1) + direction(1), ...
                'YData', vehicle_path(end, 2) + direction(2), ...
                'ZData', vehicle_path(end, 3) + direction(3));

    % Hız büyüklüğünü ekranda göster
    velocity_magnitude = norm(velocities(end, :));
    set(velocity_text, 'Position', [vehicle_path(end, 1), vehicle_path(end, 2), vehicle_path(end, 3) + 2], ...
                       'String', sprintf('Velocity = %.2f m/s', velocity_magnitude));

    drawnow;
end
