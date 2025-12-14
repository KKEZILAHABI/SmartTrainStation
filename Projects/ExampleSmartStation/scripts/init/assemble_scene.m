function assemble_scene()
    % ASSEMBLE_SCENE Creates the complete static station with train and enables navigation
    
    close all; clear; clc;
    
    fprintf('Creating Smart Metro Station...\n');
    
    % Create figure
    fig = figure('Name', 'Smart Metro Station', ...
                 'NumberTitle', 'off', ...
                 'Position', [100, 100, 1200, 800], ...
                 'Color', [0.1 0.1 0.1]);
    ax = axes('Parent', fig);
    hold(ax, 'on');
    grid(ax, 'on');
    axis(ax, 'equal');
    view(ax, 3);
    
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
    light_h = setup_lights();  % CHANGED: lighting -> setup_lights

        % Store station boundaries for navigation
    station_width = 30;  % From station.m: floor_width = 30
    station_length = 100; % From station.m: floor_length = 100
    setappdata(fig, 'station_boundaries', [station_width/2, station_length/2]);
    
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
    
    % Train parameters
    train_color = [0.2 0.2 0.8]; % Dark blue
    car_length = 8;
    car_width = 2.4;
    car_height = 3.2;
    gap_between_cars = 0.5;
    
    % Create 3 cars parked at platform
    for car_num = 1:3
        % Car position (centered at platform)
        car_x = 0; % Centered on tracks
        car_y = -40 + (car_num-1)*(car_length + gap_between_cars);
        car_z = 0.5; % On tracks
        
        % Car body
        [x_car, y_car] = meshgrid(...
            [-car_width/2, car_width/2], ...
            [0, car_length]);
        z_car = [0, 0; car_height, car_height];
        
        surf(ax, ...
            x_car + car_x, ...
            y_car + car_y, ...
            z_car + car_z, ...
            'FaceColor', train_color, ...
            'EdgeColor', 'none', ...
            'FaceAlpha', 0.9);
        
        % Windows
        window_height = 1.2;
        window_bottom = 1.5;
        num_windows = 4;
        
        for win = 1:num_windows
            win_y = car_length/num_windows * (win-0.5);
            win_width = car_width - 0.4;
            
            [x_win, y_win] = meshgrid(...
                [-win_width/2, win_width/2], ...
                [win_y-0.4, win_y+0.4]);
            z_win = [window_bottom, window_bottom; 
                     window_bottom + window_height, window_bottom + window_height];
            
            surf(ax, ...
                x_win + car_x, ...
                y_win + car_y, ...
                z_win + car_z, ...
                'FaceColor', [0.7 0.9 1], ... % Light blue
                'EdgeColor', 'none', ...
                'FaceAlpha', 0.7);
        end
        
        % Wheels
        wheel_radius = 0.4;
        wheel_width = 0.3;
        wheel_positions = [-0.8, 0.8]; % Left/right
        
        for side = 1:2
            for axle = 1:2
                axle_y = car_length/3 * axle;
                
                [theta, z_wheel] = meshgrid(linspace(0, 2*pi, 16), ...
                                           [-wheel_width/2, wheel_width/2]);
                x_wheel = wheel_radius * cos(theta);
                y_wheel = axle_y * ones(size(x_wheel));
                
                surf(ax, ...
                    x_wheel + car_x + wheel_positions(side), ...
                    y_wheel + car_y, ...
                    z_wheel + car_z, ...
                    'FaceColor', [0.1 0.1 0.1], ...
                    'EdgeColor', 'none');
            end
        end
    end
    
    % Train label
    text(ax, 0, -30, 4, 'STATIC TRAIN', ...
        'Color', 'white', ...
        'FontSize', 12, ...
        'HorizontalAlignment', 'center');
    
    % ------------------ FINAL TOUCHES ------------------
    % Set axes properties
    xlabel(ax, 'X (m)');
    ylabel(ax, 'Y (m)');
    zlabel(ax, 'Z (m)');
    title(ax, 'Smart Metro Station - Static Scene', 'Color', 'white');
    
    % Set view
    view(ax, -30, 20);
    axis(ax, 'vis3d');
    
    % Adjust lighting - USE MATLAB'S BUILT-IN lighting() FUNCTION
    lighting(ax, 'gouraud');  % This is MATLAB's built-in function
    material(ax, 'dull');
    
    % Set reasonable axis limits
    axis(ax, [-20 20 -50 50 0 10]);
    
    fprintf('Station creation complete!\n');
    fprintf('Train created with 3 static cars.\n');
    
    % ------------------ ENABLE NAVIGATION ------------------
    fprintf('\nEnabling first-person navigation...\n');
    first_person_navigation();
    
    fprintf('\nUse WASD keys to navigate the station.\n');
    fprintf('Click on the figure window first to activate keyboard control.\n');
    
    hold(ax, 'off');
end