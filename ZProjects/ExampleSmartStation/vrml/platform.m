function platform_handles = platform()
    % PLATFORM Creates the station platform alongside the tracks
    % Returns handles to platform components

    hold on;
    platform_handles = struct();

    % Platform dimensions
    platform_width = 5;
    platform_length = 30;
    platform_height = 0.5;
    
    % Platform position (left side of tracks)
    platform_x = -2.5; % Offset from center
    
    % Main platform surface
    [x_plat, y_plat] = meshgrid(...
        [platform_x, platform_x + platform_width], ...
        linspace(-platform_length/2, platform_length/2, 20));
    z_plat = platform_height * ones(size(x_plat));
    
    platform_handles.surface = surf(x_plat, y_plat, z_plat, ...
        'FaceColor', [0.7 0.7 0.7], ...
        'EdgeColor', 'none', ...
        'FaceAlpha', 0.9);
    
    % Platform edges (kerb)
    edge_height = 0.2;
    edge_width = 0.1;
    
    % Inner edge (facing tracks)
    y_edge = linspace(-platform_length/2, platform_length/2, 50);
    x_edge_inner = (platform_x + platform_width) * ones(size(y_edge));
    z_edge_bottom = platform_height * ones(size(y_edge));
    z_edge_top = (platform_height + edge_height) * ones(size(y_edge));
    
    for i = 1:length(y_edge)-1
        x_patch = [x_edge_inner(i), x_edge_inner(i+1), x_edge_inner(i+1), x_edge_inner(i)];
        y_patch = [y_edge(i), y_edge(i+1), y_edge(i+1), y_edge(i)];
        z_patch = [z_edge_bottom(i), z_edge_bottom(i+1), z_edge_top(i+1), z_edge_top(i)];
        
        patch(x_patch, y_patch, z_patch, ...
            [0.9 0.9 0.3], ... % Yellow safety edge
            'EdgeColor', 'none', ...
            'FaceAlpha', 0.8);
    end
    
    % Platform pillars/supports
    pillar_radius = 0.3;
    pillar_height = platform_height;
    [theta, z_pillar] = meshgrid(linspace(0, 2*pi, 8), linspace(0, pillar_height, 3));
    
    pillar_positions = [-10, -5, 0, 5, 10]; % Y positions
    
    for i = 1:length(pillar_positions)
        x_pillar = pillar_radius * cos(theta) + platform_x + platform_width/2;
        y_pillar = pillar_positions(i) * ones(size(x_pillar));
        
        platform_handles.(['pillar_', num2str(i)]) = surf(x_pillar, y_pillar, z_pillar, ...
            'FaceColor', [0.5 0.3 0.2], ...
            'EdgeColor', 'none');
    end
    
    % Platform signage (simple poles)
    sign_height = 3;
    for i = 1:3
        y_sign = -platform_length/2 + i * platform_length/4;
        plot3([platform_x + platform_width/2, platform_x + platform_width/2], ...
              [y_sign, y_sign], ...
              [platform_height, platform_height + sign_height], ...
              'k-', 'LineWidth', 2);
    end
    
    axis equal;
end