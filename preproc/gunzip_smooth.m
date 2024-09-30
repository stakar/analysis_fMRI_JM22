% List of open inputs
% Gunzip Files: File Set - cfg_files

workdir = pwd;
basedir = fullfile(pwd, ''); % git repo location
datadir = fullfile(pwd, ''); % fmriprep dataset location

D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);

subjects = {D.name};
nrun = numel(subjects); % enter the number of runs here

jobfile = {fullfile(basedir, 'spm_preproc_job.m')};

jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);

for crun = 1:nrun

    sub = subjects{crun};
    subdir = fullfile(datadir, sub);

    bold = 'space-MNI152NLin2009cAsym_desc-preproc_bold';

    inputs{1, crun} = {
        fullfile(subdir, 'ses-1', 'func', [sub, '_ses-1_task-fmri_run-01_', bold, '.nii.gz'])
        fullfile(subdir, 'ses-1', 'func', [sub, '_ses-1_task-fmri_run-02_', bold, '.nii.gz'])
        fullfile(subdir, 'ses-2', 'func', [sub, '_ses-2_task-fmri_run-01_', bold, '.nii.gz'])
        fullfile(subdir, 'ses-2', 'func', [sub, '_ses-2_task-fmri_run-02_', bold, '.nii.gz'])
    }; % Gunzip Files: File Set - cfg_files

end

spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

cd(workdir)
clearvars -except workdir subjects inputs
