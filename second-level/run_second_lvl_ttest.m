% List of open inputs
% Factorial design specification: Scans - cfg_files
workdir = pwd;
basedir = fullfile(pwd, './'); % git repo location
datadir = fullfile(pwd, '../results/'); % fmriprep dataset location
resdir = fullfile(pwd, '../results_2ndLvl/'); % output location
D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);
subjects = {D.name};


nrun = 1; % enter the number of runs here
jobfile = {'E:\SPM_test\code\run_second_lvl_test2_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);
exclude = {};
included_subjects = setdiff(subjects, exclude);
included_subjects = included_subjects;

for crun = 1:nrun
    set1 = strcat('E:\SPM_test\results\', included_subjects, '\stories-model\con_0001.nii,1');
    set2 = strcat('E:\SPM_test\results\', included_subjects, '\stories-model\con_0002.nii,1');

    % Create one cell array shaped {1x80}
    combinedCellArray = [set1, set2];
    inputs{1, crun} = combinedCellArray'; % Factorial design specification: Scans - cfg_files
%     inputs{1, crun} = strcat('E:/SPM_test/results/', included_subjects, '/stories-model/con_0001.nii'); % Factorial design specification: Scans - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
