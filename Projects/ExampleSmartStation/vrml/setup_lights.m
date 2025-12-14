function light_handles = setup_lights()
    % SETUP_LIGHTS Sets up artificial lighting for the underground station
    % Limited to 8 lights (MATLAB maximum)
    % Renamed from lighting.m to avoid conflict with MATLAB's lighting() function
    
    hold on;
    light_handles = struct();
    
    % Remove default lighting
    delete(findobj(gca, 'Type', 'light'));
    
    % ------------------ KEY LIGHTS ONLY (8 MAX) ------------------
    
    % 1-2: Main overhead lights (most important)
    light_handles.main1 = light('Position', [0, -20, 8], 'Style', 'local', 'Color', [1 1 0.9]);
    light_handles.main2 = light('Position', [0, 20, 8], 'Style', 'local', 'Color', [1 1 0.9]);
    
    % 3-4: Platform lights
    light_handles.platform1 = light('Position', [-10, 0, 3], 'Style', 'local', 'Color', [1 1 0.8]);
    light_handles.platform2 = light('Position', [-10, 30, 3], 'Style', 'local', 'Color', [1 1 0.8]);
    
    % 5-6: Emergency lights (dimmer)
    light_handles.emergency1 = light('Position', [12, -45, 6], 'Style', 'local', 'Color', [1 0.3 0.3]);
    light_handles.emergency2 = light('Position', [12, 45, 6], 'Style', 'local', 'Color', [1 0.3 0.3]);
    
    % 7-8: Fill lights for shadows
    light_handles.fill1 = light('Position', [0, 0, 5], 'Style', 'local', 'Color', [0.8 0.8 1]);
    light_handles.fill2 = light('Position', [0, 0, 10], 'Style', 'infinite', 'Color', [0.7 0.7 0.7]);
    
    % ------------------ LIGHT FIXTURES (VISUAL ONLY - NO ACTUAL LIGHT) ------------------
    % Create light fixture visuals that don't create actual light objects
    
    % Overhead light fixtures (visual only)
    light_length = 4;
    light_radius = 0.1;
    light_positions_y = [-40, -20, 0, 20, 40];
    
    for i = 1:length(light_positions_y)
        [x_cyl, y_cyl, z_cyl] = cylinder(light_radius, 20);
        z_cyl = z_cyl * light_length;
        y_cyl = y_cyl + light_positions_y(i);
        x_cyl = x_cyl - 0.5;
        
        R = makehgtform('xrotate', pi/2);
        t = hgtransform('Parent', gca);
        set(t, 'Matrix', R);
        
        surf(x_cyl, y_cyl, z_cyl + 7.5, ...
            'FaceColor', [1 1 0.8], ...
            'EdgeColor', 'none', ...
            'FaceAlpha', 0.4, ...
            'Parent', t);
    end
    
    % Store light object handles
    all_lights = findobj(gca, 'Type', 'light');
    light_handles.all_lights = all_lights;
    
    fprintf('Created %d light sources (MATLAB max: 8)\n', length(all_lights));
end