% Code modified, original from https://github.com/nencki-lobi/neurogrieg/tree/main/code/preproc/bids-matlab
addpath('bids-matlab-main');
datadir = fullfile(pwd, './'); % fmriprep dataset location
resdir = fullfile(pwd, './'); % output location

extract_confounds_fmriprep(datadir, resdir, 'task-fmri')
