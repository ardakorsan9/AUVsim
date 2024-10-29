function g_dot = underwater_vehicle_dynamics(t, g, desired_position, desired_orientation)
    global m W B Ixx Iyy Izz
    global xg yg zg
    global Xudot Yvdot Yrdot Zwdot Zqdot Kpdot Mwdot Mqdot Nvdot Nrdot
    global Xuu Yvv Zww Xwq Xvr Yrr Yur Ywp Zqq Zuq Zvp Zrp Kpp Mww Mqq Mrp Muq Muw Mvp Nvv Nrr Nuv Npq Nwp Nur 
    global Xqq Xrr Ypq Yuv Zuw
    global yb zb xb desired_velocity

    % Durum değişkenlerini çıkarma
    x = g(1); y = g(2); z = g(3);
    phi = g(4); theta = g(5); psi = g(6);
    u = g(7); v = g(8); w = g(9);
    p = g(10); q = g(11); r = g(12);


    % Kontrol sinyallerini hesapla (control_signals.m dosyasından)
    [position_control, orientation_control] = control_signals(g, desired_position, desired_orientation);    

    % Pozisyon hatasını ekrana bastır
%     current_position = [x; y; z];
%     position_error = desired_position - current_position;
%     disp('Desired Position:'); disp(desired_position');
%     disp('CurrentPosition:'); disp(current_position');
%     disp('Position Error:'); disp(position_error');
     
    % Kuvvetler ve moment hesaplamaları
    X = (W - B) * sin(theta) + Xuu * u * abs(u) + (Xwq - m) * w * q + (Xvr + m) * v * r + (Xqq + m * xg) * q^2 + (Xrr + m * xg) * r^2 - m * yg * p * q - m * zg * p * r + position_control(1);
    Y = -(W - B) * cos(theta) * sin(phi) + Yvv * v * abs(v) + Yrr * r * abs(r) + (Yur - m) * u * r + (Ywp - m) * w * p + (Ypq - m * xg) * p * q + m * zg * q * r + m * yg * p^2 + Yuv * u * v + position_control(2);
    Z = -(W - B) * cos(theta) * cos(phi) + Zww * w * abs(w) + Zqq * q * abs(q) + (Zuq + m) * u * q + (Zvp - m) * v * p + (Zrp - m * xg) * r * p - m * yg * r * q + m * zg * p^2 + m * zg * q^2 + Zuw * u * w + position_control(3);
    K = -(yg*W-yb*B)*cos(theta)*cos(phi) + (zg*W-zb*B)*cos(theta)*sin(phi) + Kpp * p * abs(p) + (Iyy - Izz) * q * r - m * v * p + m * u * q - m * zg * w * p + m * zg * u * r + orientation_control(1);
    M = (zg*W-zb*B)*sin(theta) + (xg*W-xb*B)*cos(theta)*cos(phi) + Mww * w * abs(w) + Mqq * q * abs(q) + (Mvp + m * xg) * v * p + (Mrp - Ixx + Izz) * r * p + (Muq - m * xg) * u * q + Muw * u * w + m * zg * r * v - m * zg * q * w + orientation_control(2);
    N = -(xg*W-xb*B)*cos(theta)*sin(phi) - (yg*W-yb*B)*sin(theta) + Nvv * v * abs(v) + Nrr * r * abs(r) + (Nwp + m * xg) * w * p + (Npq - Iyy + Ixx) * p * q + (Nur - m * xg) * u * r + Nuv * u * v + m * yg * q * w - m * yg * r * v + orientation_control(3);

    % Sistem dinamikleri matrisi A ve kuvvet/moment vektörü J
    A = [m - Xudot, 0, 0, 0, m * zg, -m * yg;
         0, m - Yvdot, 0, -m * zg, 0, m * xg - Yrdot;
         0, 0, m - Zwdot, m * yg, -m * xg - Zqdot, 0;
         0, -m * zg, m * yg, Ixx - Kpdot, 0, 0;
         m * zg, 0, -m * xg - Mwdot, 0, Iyy - Mqdot, 0;
         -m * yg, m * xg - Nvdot, 0, 0, 0, Izz - Nrdot];
    J = [X; Y; Z; K; M; N];

    % Lineer sistemi çöz
    C = A\J;

    % Rotasyon matrisi - body rate'leri Euler açı oranlarına çevirme
    R = [cos(psi)*cos(theta), cos(psi)*sin(theta)*sin(phi) - sin(psi)*cos(phi), cos(psi)*sin(theta)*cos(phi) + sin(psi)*sin(phi);
         sin(psi)*cos(theta), sin(psi)*sin(theta)*sin(phi) + cos(psi)*cos(phi), sin(psi)*sin(theta)*cos(phi) - cos(psi)*sin(phi);
         -sin(theta), cos(theta)*sin(phi), cos(theta)*cos(phi)];

    % Euler matrisi - açısal hız dönüşümü
    JJ = [1, sin(phi)*tan(theta), cos(phi)*tan(theta); 
          0, cos(phi), -sin(phi); 
          0, sin(phi)/cos(theta), cos(phi)/cos(theta)];

    % Durum türevlerini güncelle
    g_dot = zeros(12, 1);
    g_dot(1:3) = R * [u; v; w];  % Pozisyon türevleri hızlardır
    g_dot(4:6) = JJ * [p; q; r];  % Oryantasyon türevleri açısal hızlardır
    g_dot(7:9) = [C(1); C(2); C(3)];  % Hız türevleri
    g_dot(10:12) = C(4:6);  % Açısal hız türevleri

    return
end