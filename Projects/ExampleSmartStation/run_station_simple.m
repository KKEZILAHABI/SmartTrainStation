% RUN_STATION_SIMPLE - Easy runner for the metro station

% Clear everything
close all; clear; clc;

% Add all subfolders to MATLAB path
addpath('vrml');
addpath('vrml/objects');
addpath('scripts');
addpath('scripts/init');
addpath('scripts/interaction');

% Check if we can find the main files
if ~exist('assemble_scene.m', 'file')
    % Try to find it in scripts/init
    if exist('scripts/init/assemble_scene.m', 'file')
        addpath('scripts/init');
    else
        error('Cannot find assemble_scene.m. Make sure you''re in the root folder.');
    end
end

% Run the station
fprintf('=== SMART METRO STATION ===\n');
fprintf('Starting station construction...\n\n');

assemble_scene();

fprintf('\n=== READY ===\n');
fprintf('Click on the figure window, then use:\n');
fprintf('  W/S : Move forward/backward\n');
fprintf('  A/D : Strafe left/right\n');
fprintf('  Q/E : Turn left/right\n');
fprintf('  R/F : Move up/down\n');