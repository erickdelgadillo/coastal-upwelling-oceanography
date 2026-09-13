function paths = coastal_setup(workflow)
%COASTAL_SETUP Configure inputs for the MATLAB oceanography workflows.
%   PATHS = COASTAL_SETUP('temporal') adds the bundled third-party
%   functions to the MATLAB path and changes the current folder to the
%   selected input directory under data/.
%
%   Set COASTAL_UPWELLING_OCEANOGRAPHY_DATA_DIR only when the data have
%   deliberately been stored outside the repository.

if nargin < 1
    workflow = 'temporal';
end

repoRoot = fileparts(mfilename('fullpath'));
dataRoot = getenv('COASTAL_UPWELLING_OCEANOGRAPHY_DATA_DIR');

if isempty(dataRoot)
    dataRoot = fullfile(repoRoot, 'data');
end

if ~isfolder(dataRoot)
    error(['Coastal oceanography data directory not found: %s\n', ...
        'Use the bundled data/ directory or set ', ...
        'COASTAL_UPWELLING_OCEANOGRAPHY_DATA_DIR.'], dataRoot);
end

inputDir = fullfile(dataRoot, workflow);
if ~isfolder(inputDir)
    error('MATLAB input directory not found: %s', inputDir);
end

addpath(fullfile(repoRoot, 'third_party'));
cd(inputDir);

paths = struct( ...
    'repo_root', repoRoot, ...
    'data_root', dataRoot, ...
    'input_dir', inputDir);
end
