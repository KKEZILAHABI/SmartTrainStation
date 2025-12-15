function first_person_navigation()
    % FIRST_PERSON_NAVIGATION Enables WASD keyboard navigation in the station
    
    % Get current figure and axes
    fig = gcf;
    ax = gca;
    
    % Set initial camera position (person's eye level)
    initial_position = [0, -20, 1.7];
    initial_target = [0, -19, 1.7];  % Looking slightly forward
    
    % Ensure they're distinct
    if isequal(initial_position, initial_target)
        initial_target = initial_target + [0, 1, 0];
    end
    
    campos(ax, initial_position);
    camtarget(ax, initial_target);
    camup(ax, [0 0 1]);
    
    % Movement parameters
    move_speed = 0.8;
    turn_speed = 2.0;
    vertical_limit_low = 1.0;
    vertical_limit_high = 2.5;
    
    % Station boundaries (from original station.m dimensions)
    % Original: floor_width = 30, floor_length = 100
    x_limit = 14;   % Half of 28m width (with margin)
    y_limit = 49;   % Half of 98m length (with margin)
    
    % Key press callback function
    function keyPressed(~, event)
        try
            % Get current camera position and target
            current_pos = campos(ax);
            current_target = camtarget(ax);
            
            % Ensure position and target are distinct
            if norm(current_target - current_pos) < 0.1
                current_target = current_pos + [0, 0.1, 0];
                camtarget(ax, current_target);
            end
            
            % Calculate forward vector
            forward = current_target - current_pos;
            
            % Check for zero or very small vector
            if norm(forward) < 0.001
                forward = [0, 1, 0]; % Default forward direction
            else
                forward = forward / norm(forward);
            end
            
            % Ensure forward is horizontal (no Z component for movement)
            forward(3) = 0;
            if norm(forward) > 0
                forward = forward / norm(forward);
            else
                forward = [0, 1, 0]; % Default if forward becomes [0,0,0]
            end
            
            % Calculate right vector
            right = cross(forward, [0 0 1]);
            if norm(right) > 0
                right = right / norm(right);
            else
                right = [1, 0, 0]; % Default right
            end
            
            % Initialize new positions
            new_pos = current_pos;
            new_target = current_target;
            
            % Process key press
            switch event.Key
                case 'w' % Move forward
                    new_pos = current_pos + forward * move_speed;
                    new_target = current_target + forward * move_speed;
                case 's' % Move backward
                    new_pos = current_pos - forward * move_speed;
                    new_target = current_target - forward * move_speed;
                case 'a' % Strafe left
                    new_pos = current_pos - right * move_speed;
                    new_target = current_target - right * move_speed;
                case 'd' % Strafe right
                    new_pos = current_pos + right * move_speed;
                    new_target = current_target + right * move_speed;
                case 'q' % Look/turn left
                    % Rotate target around position
                    theta = deg2rad(turn_speed);
                    R = [cos(theta), -sin(theta), 0;
                         sin(theta), cos(theta), 0;
                         0, 0, 1];
                    rel_target = current_target - current_pos;
                    % Ensure rel_target is not zero
                    if norm(rel_target) > 0.001
                        new_target = current_pos + (R * rel_target')';
                        new_pos = current_pos;
                    end
                case 'e' % Look/turn right
                    theta = deg2rad(-turn_speed);
                    R = [cos(theta), -sin(theta), 0;
                         sin(theta), cos(theta), 0;
                         0, 0, 1];
                    rel_target = current_target - current_pos;
                    if norm(rel_target) > 0.001
                        new_target = current_pos + (R * rel_target')';
                        new_pos = current_pos;
                    end
                case 'r' % Move up (limited)
                    if current_pos(3) < vertical_limit_high
                        new_pos = current_pos + [0 0 0.3];
                        new_target = current_target + [0 0 0.3];
                    else
                        return;
                    end
                case 'f' % Move down (limited)
                    if current_pos(3) > vertical_limit_low
                        new_pos = current_pos - [0 0 0.3];
                        new_target = current_target - [0 0 0.3];
                    else
                        return;
                    end
                otherwise
                    return; % Ignore other keys
            end
            
            % Ensure new position and target are finite
            if any(~isfinite(new_pos)) || any(~isfinite(new_target))
                warning('Camera position/target contains non-finite values. Resetting.');
                new_pos = [0, -20, 1.7];
                new_target = [0, -19, 1.7];
            end
            
            % Ensure position and target are distinct
            if norm(new_target - new_pos) < 0.1
                % Move target slightly in forward direction
                if norm(forward) > 0
                    new_target = new_pos + forward * 0.1;
                else
                    new_target = new_pos + [0, 0.1, 0];
                end
            end
            
            % Apply boundary limits (stay within station)
            if abs(new_pos(1)) > x_limit
                new_pos(1) = sign(new_pos(1)) * x_limit * 0.95;
                % Also adjust target to maintain direction
                if abs(new_target(1)) > x_limit * 0.95
                    new_target(1) = sign(new_target(1)) * x_limit * 0.95;
                end
            end
            
            if abs(new_pos(2)) > y_limit
                new_pos(2) = sign(new_pos(2)) * y_limit * 0.95;
                if abs(new_target(2)) > y_limit * 0.95
                    new_target(2) = sign(new_target(2)) * y_limit * 0.95;
                end
            end
            
            % Apply vertical limits
            new_pos(3) = max(vertical_limit_low, min(vertical_limit_high, new_pos(3)));
            new_target(3) = max(vertical_limit_low, min(vertical_limit_high, new_target(3)));
            
            % Update camera
            campos(ax, new_pos);
            camtarget(ax, new_target);
            
            % Redraw
            drawnow;
            
        catch ME
            % If any error occurs, reset to safe position
            warning('Navigation error occurred. Resetting camera.');
            campos(ax, [0, -20, 1.7]);
            camtarget(ax, [0, -19, 1.7]);
            drawnow;
        end
    end
    
    % Set up key press callback
    set(fig, 'KeyPressFcn', @keyPressed);
    
    % Display instructions
    disp('First-person navigation enabled:');
    disp('W/S: Move forward/backward');
    disp('A/D: Strafe left/right');
    disp('Q/E: Turn left/right');
    disp('R/F: Move up/down (limited)');
    disp('Click on figure window to activate keyboard control');
    
    % Set figure to focus for keyboard input
    figure(fig);
end