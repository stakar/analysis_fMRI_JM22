% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
workdir = pwd;
basedir = fullfile(pwd, './'); % git repo location
datadir = fullfile(pwd, '../results/'); % fmriprep dataset location
resdir = fullfile(pwd, '../results_2ndLvl/'); % output location
D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);
subjects = {D.name};


nrun = 1; % enter the number of runs here
jobfile = {'E:\SPM_test\code\run_second_lvl_test3_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);
exclude = {'sub-B046','sub-B103','sub-B237','sub-B257','sub-B362','sub-B366','sub-B414','sub-B423'};
included_subjects = setdiff(subjects, exclude);
included_subjects = included_subjects;
metainputs_dir = {'CriticismSuspence_lis\','CriticismHotspot_l','CriticismSuspence_imag','CriticismHotspot_imag', ...
'CriticismSuspence_lis_imag','CriticismHotspot_lis_imag', ...
'NeutralSuspence_lis','NeutralHotspot_lis','NeutralSuspence_imag','NeutralHotspot_imag','NeutralSuspence_lis_imag', ...
'NeutralHotspot_lis_imag','Crit-NeutSuspence_lis_imag','Crit-NeutHotspot_lis_imag'};
metainputs_con = 1:4:56;
metainputs_name = {'crit_sus_l','crit_hot_l','crit_sus_i','crit_hot_i','crit_sus_li','crit_hot_li', ...
    'neut_sus_l','neut_hot_l','neut_sus_i','neut_hot_i','neut_sus_li','neut_hot_li','Crit>Neut_sus_li','Crit>Neut_hot_li'};
meta_n =1;
for meta_n=1:length(metainputs_dir)
    display(meta_n)
    for crun = 1:nrun
        tmpdir = metainputs_dir(meta_n);
        inputs{1, crun} = fullfile(resdir, tmpdir); % Factorial design specification: Directory - cfg_files
        contrast1 = sprintf('con_%04d', metainputs_con(meta_n));
        contrast2 = sprintf('con_%04d', metainputs_con(meta_n)+1);
        inputs{2, crun} = cellstr([strcat('E:\SPM_test\results\', included_subjects, '\stories-model\',contrast1,'.nii,1'), ...
                                   strcat('E:\SPM_test\results\', included_subjects, '\stories-model\',contrast2,'.nii,1')]'); % Factorial design specification: Scans - cfg_files
        inputs{3, crun} = metainputs_name{meta_n}; % Contrast Manager: Name - cfg_entry

        spm('defaults', 'FMRI');
        spm_jobman('run', jobs, inputs{:});

    end
end
