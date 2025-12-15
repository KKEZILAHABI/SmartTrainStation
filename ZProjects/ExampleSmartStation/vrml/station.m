function station_handles = station()
    % STATION Creates the main underground station structure
    
    hold on;
    station_handles = struct();

    % Station dimensions
    floor_width = 30;
    floor_length = 100;
    ceiling_height = 8;
    
    % FLOOR
    [x_floor, y_floor] = meshgrid([-floor_width/2, floor_width/2], [-floor_length/2, floor_length/2]);
    z_floor = zeros(size(x_floor));
    station_handles.floor = surf(x_floor, y_floor, z_floor, ...
        'FaceColor', [0.5 0.5 0.5], ...  % Brighter grey
        'EdgeColor', 'none', ...
        'FaceAlpha', 0.9);

    % CEILING
    station_handles.ceiling = surf(x_floor, y_floor, z_floor + ceiling_height, ...
        'FaceColor', [0.4 0.4 0.4], ...
        'EdgeColor', 'none', ...
        'FaceAlpha', 0.8);

    % WALLS
    % Left wall
    [y_wall, z_wall] = meshgrid(linspace(-floor_length/2, floor_length/2, 20), linspace(0, ceiling_height, 10));
    x_wall_left = -floor_width/2 * ones(size(y_wall));
    station_handles.wall_left = surf(x_wall_left, y_wall, z_wall, ...
        'FaceColor', [0.6 0.6 0.6], ...
        'EdgeColor', 'none');

    % Right wall
    x_wall_right = floor_width/2 * ones(size(y_wall));
    station_handles.wall_right = surf(x_wall_right, y_wall, z_wall, ...
        'FaceColor', [0.6 0.6 0.6], ...
        'EdgeColor', 'none');

    % Back wall (far end)
    [x_back, z_back] = meshgrid(linspace(-floor_width/2, floor_width/2, 20), linspace(0, ceiling_height, 10));
    y_back = -floor_length/2 * ones(size(x_back));
    station_handles.wall_back = surf(x_back, y_back, z_back, ...
        'FaceColor', [0.7 0.7 0.7], ...
        'EdgeColor', 'none');

    % Front wall (near end)
    y_front = floor_length/2 * ones(size(x_back));
    station_handles.wall_front = surf(x_back, y_front, z_back, ...
        'FaceColor', [0.7 0.7 0.7], ...
        'EdgeColor', 'none');

    % RAILS
    rail_height = 0.2;
    rail_width = 0.1;
    rail_length = floor_length - 10;
    rail_spacing = 2;

    % Left rail
    [x_rail, y_rail] = meshgrid([-rail_width/2, rail_width/2], linspace(-rail_length/2, rail_length/2, 50));
    z_rail = rail_height * ones(size(x_rail));
    station_handles.rail_left = surf(x_rail - rail_spacing, y_rail, z_rail, ...
        'FaceColor', [0.2 0.2 0.2], ...
        'EdgeColor', 'none');

    % Right rail
    station_handles.rail_right = surf(x_rail + rail_spacing, y_rail, z_rail, ...
        'FaceColor', [0.2 0.2 0.2], ...
        'EdgeColor', 'none');

    % TUNNEL ENTRANCES
    tunnel_radius = 4;
    tunnel_length = 10;
    [theta, z_tunnel] = meshgrid(linspace(0, 2*pi, 20), linspace(-tunnel_length, 0, 10));
    x_tunnel = tunnel_radius * cos(theta);
    y_tunnel = -floor_length/2 * ones(size(x_tunnel)) + z_tunnel;

    station_handles.tunnel_entrance_north = surf(x_tunnel, y_tunnel, z_tunnel + ceiling_height/2, ...
        'FaceColor', [0.4 0.4 0.4], ...
        'EdgeColor', 'none', ...
        'FaceAlpha', 0.7);

    station_handles.tunnel_entrance_south = surf(x_tunnel, y_tunnel + floor_length, z_tunnel + ceiling_height/2, ...
        'FaceColor', [0.4 0.4 0.4], ...
        'EdgeColor', 'none', ...
        'FaceAlpha', 0.7);

    % Add visible floor markings for clarity
    % Yellow platform edge lines
    platform_edge_y = 15;  % Approximate platform location
    
    plot3([-floor_width/2, floor_width/2], [-platform_edge_y, -platform_edge_y], [0.02, 0.02], ...
          'y-', 'LineWidth', 2);
    plot3([-floor_width/2, floor_width/2], [platform_edge_y, platform_edge_y], [0.02, 0.02], ...
          'y-', 'LineWidth', 2);
    
    % White center line
    plot3([0, 0], [-floor_length/2, floor_length/2], [0.02, 0.02], ...
          'w--', 'LineWidth', 1.5);
    
    % Safety/walk lines
    for y_line = -40:10:40
        plot3([-floor_width/2 + 2, floor_width/2 - 2], [y_line, y_line], [0.02, 0.02], ...
              'w-', 'LineWidth', 0.5);
    end

    axis equal;
    grid on;
    xlabel('X (m)');
    ylabel('Y (m)');
    zlabel('Z (m)');
    title('Metro Station Structure');
end