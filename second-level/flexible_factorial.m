
% Factorial design specification: Scans - cfg_files
% Factorial design specification: Conditions - cfg_entry
% Prepared in SPM12, based on tutorial by Glasher and Gitelman

workdir = pwd;
basedir = fullfile(pwd, '../code/'); % git repo location
datadir = fullfile(pwd, '../results/'); % fmriprep dataset location
resdir = fullfile(pwd, '../results_2ndLvl/'); % output location
D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);
subjects = {D.name};
%Subjects to exclude, it might change as some are just excluded due to
%errors at preprocessing
exclude = {'sub-B046','sub-B103','sub-B237','sub-B257','sub-B362','sub-B366','sub-B414','sub-B423'};
included_subjects = setdiff(subjects, exclude);
included_subjects = included_subjects;

%Legacy code, left as it might be useful.
nrun = 1; % enter the number of runs here
jobfile = {'E:\SPM_test\test_flexible\test_batch2_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);

% Code below is really weird, but it is jusc various conditions (n=14),
% which we want to test in our study.
metainputs_dir = {'CriticismSuspence_lis\','CriticismHotspot_l',...
    'CriticismSuspence_imag','CriticismHotspot_imag', ...
    'CriticismSuspence_lis_imag','CriticismHotspot_lis_imag', ...
    'NeutralSuspence_lis','NeutralHotspot_lis','NeutralSuspence_imag',...
    'NeutralHotspot_imag','NeutralSuspence_lis_imag', ...
    'NeutralHotspot_lis_imag','Crit-NeutSuspence_lis_imag',...
    'Crit-NeutHotspot_lis_imag'};
meta_n =1;
metainputs_con = 1:14;

%Reading which subject belongs to which condition.
conditions = readtable(fullfile(basedir, 'condition_group.csv'));
IMRS = strcat('sub-',conditions.code(strmatch("exp",conditions.group)));
CONTROL = strcat('sub-',conditions.code(strmatch("cont",conditions.group)));
IMRS = intersect(IMRS, included_subjects);
CONTROL = intersect(CONTROL, included_subjects);
for meta_n=1:numel(metainputs_dir)
    for crun = 1:nrun
        tmpdir = metainputs_dir(meta_n);
        contrast1 = sprintf('con_%04d', metainputs_con(meta_n));
        matlabbatch{1}.spm.stats.factorial_design.dir = cellstr(fullfile('E:\SPM_test\test_flexible',tmpdir));
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).name = 'subject';
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).dept = 0;
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).variance = 0;
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).gmsca = 0;
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).ancova = 0;
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).name = 'time';
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).dept = 1;
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
            strcat('E:\SPM_test\results\', sub, '\stories-model\ses-1\',contrast1,'.nii,1')
            strcat('E:\SPM_test\results\', sub, '\stories-model\ses-2\',contrast1,'.nii,1')
            };
            matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(n_sub).conds = [1 1
                                                                                                  2 1];
        end
        for n_sub = 1:numel(CONTROL)
            sub = CONTROL{n_sub};
            n_run = n_sub + numel(IMRS);
            matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(n_run).scans = {
            strcat('E:\SPM_test\results\',sub, '\stories-model\ses-1\',contrast1,'.nii,1')
            strcat('E:\SPM_test\results\',sub, '\stories-model\ses-2\',contrast1,'.nii,1')    
            };
            matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(n_run).conds = [1 2
                                                                                                  2 2];
        end
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{1}.fmain.fnum = 2;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{2}.fmain.fnum = 3;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{3}.inter.fnums = [2
                                                                                      3];
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
    matlabbatch{3}.spm.stats.con.consess{1}.fcon.name = 'time';
    matlabbatch{3}.spm.stats.con.consess{1}.fcon.weights = [1 -1 0 0 0.5 0.5 -0.5 -0.5];
    matlabbatch{3}.spm.stats.con.consess{1}.fcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{2}.fcon.name = 'group';
    matlabbatch{3}.spm.stats.con.consess{2}.fcon.weights = [0 0 1 -1 0.5 -0.5 0.5 -0.5];
    matlabbatch{3}.spm.stats.con.consess{2}.fcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{3}.fcon.name = 'time1group1';
    matlabbatch{3}.spm.stats.con.consess{3}.fcon.weights = [1 0 1 0 1 0 0 0];
    matlabbatch{3}.spm.stats.con.consess{3}.fcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.delete = 0;
    end
    spm('defaults', 'FMRI');
    spm_jobman('run', matlabbatch);
end
