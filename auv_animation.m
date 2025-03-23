function auv_animation(path, vehicle_path, velocities)
    % Başlangıçta tek bir grafik oluştur ve sadece bir kez aç
    persistent fig h_body h_head velocity_text base_vertices rear_vertices front_vertices

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

        % Üçgen prizmayı tanımla (AUV gövdesi)
        % Üçgen prizmanın tabanının üç köşesi (orijin etrafında)
        base_vertices = [
            0, -0.5, -0.25;  % Sol alt
            0, 0.5, -0.25;   % Sağ alt
            0, 0, 0.5;       % Üst nokta
        ];

        % Üçgen prizmanın boyu (gövdenin uzunluğu)
        length = 2;  % Aracın uzunluğu
        rear_vertices = base_vertices;  % Arka kısmı orijinde bırak
        front_vertices = base_vertices + [length, 0, 0];  % Ön kısmı ileriye taşı

        % Prizmanın tüm yüzeylerini tanımla
        faces = [
            1, 2, 3;  % Arka üçgen
            4, 5, 6;  % Ön üçgen
            1, 2, 5;  % Alt yan yüzey
            2, 3, 6;  % Sağ yan yüzey
            3, 1, 4;  % Sol yan yüzey
        ];

        % Gövdeyi çiz (üçgen prizma)
        h_body = patch('Vertices', [rear_vertices; front_vertices], ...
                       'Faces', faces, ...
                       'FaceColor', [0, 0.5, 0], 'EdgeColor', 'k');

        % Aracın ön kısmını (baş) işaretle
        h_head = plot3(nan, nan, nan, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

        % Hız bilgisini göstermek için metin
        velocity_text = text(0, 0, 0, '', 'FontSize', 12, 'Color', 'b');
    end

    % Yön vektörünü hesapla (path'in tangenti)
    if size(vehicle_path, 1) > 1
        % Mevcut ve önceki pozisyon arasındaki farkı kullanarak yön vektörü
        direction = vehicle_path(end, :) - vehicle_path(end-1, :);
    else
        % İlk pozisyon için varsayılan yön
        direction = [1, 0, 0];
    end
    
    % Normalize et
    direction = direction / norm(direction);

    % Eğer direction sıfır vektörüyse, birim matris kullan
    if all(direction == 0)
        R = eye(3);  % Sıfır vektör için birim dönüşüm matrisi kullan
    else
        R = vrrotvec2mat(vrrotvec([1 0 0], direction));  % X ekseninden direction vektörüne dönüşüm
    end

    % Gövdenin yeni konumunu ve yönünü hesapla
    transformed_vertices = ([rear_vertices; front_vertices] * R') + vehicle_path(end, :);

    % Gövdeyi güncelle
    set(h_body, 'Vertices', transformed_vertices);

    % Baş kısmını güncelle
    set(h_head, 'XData', vehicle_path(end, 1) + direction(1), ...
                'YData', vehicle_path(end, 2) + direction(2), ...
                'ZData', vehicle_path(end, 3) + direction(3));

    % Hız büyüklüğünü ekranda göster
    velocity_magnitude = norm(velocities(end, :));
    set(velocity_text, 'Position', [vehicle_path(end, 1), vehicle_path(end, 2), vehicle_path(end, 3) + 2], ...
                       'String', sprintf('Velocity = %.2f m/s', velocity_magnitude));

    drawnow;
end
