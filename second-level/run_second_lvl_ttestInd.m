% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Group 1 scans - cfg_files
% Factorial design specification: Group 2 scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Weights vector - cfg_entry

workdir = pwd;
basedir = fullfile(pwd, '../../code/'); % git repo location
datadir = fullfile('E:\SPM_test\results_first\'); % fmriprep dataset location
resdir = fullfile('E:\SPM_test\results_2ndLvl/2ind_ttest/'); % output location
D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);
subjects = {D.name};
%Subjects to excl   ude, it might change as some are just excluded due to
%errors at preprocessing
exclude = {};
included_subjects = setdiff(subjects, exclude);
included_subjects = included_subjects;
matching_subjects_imrs = {'sub-B252', 'sub-B140', 'sub-B143', 'sub-B103', 'sub-B249', 'sub-B144', 'sub-B303', 'sub-B139', 'sub-B045', 'sub-B237',...
 'sub-B114', 'sub-B272', 'sub-B454', 'sub-B525', 'sub-B375', 'sub-B541', 'sub-B524', 'sub-B562', 'sub-B566', 'sub-B656',...
 'sub-B456', 'sub-B676', 'sub-B369', 'sub-B510'};

nrun = 1; % enter the number of runs here
% Code below is really weird, but it is jusc various conditions (n=14),
% which we want to test in our study.
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

%Reading which subject belongs to which condition.
conditions = readtable(fullfile(basedir, 'condition_group.csv'));
IMRS = strcat('sub-',conditions.code(strmatch("exp",conditions.group)));
CONTROL = strcat('sub-',conditions.code(strmatch("cont",conditions.group)));

IMRS = intersect(IMRS, included_subjects);
IMRS = intersect(IMRS, matching_subjects_imrs );
CONTROL = intersect(CONTROL, included_subjects);


jobfile = {'E:\SPM_test\code\2ndLvlv\run_second_lvl_ttestInd_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(5, nrun);
ses_list = {'_pre','_post','_pre_post'};
ses_fix = 0:14:42;
for meta_n=1:numel(metainputs_name)
        display(meta_n)
        for crun = 1:nrun
            contrast1 = sprintf('con_%04d', metainputs_con(meta_n));
            
            tmpdir =  metainputs_dir{meta_n};
            inputs{1, crun} = cellstr(fullfile(resdir, tmpdir,'ses-1')); % Factorial design specification: Directory - cfg_files
            inputs{2, crun} = strcat(datadir, IMRS, '\stories-model\ses-1\', contrast1, '.nii'); % Factorial design specification: Scans - cfg_files
            inputs{3, crun} = strcat(datadir, CONTROL, '\stories-model\ses-1\', contrast1, '.nii'); % Factorial design specification: Scans - cfg_files
            inputs{4, crun} = [metainputs_name{meta_n} 'imrs>cont']; % Contrast Manager: Name - cfg_entry
            inputs{5, crun} = [1 -1]; % Contrast Manager: Weights vector - cfg_entry
            inputs{6, crun} = [metainputs_name{meta_n} 'imrs<cont']; % Contrast Manager: Name - cfg_entry
            inputs{7, crun} = [-1 1]; % Contrast Manager: Weights vector - cfg_entry
            inputs{8, crun} = [metainputs_name{meta_n} 'ftest']; % Contrast Manager: Name - cfg_entry
            inputs{9, crun} = [1 -1
                               -1 1]; % Contrast Manager: Weights vector - cfg_entry
        spm('defaults', 'FMRI');
        spm_jobman('run', jobs, inputs{:});
        end
end
% for meta_n=1:numel(metainputs_name)
%         display(meta_n)
%         for crun = 1:nrun
%             contrast1 = sprintf('con_%04d', metainputs_con(meta_n));
%             
%             tmpdir =  metainputs_dir{meta_n};
%             inputs{1, crun} = cellstr(fullfile(resdir, tmpdir,'ses-2')); % Factorial design specification: Directory - cfg_files
%             inputs{2, crun} = strcat(datadir, IMRS, '\stories-model\ses-2\', contrast1, '.nii'); % Factorial design specification: Scans - cfg_files
%             inputs{3, crun} = strcat(datadir, CONTROL, '\stories-model\ses-2\', contrast1, '.nii'); % Factorial design specification: Scans - cfg_files
%             inputs{4, crun} = [metainputs_name{meta_n} ' imrs>cont']; % Contrast Manager: Name - cfg_entry
%             inputs{5, crun} = [1 -1]; % Contrast Manager: Weights vector - cfg_entry
%             inputs{6, crun} = [metainputs_name{meta_n} ' imrs<cont']; % Contrast Manager: Name - cfg_entry
%             inputs{7, crun} = [-1 1]; % Contrast Manager: Weights vector - cfg_entry
%             inputs{8, crun} = [metainputs_name{meta_n} ' ftest']; % Contrast Manager: Name - cfg_entry
%             inputs{9, crun} = [1 -1
%                                -1 1]; % Contrast Manager: Weights vector - cfg_entry
%         spm('defaults', 'FMRI');
%         spm_jobman('run', jobs, inputs{:});
%         end
% end
