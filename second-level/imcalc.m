% List of open inputs
% Image Calculator: Input Images - cfg_files

workdir = pwd;
basedir = fullfile(pwd, './'); % git repo location
datadir = fullfile(pwd, '../results/'); % fmriprep dataset location
resdir = fullfile(pwd, '../results_2ndLvl/'); % output location
D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);
subjects = {D.name};
exclude = {'sub-B046','sub-B103','sub-B237','sub-B257','sub-B362','sub-B366','sub-B414','sub-B423'};
included_subjects = setdiff(subjects, exclude);
included_subjects = included_subjects;

nrun = numel(subjects); % enter the number of runs here
jobfile = {'E:\SPM_test\code\imcalc_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);
metainputs_dir = {'CriticismSuspence_lis\','CriticismHotspot_l','CriticismSuspence_imag','CriticismHotspot_imag', ...
'CriticismSuspence_lis_imag','CriticismHotspot_lis_imag', ...
'NeutralSuspence_lis','NeutralHotspot_lis','NeutralSuspence_imag','NeutralHotspot_imag','NeutralSuspence_lis_imag', ...
'NeutralHotspot_lis_imag','Crit-NeutSuspence_lis_imag','Crit-NeutHotspot_lis_imag'};
meta_n =1;
metainputs_con = 1:4:56;

for meta_n=1:length(metainputs_dir)
    display(meta_n)
    for crun = 1:nrun
        sub = subjects{crun};
        tmpdir = metainputs_dir(meta_n);
        
        % Specify the directory name
        tmpoutdir = cellstr(['E:\SPM_test\imcalc_mean','\',tmpdir{:}]);

        % Check if the directory exists
        if ~isfolder(tmpoutdir{:})
            % If it doesn't exist, create the directory
            mkdir(tmpoutdir{:});
            disp(['Directory "', tmpoutdir{:}, '" created.']);
        end
        contrast1 = sprintf('con_%04d', metainputs_con(meta_n));
        contrast2 = sprintf('con_%04d', metainputs_con(meta_n)+1);
        inputs{1, crun} = cellstr([strcat('E:\SPM_test\results\', sub, '\stories-model\',contrast1,'.nii,1'); ...
                                   strcat('E:\SPM_test\results\', sub, '\stories-model\',contrast2,'.nii,1')]); 
                                   % Image Calculator: Input Images - cfg_files
        %Let's try
        matlabbatch{1}.spm.util.imcalc.input = '<UNDEFINED>';
        matlabbatch{1}.spm.util.imcalc.output = strcat(sub,'_pre');
        matlabbatch{1}.spm.util.imcalc.outdir = tmpoutdir;
        matlabbatch{1}.spm.util.imcalc.expression = '(i1+i2)/2';
        matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
        matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
        matlabbatch{1}.spm.util.imcalc.options.mask = 0;
        matlabbatch{1}.spm.util.imcalc.options.interp = 1;
        matlabbatch{1}.spm.util.imcalc.options.dtype = 4;

        spm('defaults', 'FMRI');
        spm_jobman('run', matlabbatch, inputs{:});

        contrast3 = sprintf('con_%04d', metainputs_con(meta_n)+2);
        contrast4 = sprintf('con_%04d', metainputs_con(meta_n)+3);
        inputs{1, crun} = cellstr([strcat('E:\SPM_test\results\', sub, '\stories-model\',contrast3,'.nii,1'); ...
                                   strcat('E:\SPM_test\results\', sub, '\stories-model\',contrast4,'.nii,1')]); 
                                   % Image Calculator: Input Images - cfg_files
        %Let's try
        matlabbatch{1}.spm.util.imcalc.input = '<UNDEFINED>';
        matlabbatch{1}.spm.util.imcalc.output = strcat(sub,'_post');
        matlabbatch{1}.spm.util.imcalc.outdir = tmpoutdir;
        matlabbatch{1}.spm.util.imcalc.expression = '(i1+i2)/2';
        matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
        matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
        matlabbatch{1}.spm.util.imcalc.options.mask = 0;
        matlabbatch{1}.spm.util.imcalc.options.interp = 1;
        matlabbatch{1}.spm.util.imcalc.options.dtype = 4;

        spm('defaults', 'FMRI');
        spm_jobman('run', matlabbatch, inputs{:});
    end
end