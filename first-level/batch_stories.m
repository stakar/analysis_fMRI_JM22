% List of open inputs
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files
% TODO:
% in triggers, there are still empty therapy runs (run1), and P123 in
% Therapy, we need to get rid of it.


workdir = pwd;
basedir = fullfile(pwd, './'); % git repo location
datadir = fullfile(pwd, './'); % fmriprep dataset location
resdir = fullfile(pwd, 'results/'); % output location

D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);

subjects = {D.name};
nrun = numel(subjects); % enter the number of runs here

jobfile = {fullfile(basedir, 'batch_stories_job.m')};

jobs = repmat(jobfile, 1, nrun);
inputs = cell(7, nrun);



for crun = 1:nrun

    sub = subjects{crun};


    if ~isfolder(fullfile(resdir, sub, 'stories-model'))
        % If it doesn't exist, create the directory
        mkdir(fullfile(resdir, sub, 'stories-model'))
    end

    bold = 'space-MNI152NLin2009cAsym_desc-preproc_bold';

    inputs{1, crun} = {fullfile(resdir, sub, 'stories-model/ses-1')}; % fMRI model specification: Directory - cfg_files
    
    inputs{2, crun} = {fullfile(datadir, sub,'ses-1', 'func', ['s6', sub, '_ses-1_task-fmri_run-01_', bold, '.nii'])}; % fMRI model specification: Scans - cfg_files
    inputs{3, crun} = {fullfile(basedir, 'trigger', sub,'ses-1', [sub, '_ses-1_Run1.mat'])}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{4, crun} = {fullfile(basedir, sub, 'stats', [sub, '_ses-1_task-fmri_run-01_confounds.mat'])}; % fMRI model specification: Multiple regressors - cfg_files
    
    inputs{5, crun} = {fullfile(datadir, sub,'ses-1', 'func', ['s6', sub, '_ses-1_task-fmri_run-02_', bold, '.nii'])}; % fMRI model specification: Scans - cfg_files
    inputs{6, crun} = {fullfile(basedir, 'trigger', sub,'ses-1', [sub, '_ses-1_Run2.mat'])}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{7, crun} = {fullfile(basedir, sub, 'stats', [sub, '_ses-1_task-fmri_run-02_confounds.mat'])}; % fMRI model specification: Multiple regressors - cfg_files
    
    % inputs{5, crun} = {fullfile(datadir, sub, 'func', ['s6', sub, '_task-stories_run-02_', bold, '.nii'])}; % fMRI model specification: Scans - cfg_files
    % inputs{6, crun} = {fullfile(basedir, 'triggers', sub,'ses-1', [sub, '_ses-1_Run2.m'])}; % fMRI model specification: Multiple conditions - cfg_files
    % inputs{7, crun} = {fullfile(resdir, sub, 'stats', [sub, '_task-stories_run-02_confounds.mat'])}; % fMRI model specification: Multiple regressors - cfg_files
    
end


spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
