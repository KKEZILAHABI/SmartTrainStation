function assemble_scene()
    % ASSEMBLE_SCENE Creates the complete static station
    
    close all; clear; clc;
    
    fprintf('Creating Smart Metro Station...\n');
    
    % Create figure
    fig = figure('Name', 'Smart Metro Station', ...
                 'NumberTitle', 'off', ...
                 'Position', [100, 100, 1200, 800], ...
                 'Color', [0.9 0.9 0.9]);
    
    ax = axes('Parent', fig);
    hold(ax, 'on');
    grid(ax, 'on');
    axis(ax, 'equal');
    view(ax, -40, 25);  % Good overview angle
    
    % Add all folders to path
    addpath('vrml');
    addpath('vrml/objects');
    addpath('scripts');
    addpath('scripts/interaction');
    
    % ------------------ CREATE STATION ------------------
    fprintf('Building station structure...\n');
    station_h = station();
    
    fprintf('Adding platform...\n');
    platform_h = platform();
    
    fprintf('Installing lighting...\n');
    light_h = setup_lights();
    
    % ------------------ CREATE OBJECTS ------------------
    fprintf('Placing ticket machines...\n');
    ticket_h1 = ticket_machine([8, -25, 0]);
    ticket_h2 = ticket_machine([8, 15, 0]);
    
    fprintf('Installing information displays...\n');
    display_h1 = info_display([-8, -20, 2]);
    display_h2 = info_display([-8, 25, 2]);
    
    fprintf('Installing platform screen doors...\n');
    door_h = doors();
    
    % ------------------ CREATE STATIC TRAIN ------------------
    fprintf('Creating static train (3 cars)...\n');
    
    % Train parameters - VISIBLE COLORS
    train_color = [0.9 0.2 0.2];  % Bright red
    car_length = 8;
    car_width = 2.4;
    car_height = 3.2;
    gap_between_cars = 0.5;
    
    % Create 3 cars
    for car_num = 1:3
        car_x = 0;
        car_y = -40 + (car_num-1)*(car_length + gap_between_cars);
        car_z = 0.5;
        
        % Car body
        [x_car, y_car] = meshgrid([-car_width/2, car_width/2], [0, car_length]);
        z_car = [0, 0; car_height, car_height];
        
        surf(ax, x_car + car_x, y_car + car_y, z_car + car_z, ...
            'FaceColor', train_color, ...
            'EdgeColor', 'k', ...
            'LineWidth', 1, ...
            'FaceAlpha', 0.95);
        
        % Windows
        for win = 1:4
            win_y = car_length/4 * (win-0.5);
            [x_win, y_win] = meshgrid([-1, 1], [win_y-0.3, win_y+0.3]);
            z_win = [1.5, 1.5; 2.7, 2.7];
            
            surf(ax, x_win + car_x, y_win + car_y, z_win + car_z, ...
                'FaceColor', [0.8 0.9 1], ...
                'EdgeColor', 'k', ...
                'LineWidth', 0.5);
        end
        
        % Wheels
        for side = [-1, 1]
            for axle = [1/3, 2/3]
                [theta, z_wheel] = meshgrid(linspace(0, 2*pi, 16), [-0.15, 0.15]);
                x_wheel = 0.4 * cos(theta);
                y_wheel = car_length * axle * ones(size(x_wheel));
                
                surf(ax, x_wheel + car_x + side*0.8, y_wheel + car_y, z_wheel + car_z, ...
                    'FaceColor', [0.1 0.1 0.1], ...
                    'EdgeColor', [0.3 0.3 0.3]);
            end
        end
        
        % Car number
        text(car_x, car_y + car_length/2, car_z + car_height + 0.3, ...
            sprintf('CAR %d', car_num), ...
            'Color', 'white', ...
            'FontSize', 10, ...
            'FontWeight', 'bold', ...
            'HorizontalAlignment', 'center');
    end
    
    % Train label
    text(0, -30, 5, 'METRO TRAIN', ...
        'Color', [1 1 0], ...
        'FontSize', 14, ...
        'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center');
    
    % ------------------ FINAL TOUCHES ------------------
    xlabel('X (m)');
    ylabel('Y (m)');
    zlabel('Z (m)');
    title('Smart Metro Station - Use WASD to Navigate', 'FontSize', 14);
    
    % Lighting
    lighting gouraud;
    material shiny;
    
    % Axis limits
    axis([-20 20 -60 60 0 10]);
    
    fprintf('Station creation complete!\n');
    
    % ------------------ ENABLE NAVIGATION ------------------
    fprintf('\nEnabling first-person navigation...\n');
    first_person_navigation();
    
    fprintf('\n=== NAVIGATION CONTROLS ===\n');
    fprintf('W/S: Move forward/backward\n');
    fprintf('A/D: Strafe left/right\n');
    fprintf('Q/E: Turn left/right\n');
    fprintf('R/F: Move up/down\n');
    fprintf('Click on figure window first!\n');
    
    hold(ax, 'off');
end