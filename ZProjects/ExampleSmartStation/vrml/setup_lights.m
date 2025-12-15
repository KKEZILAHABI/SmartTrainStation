function light_handles = setup_lights()
    % SETUP_LIGHTS Sets up bright lighting
    
    hold on;
    light_handles = struct();
    
    % Remove default lighting
    delete(findobj(gca, 'Type', 'light'));
    
    % BRIGHT LIGHTS
    light_handles.main1 = light('Position', [0, -30, 8], 'Style', 'local', 'Color', [1 1 1]);
    light_handles.main2 = light('Position', [0, 30, 8], 'Style', 'local', 'Color', [1 1 1]);
    light_handles.platform1 = light('Position', [-8, -15, 4], 'Style', 'local', 'Color', [1 1 0.9]);
    light_handles.platform2 = light('Position', [-8, 15, 4], 'Style', 'local', 'Color', [1 1 0.9]);
    light_handles.fill1 = light('Position', [10, 0, 6], 'Style', 'local', 'Color', [0.9 0.9 1]);
    light_handles.fill2 = light('Position', [-10, 0, 6], 'Style', 'local', 'Color', [0.9 0.9 1]);
    light_handles.ambient1 = light('Position', [0, 0, 12], 'Style', 'infinite', 'Color', [0.8 0.8 0.9]);
    light_handles.ambient2 = light('Position', [0, 50, 5], 'Style', 'infinite', 'Color', [0.7 0.7 0.8]);
    
    % Visible light fixtures
    for y_pos = [-40, -20, 0, 20, 40]
        [x_cyl, y_cyl, z_cyl] = cylinder(0.1, 16);
        surf(x_cyl - 0.5, y_cyl + y_pos, z_cyl*3 + 7, ...
            'FaceColor', [1 1 0.8], ...
            'EdgeColor', 'none', ...
            'FaceAlpha', 0.6);
    end
    
    fprintf('Created 8 bright light sources\n');
end