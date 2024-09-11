function underwater_vehicle_simulation()
    % Global parametreleri başlat
    init_parameters();

    % Waypoints tanımlama
    waypoints = [15, 5, -10; 
                 25, 20, -15; 
                 30, 25, -20; 
                 40, 30, -25]; % Waypoints listesi

    % Başlangıç pozisyonu
    f_0 = zeros(12, 1); 

    % Simülasyon zamanı
    dt = 0.1; % Zaman adımı
    t_total = 40; % Toplam simülasyon süresi

    % Boş figürleri hazırla (smooth ve anlık güncellenebilir olacak)
    [fig1, fig2] = setup_plots(waypoints); % Waypoint grafiği ve hız/pozisyon grafiği
    
    % Araç yolu, hız ve açısal hız verileri için boş diziler
    vehicle_path = [];  % X, Y, Z pozisyonları
    times = [];  % Zamanları kaydet
    velocities = [];  % Hız verileri (u, v, w)
    angular_velocities = [];  % Açısal hızlar (p, q, r)

    % Her bir waypoint için simülasyon yapıyoruz
    total_time = 0; % Toplam simülasyon süresi (uç uca ekleyeceğiz)

    for waypoint_index = 1:size(waypoints, 1)
        current_waypoint = waypoints(waypoint_index, :)';
        distance_to_waypoint = norm(current_waypoint - f_0(1:3));  % Mevcut pozisyon ile waypoint arası mesafe

        % Simülasyonu zaman adımlarıyla yürüt ve grafikleri her adımda güncelle
        t_idx = 0;  % Zaman indeksi
        while distance_to_waypoint > 0.5  % Waypoint'e ulaşana kadar çalıştır (Mesafeyi artırdık)
            t_span = total_time:dt:(total_time + dt); % Her adımda sadece dt kadar ilerle
            
            % Anlık çözüm (ODE45)
            [~, g] = ode45(@(t, g) underwater_vehicle_dynamics(t, g, current_waypoint, [0; 0; 0]), t_span, f_0);

            % Verileri kaydet
            vehicle_path = [vehicle_path; g(end, 1:3)];  % X, Y, Z pozisyonları
            times = [times; t_span(end)];  % Zamanı kaydet
            velocities = [velocities; g(end, 7:9)];  % Hız (u, v, w)
            angular_velocities = [angular_velocities; g(end, 10:12)];  % Açısal hızlar (p, q, r)

            % Gerçek zamanlı olarak grafikleri güncelle
            update_real_time_plots(fig1, fig2, vehicle_path, waypoints, times, velocities, angular_velocities);

            % Son durumu bir sonraki adıma geçiş için başlat
            f_0 = g(end, :)';  % Yeni başlangıç durumu

            % Mesafeyi güncelle (waypoint'e yaklaştık mı kontrol edelim)
            distance_to_waypoint = norm(current_waypoint - f_0(1:3));

            % Toplam simülasyon süresini güncelle
            total_time = total_time + dt;
            t_idx = t_idx + 1;
        end
    end
end
