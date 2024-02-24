addpath('bids-matlab-main');
datadir = fullfile(pwd, './'); % fmriprep dataset location
resdir = fullfile(pwd, './'); % output location

extract_confounds_fmriprep(datadir, resdir, 'task-fmri')
