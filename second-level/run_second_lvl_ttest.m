% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files



workdir = pwd;
basedir = fullfile(pwd, './'); % git repo location
datadir = fullfile(pwd, '../results/'); % fmriprep dataset location
resdir = fullfile(pwd, '../results_2ndLvl/'); % output location



D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);

subjects = {D.name};

nrun = 1; % enter the number of runs here
jobfile = {'E:\SPM_test\code\run_second_lvl_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);
exclude = {};
included_subjects = setdiff(subjects, exclude);
included_subjects = included_subjects;

for crun = 1:nrun
    
    
    inputs{1, crun} = {'E:\SPM_test\results_2ndLvl\T-Test_crit_l_sus'}; % Factorial design specification: Directory - cfg_files
    
    inputs{2, crun} = fullfile(strcat(datadir, included_subjects, '/stories-model/con_0001.nii')); % Factorial design specification: Scans - cfg_files

end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
