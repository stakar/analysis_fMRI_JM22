
% List of open inputs
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files
workdir = pwd;
basedir = fullfile(pwd, './'); % git repo location
datadir = fullfile(pwd, '../../derivatives/'); % fmriprep dataset location
confounddir = fullfile(pwd, '../../derivatives/confounds/');
resdir = fullfile(pwd, '../../results_4lvl/'); % output location
triggdir = fullfile(pwd, '../../triggers/');

D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);

subjects = {D.name};
%
%
%UWAGA NA T¥ LINIJKÊ KODU!
%Czasami matlab padnie w trakcie analizy, wiec zaczynamy analizê tam gdzie
%skonczyl i wtedy modyfikujemy ktorych badanych ma analizowac, ponizsza
%linijka jest wtedy przydatna.
subjects = subjects(69:numel(subjects));
%
%
%
nrun = numel(subjects); % enter the number of runs here

jobfile = {fullfile('E:\SPM_test\code\1stlvl\run_first_lvl_ver3_job.m')};

jobs = repmat(jobfile, 1, nrun);
inputs = cell(7, nrun);



for crun = 1:nrun

    sub = subjects{crun};

    if ~isfolder(fullfile(resdir, sub, 'stories-model'))
        % If it doesn't exist, create the directory
        mkdir(fullfile(resdir, sub, 'stories-model'))
    end

    bold = 'space-MNI152NLin2009cAsym_desc-preproc_bold';

    inputs{1, crun} = {fullfile(resdir, sub, 'stories-model/')}; % fMRI model specification: Directory - cfg_files
    
    inputs{2, crun} = {fullfile(datadir, sub,'ses-1', 'func', ['smooth6', sub, '_ses-1_task-fmri_run-01_', bold, '.nii'])}; % fMRI model specification: Scans - cfg_files
    inputs{3, crun} = {fullfile(triggdir, sub,'ses-1', [sub, '_ses-1_Run1_GPPI.mat'])}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{4, crun} = {fullfile(confounddir, sub, 'stats', [sub, '_ses-1_task-fmri_run-01_confounds.mat'])}; % fMRI model specification: Multiple regressors - cfg_files
    
    inputs{5, crun} = {fullfile(datadir, sub,'ses-1', 'func', ['smooth6', sub, '_ses-1_task-fmri_run-02_', bold, '.nii'])}; % fMRI model specification: Scans - cfg_files
    inputs{6, crun} = {fullfile(triggdir, sub,'ses-1', [sub, '_ses-1_Run2_GPPI.mat'])}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{7, crun} = {fullfile(confounddir, sub, 'stats', [sub, '_ses-1_task-fmri_run-02_confounds.mat'])}; % fMRI model specification: Multiple regressors - cfg_files
    
    inputs{8, crun} = {fullfile(datadir, sub,'ses-2', 'func', ['smooth6', sub, '_ses-2_task-fmri_run-01_', bold, '.nii'])}; % fMRI model specification: Scans - cfg_files
    inputs{9, crun} = {fullfile(triggdir, sub,'ses-2', [sub, '_ses-2_Run1_GPPI.mat'])}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{10, crun} = {fullfile(confounddir, sub, 'stats', [sub, '_ses-2_task-fmri_run-01_confounds.mat'])}; % fMRI model specification: Multiple regressors - cfg_files
    
    inputs{11, crun} = {fullfile(datadir, sub,'ses-2', 'func', ['smooth6', sub, '_ses-2_task-fmri_run-02_', bold, '.nii'])}; % fMRI model specification: Scans - cfg_files
    inputs{12, crun} = {fullfile(triggdir, sub,'ses-2', [sub, '_ses-2_Run2_GPPI.mat'])}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{13, crun} = {fullfile(confounddir, sub, 'stats', [sub, '_ses-2_task-fmri_run-02_confounds.mat'])}; % fMRI model specification: Multiple regressors - cfg_files
%     
end


spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});




