function ticket_machine_handle = ticket_machine(position)
    % TICKET_MACHINE Creates a static ticket vending machine
    % position: [x, y, z] coordinates for machine base
    
    if nargin < 1
        position = [8, -10, 0]; % Default position (right side, near entrance)
    end
    
    hold on;
    ticket_machine_handle = struct();
    
    % Main body
    body_width = 1.2;
    body_depth = 0.8;
    body_height = 1.8;
    
    % Create body using patch for better control
    % Front face
    x_front = [0, body_width, body_width, 0] + position(1);
    y_front = [0, 0, 0, 0] + position(2);
    z_front = [0, 0, body_height, body_height] + position(3);
    ticket_machine_handle.front = patch(x_front, y_front, z_front, ...
        [0.8 0.8 0.9], 'EdgeColor', 'k', 'LineWidth', 1);
    
    % Back face
    x_back = [0, body_width, body_width, 0] + position(1);
    y_back = [body_depth, body_depth, body_depth, body_depth] + position(2);
    z_back = [0, 0, body_height, body_height] + position(3);
    ticket_machine_handle.back = patch(x_back, y_back, z_back, ...
        [0.7 0.7 0.8], 'EdgeColor', 'k', 'LineWidth', 1);
    
    % Top face
    x_top = [0, body_width, body_width, 0] + position(1);
    y_top = [0, 0, body_depth, body_depth] + position(2);
    z_top = [body_height, body_height, body_height, body_height] + position(3);
    ticket_machine_handle.top = patch(x_top, y_top, z_top, ...
        [0.6 0.6 0.7], 'EdgeColor', 'k', 'LineWidth', 1);
    
    % Screen area - FIXED DIMENSIONS
    screen_width = 0.8;
    screen_height = 0.6;
    screen_bottom = 1.2;
    screen_protrusion = 0.05; % How much it sticks out
    
    % Screen front surface
    screen_x = position(1) + body_width/2 + [-screen_width/2, screen_width/2];
    screen_y = position(2) + [screen_protrusion, screen_protrusion];
    [screen_X, screen_Y] = meshgrid(screen_x, screen_y);
    screen_Z = [screen_bottom, screen_bottom; 
                screen_bottom + screen_height, screen_bottom + screen_height] + position(3);
    
    ticket_machine_handle.screen = surf(screen_X, screen_Y, screen_Z, ...
        'FaceColor', [0.1 0.1 0.2], 'EdgeColor', 'none', 'FaceAlpha', 0.9);
    
    % Screen sides (to give 3D thickness)
    % Left side of screen
    patch([screen_x(1), screen_x(1), screen_x(1), screen_x(1)] + position(1), ...
          [0, screen_protrusion, screen_protrusion, 0] + position(2), ...
          [screen_bottom, screen_bottom, screen_bottom + screen_height, screen_bottom + screen_height] + position(3), ...
          [0.15 0.15 0.25], 'EdgeColor', 'none');
    
    % Right side of screen
    patch([screen_x(2), screen_x(2), screen_x(2), screen_x(2)] + position(1), ...
          [0, screen_protrusion, screen_protrusion, 0] + position(2), ...
          [screen_bottom, screen_bottom, screen_bottom + screen_height, screen_bottom + screen_height] + position(3), ...
          [0.15 0.15 0.25], 'EdgeColor', 'none');
    
    % Ticket slot - SIMPLIFIED
    slot_width = 0.3;
    slot_height = 0.05;
    slot_bottom = 0.5;
    
    slot_x = position(1) + body_width/2 + [-slot_width/2, slot_width/2];
    slot_y = position(2) + [0.75, 0.8];
    [slot_X, slot_Y] = meshgrid(slot_x, slot_y);
    slot_Z = [slot_bottom, slot_bottom; 
              slot_bottom + slot_height, slot_bottom + slot_height] + position(3);
    
    ticket_machine_handle.slot = surf(slot_X, slot_Y, slot_Z, ...
        'FaceColor', [0.3 0.3 0.3], 'EdgeColor', 'none');
    
    % Payment panel (buttons/coins) - SIMPLIFIED
    panel_width = 0.6;
    panel_height = 0.4;
    panel_bottom = 0.8;
    
    panel_x = position(1) + body_width/2 + [-panel_width/2, panel_width/2];
    panel_y = position(2) + [0.75, 0.8];
    [panel_X, panel_Y] = meshgrid(panel_x, panel_y);
    panel_Z = [panel_bottom, panel_bottom; 
               panel_bottom + panel_height, panel_bottom + panel_height] + position(3);
    
    ticket_machine_handle.panel = surf(panel_X, panel_Y, panel_Z, ...
        'FaceColor', [0.9 0.9 0.7], 'EdgeColor', 'k');
    
    % Add some buttons to panel
    button_radius = 0.05;
    button_positions = [-0.2, 0, 0.2]; % X offsets from center
    
    for i = 1:length(button_positions)
        [theta, phi] = meshgrid(linspace(0, 2*pi, 8), linspace(0, pi/2, 4));
        button_x = button_radius * cos(theta) .* sin(phi);
        button_y = button_radius * sin(theta) .* sin(phi);
        button_z = button_radius * cos(phi);
        
        % Position button on panel
        button_x = button_x + position(1) + body_width/2 + button_positions(i);
        button_y = button_y + position(2) + 0.775; % Middle of panel depth
        button_z = button_z + position(3) + panel_bottom + panel_height/2;
        
        surf(button_x, button_y, button_z, ...
            'FaceColor', [0.2 0.2 0.2], 'EdgeColor', 'none');
    end
    
    % Coin slot
    coin_width = 0.1;
    coin_height = 0.15;
    coin_x = position(1) + body_width/2 + 0.25;
    coin_y = position(2) + 0.775;
    
    patch([coin_x, coin_x + coin_width, coin_x + coin_width, coin_x], ...
          [coin_y, coin_y, coin_y, coin_y], ...
          [panel_bottom + 0.1, panel_bottom + 0.1, panel_bottom + 0.1 + coin_height, panel_bottom + 0.1 + coin_height] + position(3), ...
          [0.5 0.5 0.5], 'EdgeColor', 'none');
    
    % Collect all handles
    all_surfaces = findobj(gca, 'Type', 'surface');
    all_patches = findobj(gca, 'Type', 'patch');
    ticket_machine_handle.all = [all_surfaces; all_patches];
    ticket_machine_handle.position = position;
    
    % Add some text label
    text(position(1) + body_width/2, position(2) + body_depth/2, position(3) + body_height + 0.1, ...
        'TICKETS', 'Color', 'white', 'FontSize', 8, 'HorizontalAlignment', 'center');
end