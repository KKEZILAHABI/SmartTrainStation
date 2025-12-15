function station()
% Floor
patch([-30 30 30 -30],[-10 -10 10 10],[0 0 0 0],...
    [0.4 0.4 0.4],'EdgeColor','none')

% Walls
patch([-30 30 30 -30],[-10 -10 -10 -10],[0 0 5 5],...
    [0.6 0.6 0.6],'EdgeColor','none')
patch([-30 30 30 -30],[10 10 10 10],[0 0 5 5],...
    [0.6 0.6 0.6],'EdgeColor','none')
end
