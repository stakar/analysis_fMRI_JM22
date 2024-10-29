% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Contrast Manager: Name - cfg_entry
workdir = pwd;
basedir = fullfile(pwd, './'); % git repo location
datadir = fullfile('E:\SPM_test\results_first\'); % fmriprep dataset location
resdir = fullfile('E:\SPM_test\results_2ndLvl/'); % output location
D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);
subjects = {D.name};


nrun = 1; % enter the number of runs here
jobfile = {'E:\SPM_test\code\2ndLvlv\run_second_lvl_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);
exclude = {};
included_subjects = setdiff(subjects, exclude);
included_subjects = included_subjects;


%Reading which subject belongs to which condition.
conditions = readtable(fullfile(basedir, '../condition_group.csv'));
IMRS = strcat('sub-',conditions.code(strmatch("exp",conditions.group)));
CONTROL = strcat('sub-',conditions.code(strmatch("cont",conditions.group)));
IMRS = intersect(IMRS, included_subjects);
CONTROL = intersect(CONTROL, included_subjects);


metainputs_dir = {'CriticismSuspence_lis','CriticismHotspot_l',...
    'CriticismSuspence_imag','CriticismHotspot_imag', ...
    'CriticismSuspence_lis_imag','CriticismHotspot_lis_imag', ...
    'NeutralSuspence_lis','NeutralHotspot_lis','NeutralSuspence_imag',...
    'NeutralHotspot_imag','NeutralSuspence_lis_imag', ...
    'NeutralHotspot_lis_imag','Crit-NeutSuspence_lis_imag',...
    'Crit-NeutHotspot_lis_imag','Criticism_lis_imag',...
    'Criticism_lis','Criticism_imag','First_Hotspot_lis_imag'...
    'First_Hotspot_lis','First_Hotspot_imag','First_Suspence_lis_imag',...
    'First_Suspence_lis','First_Suspence_imag',...
    'Therapy_PredError_lis_imag','Therapy_PredError_lis',...
    'Therapy_PredError_imag','Therapy_Suspence_lis_imag',...
    'Therapy_Suspence_lis','Therapy_Suspence_imag',...
    'Therapy_Intervention_lis_imag','Therapy_Intervention_lis',...
    'Therapy_Intervention_imag'};

metainputs_con = 1:32;
metainputs_name = {'crit_sus_l','crit_hot_l','crit_sus_i','crit_hot_i','crit_sus_li','crit_hot_li', ...
    'neut_sus_l','neut_hot_l','neut_sus_i','neut_hot_i','neut_sus_li','neut_hot_li','Crit>Neut_sus_li',...
    'Crit>Neut_hot_li','criticism_li','criticism_l','criticism_i','first_hot_li','first_hot_l','first_hot_i',...
    'first_sus_li','first_sus_l','first_sus_i','therapy_pe_li','therapy_pe_l','therapy_pe_i',...
    'therapy_sus_li','therapy_sus_l','therapy_sus_i','therapy_int_li','therapy_int_l','therapy_int_i'};
meta_n =1;
for meta_n=1:numel(metainputs_name)
    for crun = 1:nrun
        tmpdir = metainputs_dir(meta_n);
        inputs{1, crun} = cellstr(fullfile(resdir,'1ttest/ses-1/' tmpdir)); % Factorial design specification: Directory - cfg_files
        contrast1 = sprintf('con_%04d', meta_n);
        inputs{2, crun} = cellstr(strcat(datadir, included_subjects, '\stories-model\ses-1\',contrast1,'.nii,1')'); % Factorial design specification: Scans - cfg_files
        inputs{3, crun} = metainputs_name{meta_n}; % Contrast Manager: Name - cfg_entry

        spm('defaults', 'FMRI');
        spm_jobman('run', jobs, inputs{:});

    end
end
for meta_n=1:numel(metainputs_name)
    for crun = 1:nrun
        tmpdir = metainputs_dir(meta_n);
        inputs{1, crun} = cellstr(fullfile(resdir,'1ttest/ses-2/' tmpdir)); % Factorial design specification: Directory - cfg_files
        contrast1 = sprintf('con_%04d', meta_n);
        inputs{2, crun} = cellstr(strcat(datadir, included_subjects, '\stories-model\ses-2\',contrast1,'.nii,1')'); % Factorial design specification: Scans - cfg_files
        inputs{3, crun} = metainputs_name{meta_n}; % Contrast Manager: Name - cfg_entry

        spm('defaults', 'FMRI');
        spm_jobman('run', jobs, inputs{:});

    end
end

for meta_n=1:numel(metainputs_name)
    for crun = 1:nrun
        tmpdir = metainputs_dir(meta_n);
        inputs{1, crun} = cellstr(fullfile(resdir,'1ttest_imrs/ses-1', tmpdir)); % Factorial design specification: Directory - cfg_files
        contrast1 = sprintf('con_%04d', meta_n);
        inputs{2, crun} = cellstr(strcat(datadir, IMRS, '\stories-model\ses-1\',contrast1,'.nii,1')); % Factorial design specification: Scans - cfg_files
        inputs{3, crun} = metainputs_name{meta_n}; % Contrast Manager: Name - cfg_entry

        spm('defaults', 'FMRI');
        spm_jobman('run', jobs, inputs{:});
    end
end
for meta_n=1:numel(metainputs_name)
    for crun = 1:nrun
        tmpdir = metainputs_dir(meta_n);
        inputs{1, crun} = cellstr(fullfile(resdir,'1ttest_imrs/ses-2', tmpdir)); % Factorial design specification: Directory - cfg_files
        contrast1 = sprintf('con_%04d', meta_n);
        inputs{2, crun} = cellstr(strcat(datadir, IMRS, '\stories-model\ses-2\',contrast1,'.nii,1')); % Factorial design specification: Scans - cfg_files
        inputs{3, crun} = metainputs_name{meta_n}; % Contrast Manager: Name - cfg_entry

        spm('defaults', 'FMRI');
        spm_jobman('run', jobs, inputs{:});
    end
end
for meta_n=1:numel(metainputs_name)
    for crun = 1:nrun
        tmpdir = metainputs_dir(meta_n);
        inputs{1, crun} = cellstr(fullfile(resdir,'1ttest_imrs/ses-1', tmpdir)); % Factorial design specification: Directory - cfg_files
        contrast1 = sprintf('con_%04d', meta_n);
        inputs{2, crun} = cellstr(strcat(datadir, CONTROL, '\stories-model\ses-1\',contrast1,'.nii,1')); % Factorial design specification: Scans - cfg_files
        inputs{3, crun} = metainputs_name{meta_n}; % Contrast Manager: Name - cfg_entry

        spm('defaults', 'FMRI');
        spm_jobman('run', jobs, inputs{:});
    end
end
for meta_n=1:numel(metainputs_name)
    for crun = 1:nrun
        tmpdir = metainputs_dir(meta_n);
        inputs{1, crun} = cellstr(fullfile(resdir,'1ttest_imrs/ses-2', tmpdir)); % Factorial design specification: Directory - cfg_files
        contrast1 = sprintf('con_%04d', meta_n);
        inputs{2, crun} = cellstr(strcat(datadir, CONTROL, '\stories-model\ses-2\',contrast1,'.nii,1')); % Factorial design specification: Scans - cfg_files
        inputs{3, crun} = metainputs_name{meta_n}; % Contrast Manager: Name - cfg_entry

        spm('defaults', 'FMRI');
        spm_jobman('run', jobs, inputs{:});
    end
end