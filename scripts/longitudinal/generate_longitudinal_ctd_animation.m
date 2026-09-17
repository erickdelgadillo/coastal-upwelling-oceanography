function outputFiles = generate_longitudinal_ctd_animation(outputDir)
%GENERATE_LONGITUDINAL_CTD_ANIMATION Animate the available daily CTD transects.
%   GENERATE_LONGITUDINAL_CTD_ANIMATION creates two GIF files containing
%   temperature, salinity, fluorescence, turbidity, and PAR panels. One GIF
%   uses the historical jet palette and the other uses variable-appropriate
%   cmocean palettes. Each frame represents one sampled transect day.
%
%   OUTPUTFILES = GENERATE_LONGITUDINAL_CTD_ANIMATION(OUTPUTDIR) writes the
%   animations below a custom directory and returns their paths.

scriptDir = fileparts(mfilename('fullpath'));
repoRoot = fileparts(fileparts(scriptDir));
dataDir = fullfile(repoRoot, 'data', 'longitudinal', 'daily_ctd');

if nargin < 1 || isempty(outputDir)
    outputDir = fullfile(repoRoot, 'figures', 'longitudinal', 'animations');
end

if ~isfolder(dataDir)
    error('Daily longitudinal input directory not found: %s', dataDir);
end
if ~isfolder(outputDir)
    mkdir(outputDir);
end

addpath(fullfile(repoRoot, 'third_party'));

campaigns(1) = dailyCampaign('winter', 'Winter', 'ENV1', ...
    compose('ctd_env1_d%d.csv', 1:8));
campaigns(2) = dailyCampaign('spring', 'Spring', 'ENV2', ...
    compose('ctd_env2_d%d.xlsx', [1, 3, 5, 7]));
campaigns(3) = dailyCampaign('summer', 'Summer', 'ENV3', ...
    [compose('ctd_env3_d%d.xlsx', [1, 3, 5]), "ctd_env3_d7.csv"]);

variables = [ ...
    animationVariable('temp', 'Temperature (^{\circ}C)', ...
        [12, 16], 'thermal'), ...
    animationVariable('sal', 'Salinity (PSU)', ...
        [34, 36], 'haline'), ...
    animationVariable('fluo', 'Fluorescence (\mug L^{-1})', ...
        [-0.11, 10], 'algae'), ...
    animationVariable('turb', 'Turbidity (NTU)', ...
        [-0.09, 4], 'turbid'), ...
    animationVariable('par', ...
        'PAR (\mumol photons m^{-2} s^{-1})', ...
        [0.0001, 100], 'solar')];

paletteModes = {'original', 'cmocean'};
outputFiles = cell(1, numel(paletteModes));

for modeIndex = 1:numel(paletteModes)
    paletteMode = paletteModes{modeIndex};
    outputFile = fullfile(outputDir, sprintf( ...
        'longitudinal_ctd_daily_%s.gif', paletteMode));
    if isfile(outputFile)
        delete(outputFile);
    end

    frameIndex = 0;
    for campaignIndex = 1:numel(campaigns)
        campaign = campaigns(campaignIndex);
        for fileIndex = 1:numel(campaign.files)
            inputFile = fullfile(dataDir, campaign.files(fileIndex));
            if ~isfile(inputFile)
                error('Daily CTD input not found: %s', inputFile);
            end

            data = readDailyCtd(inputFile);
            validateColumns(data, ...
                [{'day', 'Longitude', 'Latitude', 'depth'}, ...
                {variables.column}]);
            sampledDays = unique(data.day(isfinite(data.day)));
            if numel(sampledDays) ~= 1
                error('Expected one sampling day in %s.', inputFile);
            end
            sampledDay = sampledDays(1);

            figureHandle = createAnimationFrame(data, variables, campaign, ...
                sampledDay, paletteMode);
            figureCleanup = onCleanup(@() close(figureHandle));

            temporaryPng = [tempname, '.png'];
            pngCleanup = onCleanup(@() deleteIfPresent(temporaryPng));
            exportgraphics(figureHandle, temporaryPng, ...
                'Resolution', 110, 'BackgroundColor', 'white');
            rgbFrame = imread(temporaryPng);
            [indexedFrame, colourMap] = rgb2ind(rgbFrame, 256);

            frameIndex = frameIndex + 1;
            if frameIndex == 1
                imwrite(indexedFrame, colourMap, outputFile, 'gif', ...
                    'LoopCount', Inf, 'DelayTime', 1.2);
            else
                imwrite(indexedFrame, colourMap, outputFile, 'gif', ...
                    'WriteMode', 'append', 'DelayTime', 1.2);
            end

            clear pngCleanup figureCleanup
        end
    end

    outputFiles{modeIndex} = outputFile;
    fprintf('Created %d-frame animation:\n  %s\n', frameIndex, outputFile);
end
end

function campaign = dailyCampaign(id, label, cruise, files)
campaign = struct( ...
    'id', id, ...
    'label', label, ...
    'cruise', cruise, ...
    'files', string(files));
end

function variable = animationVariable(column, label, limits, palette)
variable = struct( ...
    'column', column, ...
    'label', label, ...
    'limits', limits, ...
    'palette', palette);
end

function data = readDailyCtd(inputFile)
[~, ~, extension] = fileparts(inputFile);
if strcmpi(extension, '.csv')
    data = readtable(inputFile, ...
        'Delimiter', ';', 'VariableNamingRule', 'preserve');
else
    data = readtable(inputFile, 'VariableNamingRule', 'preserve');
end
end

function figureHandle = createAnimationFrame(data, variables, campaign, ...
    sampledDay, paletteMode)
depthLimit = 260;

figureHandle = figure( ...
    'Visible', 'off', ...
    'Color', 'white', ...
    'Units', 'inches', ...
    'Position', [1, 1, 12, 7.2]);
layout = tiledlayout(figureHandle, 2, 3, ...
    'TileSpacing', 'compact', 'Padding', 'compact');

for variableIndex = 1:numel(variables)
    variable = variables(variableIndex);
    axesHandle = nexttile(layout, variableIndex);
    plotDailySection(axesHandle, data, variable, paletteMode, depthLimit);
end

informationAxes = nexttile(layout, 6);
axis(informationAxes, 'off');
text(informationAxes, 0.05, 0.68, sprintf('%s\nDay %d\n%d CTD stations', ...
    campaign.cruise, sampledDay, numel(unique(data.Longitude))), ...
    'FontName', 'Arial', ...
    'FontSize', 16, ...
    'FontWeight', 'bold', ...
    'VerticalAlignment', 'top');
text(informationAxes, 0.05, 0.30, ...
    sprintf('Palette: %s\nFrame interval: 1.2 s', paletteMode), ...
    'FontName', 'Arial', ...
    'FontSize', 11, ...
    'VerticalAlignment', 'top');

title(layout, sprintf('%s (%s) - sampling day %d', ...
    campaign.label, campaign.cruise, sampledDay), ...
    'FontName', 'Arial', ...
    'FontSize', 18, ...
    'FontWeight', 'bold');
xlabel(layout, 'Distance from coast (km)', ...
    'FontName', 'Arial', 'FontSize', 13, 'FontWeight', 'bold');
ylabel(layout, 'Depth (m)', ...
    'FontName', 'Arial', 'FontSize', 13, 'FontWeight', 'bold');
end

function plotDailySection(axesHandle, data, variable, paletteMode, depthLimit)
longitude = data.Longitude;
latitude = data.Latitude;
depth = data.depth;
values = data.(variable.column);
[transectDistanceKm, distanceLimitsKm] = geographic_transect_distance( ...
    longitude, latitude);
valid = isfinite(transectDistanceKm) & isfinite(depth) ...
    & isfinite(values) & depth >= 0 & depth <= depthLimit;

if nnz(valid) < 3
    error('Not enough finite observations for %s.', variable.column);
end

distanceGrid = linspace(min(transectDistanceKm(valid)), ...
    max(transectDistanceKm(valid)), 60);
depthGrid = (5:5:depthLimit).';
[queryDistance, queryDepth] = meshgrid(distanceGrid, depthGrid);
interpolated = griddata(transectDistanceKm(valid), depth(valid), ...
    values(valid), queryDistance, queryDepth, 'linear');

surface(axesHandle, queryDistance, -queryDepth, ...
    zeros(size(interpolated)), interpolated, ...
    'EdgeColor', 'none', 'FaceColor', 'interp');
view(axesHandle, 2);
hold(axesHandle, 'on');
scatter(axesHandle, transectDistanceKm(valid), -depth(valid), 5, 'o', ...
    'MarkerFaceColor', 'none', ...
    'MarkerEdgeColor', [0.35, 0.35, 0.35], ...
    'LineWidth', 0.35);

if strcmp(paletteMode, 'cmocean')
    colormap(axesHandle, cmocean(variable.palette, 256));
else
    colormap(axesHandle, jet(256));
end
clim(axesHandle, variable.limits);
colourBar = colorbar(axesHandle);
colourBar.FontSize = 9;

xlim(axesHandle, distanceLimitsKm);
ylim(axesHandle, [-depthLimit, 0]);
xticks(axesHandle, 0:10:60);
depthTicks = 0:50:250;
yticks(axesHandle, -fliplr(depthTicks));
yticklabels(axesHandle, string(fliplr(depthTicks)));

title(axesHandle, variable.label, 'Interpreter', 'tex');
set(axesHandle, ...
    'FontName', 'Arial', ...
    'FontSize', 9, ...
    'TickDir', 'out', ...
    'Layer', 'top', ...
    'Box', 'on');
end

function validateColumns(data, requiredColumns)
missing = setdiff(requiredColumns, data.Properties.VariableNames, 'stable');
if ~isempty(missing)
    error('Required workbook columns are missing: %s', ...
        strjoin(missing, ', '));
end
end

function deleteIfPresent(filePath)
if isfile(filePath)
    delete(filePath);
end
end
