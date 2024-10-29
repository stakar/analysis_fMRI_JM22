
% Factorial design specification: Scans - cfg_files
% Factorial design specification: Conditions - cfg_entry
% Prepared in SPM12, based on tutorial by Glasher and Gitelman

workdir = pwd;
basedir = fullfile(pwd, '../code/'); % git repo location
datadir = fullfile(pwd, '../results_first/'); % fmriprep dataset location
resdir = fullfile(pwd, '../results_2ndLvl/flex/'); % output location
D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);
subjects = {D.name};
%Subjects to exclude, it might change as some are just excluded due to
%errors at preprocessing
exclude = {};
included_subjects = setdiff(subjects, exclude);
included_subjects = included_subjects;
matching_subjects_imrs = {'sub-B252', 'sub-B140', 'sub-B143', 'sub-B103', 'sub-B249', 'sub-B144', 'sub-B303', 'sub-B139', 'sub-B045', 'sub-B237',...
 'sub-B114', 'sub-B272', 'sub-B454', 'sub-B525', 'sub-B375', 'sub-B541', 'sub-B524', 'sub-B562', 'sub-B566', 'sub-B656',...
 'sub-B456', 'sub-B676', 'sub-B369', 'sub-B510'};

%Legacy code, left as it might be useful.
nrun = 1; % enter the number of runs here
% jobfile = {'E:\SPM_test\test_flexible\test_batch2_job.m'};
% jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);

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
meta_n =1;
metainputs_con = 1:32;

%Reading which subject belongs to which condition.
conditions = readtable(fullfile(basedir, 'condition_group.csv'));
IMRS = strcat('sub-',conditions.code(strmatch("exp",conditions.group)));
CONTROL = strcat('sub-',conditions.code(strmatch("cont",conditions.group)));
IMRS = intersect(IMRS, included_subjects);
IMRS = intersect(IMRS, matching_subjects_imrs );
CONTROL = intersect(CONTROL, included_subjects);
imrs_n = numel(IMRS);
cont_n = numel(CONTROL);    
all_sub_n = imrs_n+cont_n;
for meta_n=1:numel(metainputs_dir)
% for meta_n=1:numel(metainputs_dir)

    for crun = 1:nrun
        tmpdir = metainputs_dir(meta_n);
        contrast1 = sprintf('con_%04d', metainputs_con(meta_n));
    matlabbatch{1}.spm.stats.factorial_design.dir = cellstr(fullfile(resdir,tmpdir));
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).name = 'repl';
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).dept = 1;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).variance = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).ancova = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).name = 'subject';
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).dept = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).variance = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).ancova = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).name = 'group';
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).dept = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).variance = 1;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).ancova = 0;
        for n_sub = 1:numel(IMRS)
            sub = IMRS{n_sub}; % Factorial design specification: Directory - cfg_files
            contrast1 = sprintf('con_%04d', metainputs_con(meta_n));
            matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(n_sub).scans = {
            strcat(datadir, sub, '\stories-model\ses-1\',contrast1,'.nii,1')
            strcat(datadir, sub, '\stories-model\ses-2\',contrast1,'.nii,1')
            };
            matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(n_sub).conds = [1
                                                                                                  1];
        end
        for n_sub = 1:numel(CONTROL)
            sub = CONTROL{n_sub};
            n_run = n_sub + numel(IMRS);
            matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(n_run).scans = {
            strcat(datadir,sub, '\stories-model\ses-1\',contrast1,'.nii,1')
            strcat(datadir,sub, '\stories-model\ses-2\',contrast1,'.nii,1')    
            };
            matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(n_run).conds = [2
                                                                                                  2];
        end

    matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{1}.inter.fnums = [1
                                                                                      3];
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{2}.fmain.fnum = 2;
    matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
    matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
    matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
    matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
    matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

    
    
    matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
    matlabbatch{3}.spm.stats.con.consess{1}.fcon.name = 'pre-post groups';
    matlabbatch{3}.spm.stats.con.consess{1}.fcon.weights = [(imrs_n/all_sub_n) -(cont_n/all_sub_n) -(imrs_n/all_sub_n) (cont_n/all_sub_n) zeros(1,all_sub_n)
                                                            -(imrs_n/all_sub_n) (cont_n/all_sub_n) (imrs_n/all_sub_n) -(cont_n/all_sub_n) zeros(1,all_sub_n)];
    matlabbatch{3}.spm.stats.con.consess{1}.fcon.sessrep = 'none';
    
    matlabbatch{3}.spm.stats.con.consess{2}.fcon.name = 'pre-post imrs';
    matlabbatch{3}.spm.stats.con.consess{2}.fcon.weights = [(imrs_n/all_sub_n) 0 -(imrs_n/all_sub_n) 0 zeros(1,all_sub_n)
                                                            -(imrs_n/all_sub_n) 0 (imrs_n/all_sub_n) 0 zeros(1,all_sub_n)];
    matlabbatch{3}.spm.stats.con.consess{2}.fcon.sessrep = 'none';
    
    matlabbatch{3}.spm.stats.con.consess{3}.fcon.name = 'pre-post cont';
    matlabbatch{3}.spm.stats.con.consess{3}.fcon.weights = [0 -(cont_n/all_sub_n) 0 (cont_n/all_sub_n) zeros(1,all_sub_n)
                                                            0 (cont_n/all_sub_n) 0 -(cont_n/all_sub_n) zeros(1,all_sub_n)];
    matlabbatch{3}.spm.stats.con.consess{3}.fcon.sessrep = 'none';
    
    matlabbatch{3}.spm.stats.con.consess{4}.fcon.name = 'main effect of time';
    matlabbatch{3}.spm.stats.con.consess{4}.fcon.weights = [-(imrs_n/all_sub_n) -(cont_n/all_sub_n) (imrs_n/all_sub_n) (cont_n/all_sub_n) zeros(1,all_sub_n)
                                                            (imrs_n/all_sub_n) (cont_n/all_sub_n) -(imrs_n/all_sub_n) -(cont_n/all_sub_n) zeros(1,all_sub_n)];
    matlabbatch{3}.spm.stats.con.consess{4}.fcon.sessrep = 'none';
    
    
    matlabbatch{3}.spm.stats.con.consess{5}.fcon.name = 'main effect of group';
    matlabbatch{3}.spm.stats.con.consess{5}.fcon.weights = [1/2 -1/2 1/2 -1/2 ones(1,imrs_n)/imrs_n -ones(1,cont_n)/cont_n
                                                            -1/2 1/2 -1/2 1/2 -ones(1,imrs_n)/imrs_n ones(1,cont_n)/cont_n];
    matlabbatch{3}.spm.stats.con.consess{5}.fcon.sessrep = 'none';
    
    
    matlabbatch{3}.spm.stats.con.consess{6}.fcon.name = '1st meeting group';
    matlabbatch{3}.spm.stats.con.consess{6}.fcon.weights = [1 -1 0 0 ones(1,imrs_n)/imrs_n -ones(1,cont_n)/cont_n
                                                            -1 1 0 0 -ones(1,imrs_n)/imrs_n ones(1,cont_n)/cont_n];
    matlabbatch{3}.spm.stats.con.consess{6}.fcon.sessrep = 'none';
    
    matlabbatch{3}.spm.stats.con.consess{7}.fcon.name = '2nd meeting group';
    matlabbatch{3}.spm.stats.con.consess{7}.fcon.weights = [0 0 1 -1 ones(1,imrs_n)/imrs_n -ones(1,cont_n)/cont_n
                                                            0 0 -1 1 -ones(1,imrs_n)/imrs_n ones(1,cont_n)/cont_n];
    matlabbatch{3}.spm.stats.con.consess{7}.fcon.sessrep = 'none';
    
    matlabbatch{3}.spm.stats.con.consess{8}.tcon.name = 'pre>post';
    matlabbatch{3}.spm.stats.con.consess{8}.tcon.weights = [1 1 -1 -1 zeros(1,all_sub_n)];
    matlabbatch{3}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
    
    matlabbatch{3}.spm.stats.con.consess{9}.tcon.name = 'pre>post imrs>cont';
    matlabbatch{3}.spm.stats.con.consess{9}.tcon.weights = [1 -1 -1 1 zeros(1,all_sub_n)];
    matlabbatch{3}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
    
    matlabbatch{3}.spm.stats.con.consess{10}.tcon.name = '1st meeting';
    matlabbatch{3}.spm.stats.con.consess{10}.tcon.weights = [1 1 0 0  ones(1,imrs_n)/imrs_n ones(1,cont_n)/cont_n];
    matlabbatch{3}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
% %     
%     
    end
    spm('defaults', 'FMRI');
    spm_jobman('run', matlabbatch);
end