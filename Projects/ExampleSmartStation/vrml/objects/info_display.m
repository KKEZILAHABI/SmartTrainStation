function display_handles = info_display(position)
    % INFO_DISPLAY Creates an information display board showing train times
    % position: [x, y, z] coordinates for display base
    
    if nargin < 1
        position = [-8, -20, 2]; % Original position
    end
    
    hold on;
    display_handles = struct();
    
    % Mounting bracket/pole
    pole_height = 2.5;
    [x_pole, y_pole, z_pole] = cylinder(0.1, 8);
    display_handles.pole = surf(...
        x_pole + position(1), ...
        y_pole + position(2), ...
        z_pole * pole_height + position(3), ...
        'FaceColor', [0.4 0.4 0.4], ...
        'EdgeColor', 'none');
    
    % Display board - SIMPLIFIED to avoid dimension errors
    board_width = 3;
    board_height = 1.5;
    board_depth = 0.1;
    
    % Create board as a simple patch (4 corners)
    % Front face
    x_board = position(1) + [-board_width/2, board_width/2, board_width/2, -board_width/2];
    y_board = position(2) + [board_depth/2, board_depth/2, board_depth/2, board_depth/2] + 0.2;
    z_board = position(3) + pole_height + [0, 0, board_height, board_height];
    
    display_handles.board = patch(x_board, y_board, z_board, ...
        [0.1 0.1 0.1], 'EdgeColor', 'none');
    
    % Screen area - SIMPLIFIED as patch
    screen_margin = 0.1;
    screen_width = board_width - 2*screen_margin;
    screen_height = board_height - 2*screen_margin;
    
    x_screen = position(1) + [-screen_width/2, screen_width/2, screen_width/2, -screen_width/2];
    y_screen = position(2) + [board_depth/2 + 0.05, board_depth/2 + 0.05, ...
                              board_depth/2 + 0.05, board_depth/2 + 0.05] + 0.2;
    z_screen = position(3) + pole_height + [screen_margin, screen_margin, ...
                                            screen_margin + screen_height, screen_margin + screen_height];
    
    display_handles.screen = patch(x_screen, y_screen, z_screen, ...
        [0 0.3 0], 'EdgeColor', 'none', 'FaceAlpha', 0.8);
    
    % Simulated text lines (static placeholder)
    text_lines = {
        'Next Train:  Platform 1';
        'Destination: Central';
        'Arrival:     14:30';
        'Status:      On Time'
    };
    
    text_x = position(1) - board_width/2 + 0.2;
    text_y = position(2) + 0.25;
    
    for i = 1:length(text_lines)
        text_z = position(3) + pole_height + board_height - 0.3*i;
        display_handles.(['text_', num2str(i)]) = text(...
            text_x, text_y, text_z, ...
            text_lines{i}, ...
            'Color', [0 1 0], ...
            'FontName', 'Monospaced', ...
            'FontSize', 10);
    end
    
    % LED border - simplified as small patches
    led_radius = 0.03;
    corners = [
        -board_width/2 + screen_margin, screen_margin;
        board_width/2 - screen_margin, screen_margin;
        -board_width/2 + screen_margin, board_height - screen_margin;
        board_width/2 - screen_margin, board_height - screen_margin
    ];
    
    for i = 1:size(corners, 1)
        % Create small rectangle instead of sphere to avoid complexity
        led_size = 0.06;
        x_led = position(1) + corners(i,1) + [-led_size/2, led_size/2, led_size/2, -led_size/2];
        y_led = position(2) + 0.2 + [0, 0, 0, 0];
        z_led = position(3) + pole_height + corners(i,2) + [-led_size/2, -led_size/2, led_size/2, led_size/2];
        
        display_handles.(['led_', num2str(i)]) = patch(x_led, y_led, z_led, ...
            [0 1 0], 'EdgeColor', 'none', 'FaceAlpha', 0.6);
    end
    
    % Add frame around screen
    frame_thickness = 0.05;
    x_frame_outer = position(1) + [-board_width/2, board_width/2, board_width/2, -board_width/2];
    x_frame_inner = position(1) + [-board_width/2 + frame_thickness, board_width/2 - frame_thickness, ...
                                   board_width/2 - frame_thickness, -board_width/2 + frame_thickness];
    y_frame = position(2) + 0.2 + [board_depth/2, board_depth/2, board_depth/2, board_depth/2];
    z_frame_outer = position(3) + pole_height + [0, 0, board_height, board_height];
    z_frame_inner = position(3) + pole_height + [frame_thickness, frame_thickness, ...
                                                 board_height - frame_thickness, board_height - frame_thickness];
    
    % Create frame by subtracting inner from outer
    for i = 1:4
        j = mod(i, 4) + 1;
        patch([x_frame_outer(i), x_frame_outer(j), x_frame_inner(j), x_frame_inner(i)], ...
              [y_frame(i), y_frame(j), y_frame(j), y_frame(i)], ...
              [z_frame_outer(i), z_frame_outer(j), z_frame_inner(j), z_frame_inner(i)], ...
              [0.3 0.3 0.3], 'EdgeColor', 'none');
    end
    
    % Collect handles
    all_patches = findobj(gca, 'Type', 'patch');
    all_text = findobj(gca, 'Type', 'text');
    display_handles.all = [all_patches; all_text];
end