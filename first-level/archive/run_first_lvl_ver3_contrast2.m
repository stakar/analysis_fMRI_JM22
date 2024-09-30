
workdir = pwd;
basedir = fullfile(pwd, './'); % git repo location
datadir = fullfile(pwd, '../results/'); % fmriprep dataset location
resdir = fullfile(pwd, '../results/'); % output location
triggdir = fullfile(pwd, '../triggers/');

D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);

subjects = {D.name};
nrun = numel(subjects); % enter the number of runs here

jobfile = {fullfile(basedir, 'run_first_lvl_ver3_job.m')};

jobs = repmat(jobfile, 1, nrun);
inputs = cell(7, nrun);
for crun = 1:nrun
    for n_ses = 1:1
        sub = subjects{crun};
        spmmat=fullfile(resdir, sub, 'stories-model/SPM.mat');

        load(spmmat);

        crit_sus_l_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytyka_s_P[1-3]', 'once')));

        crit_hot_l_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytyka_s_P4', 'once')));

        crit_sus_i_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytyka_i_P[1-3]', 'once')));

        crit_hot_i_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytyka_i_P4', 'once')));

        crit_sus_li_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytyka_[si]_P[1-3]', 'once')));

        crit_hot_li_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytyka_[si]_P4', 'once')));

        neut_sus_l_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralne_s_P[1-3]', 'once')));

        neut_hot_l_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralne_s_P4', 'once')));

        neut_sus_i_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralne_i_P[1-3]', 'once')));

        neut_hot_i_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralne_i_P4', 'once')));

        neut_sus_li_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralne_[si]_P[1-3]', 'once')));

        neut_hot_li_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralne_[si]_P4', 'once')));
        
        crit_sus_l_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*krytyka_s_P[1-3]', 'once')));

        crit_hot_l_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*krytyka_s_P4', 'once')));

        crit_sus_i_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*krytyka_i_P[1-3]', 'once')));

        crit_hot_i_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*krytyka_i_P4', 'once')));

        crit_sus_li_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*krytyka_[si]_P[1-3]', 'once')));

        crit_hot_li_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*krytyka_[si]_P4', 'once')));

        neut_sus_l_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*neutralne_s_P[1-3]', 'once')));

        neut_hot_l_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*neutralne_s_P4', 'once')));

        neut_sus_i_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*neutralne_i_P[1-3]', 'once')));

        neut_hot_i_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*neutralne_i_P4', 'once')));

        neut_sus_li_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*neutralne_[si]_P[1-3]', 'once')));

        neut_hot_li_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*neutralne_[si]_P4', 'once')));


        crit_neut_sus_li_pre = crit_sus_li_pre - neut_sus_li_pre;
        crit_neut_hot_li_pre = crit_hot_li_pre - neut_hot_li_pre;
        
        crit_neut_sus_li_post = crit_sus_li_post - neut_sus_li_post;
        crit_neut_hot_li_post = crit_hot_li_post - neut_hot_li_post;
        
        crit_sus_l_pre_post = crit_sus_l_pre - crit_sus_l_post;
        
        crit_sus_i_pre_post = crit_sus_i_pre - crit_sus_i_post;
        
        crit_sus_li_pre_post = crit_sus_li_pre - crit_sus_li_post;
        
        crit_hot_l_pre_post = crit_hot_l_pre - crit_hot_l_post;
        
        crit_hot_i_pre_post = crit_hot_i_pre - crit_hot_i_post;
        
        crit_hot_li_pre_post = crit_hot_li_pre - crit_hot_li_post;
        
        neut_sus_l_pre_post = neut_sus_l_pre - neut_sus_l_post;
        
        neut_sus_i_pre_post = neut_sus_i_pre - neut_sus_i_post;
        
        neut_sus_li_pre_post = neut_sus_li_pre - neut_sus_li_post;
        
        neut_hot_l_pre_post = neut_hot_l_pre - neut_hot_l_post;
        
        neut_hot_i_pre_post = neut_hot_i_pre - neut_hot_i_post;
        
        neut_hot_li_pre_post = neut_hot_li_pre - neut_hot_li_post;
        
        crit_neut_sus_li_pre_post = crit_neut_sus_li_pre - crit_neut_sus_li_post;
        crit_neut_hot_li_pre_post = crit_neut_hot_li_pre - crit_neut_hot_li_post;
        
        

        matlabbatch{1}.spm.stats.con.spmmat(1) = {spmmat};

        matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'CriticismSuspence_lis_pre';
        matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = crit_sus_l_pre;
        matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'CriticismHotspot_lis_pre';
        matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = crit_hot_l_pre;
        matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'CriticismSuspence_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = crit_sus_i_pre;
        matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'CriticismHotspot_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = crit_hot_i_pre;
        matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'CriticismSuspence_lis_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights = crit_sus_li_pre;
        matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = 'CriticismHotspot_lis_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights = crit_hot_li_pre;
        matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{7}.tcon.name = 'NeutralSuspence_lis_pre';
        matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights = neut_sus_l_pre;
        matlabbatch{1}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{8}.tcon.name = 'NeutralHotspot_lis_pre';
        matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights = neut_hot_l_pre;
        matlabbatch{1}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.name = 'NeutralSuspence_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights = neut_sus_i_pre;
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.name = 'NeutralHotspot_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights = neut_hot_i_pre;
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{11}.tcon.name = 'NeutralSuspence_lis_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{11}.tcon.weights = neut_sus_li_pre;
        matlabbatch{1}.spm.stats.con.consess{11}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{12}.tcon.name = 'NeutralHotspot_lis_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{12}.tcon.weights = neut_hot_li_pre;
        matlabbatch{1}.spm.stats.con.consess{12}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{13}.tcon.name = 'Crit-NeutSuspence_lis_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{13}.tcon.weights = crit_neut_sus_li_pre;
        matlabbatch{1}.spm.stats.con.consess{13}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{14}.tcon.name = 'Crit-NeutHotspot_lis_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{14}.tcon.weights = crit_neut_hot_li_pre;
        matlabbatch{1}.spm.stats.con.consess{14}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{15}.tcon.name = 'CriticismSuspence_lis_post';
        matlabbatch{1}.spm.stats.con.consess{15}.tcon.weights = crit_sus_l_post;
        matlabbatch{1}.spm.stats.con.consess{15}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{16}.tcon.name = 'CriticismHotspot_lis_post';
        matlabbatch{1}.spm.stats.con.consess{16}.tcon.weights = crit_hot_l_post;
        matlabbatch{1}.spm.stats.con.consess{16}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{17}.tcon.name = 'CriticismSuspence_imag_post';
        matlabbatch{1}.spm.stats.con.consess{17}.tcon.weights = crit_sus_i_post;
        matlabbatch{1}.spm.stats.con.consess{17}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{18}.tcon.name = 'CriticismHotspot_imag_post';
        matlabbatch{1}.spm.stats.con.consess{18}.tcon.weights = crit_hot_i_post;
        matlabbatch{1}.spm.stats.con.consess{18}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{19}.tcon.name = 'CriticismSuspence_lis_imag_post';
        matlabbatch{1}.spm.stats.con.consess{19}.tcon.weights = crit_sus_li_post;
        matlabbatch{1}.spm.stats.con.consess{19}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{20}.tcon.name = 'CriticismHotspot_lis_imag_post';
        matlabbatch{1}.spm.stats.con.consess{20}.tcon.weights = crit_hot_li_post;
        matlabbatch{1}.spm.stats.con.consess{20}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{21}.tcon.name = 'NeutralSuspence_lis_post';
        matlabbatch{1}.spm.stats.con.consess{21}.tcon.weights = neut_sus_l_post;
        matlabbatch{1}.spm.stats.con.consess{21}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{22}.tcon.name = 'NeutralHotspot_lis_post';
        matlabbatch{1}.spm.stats.con.consess{22}.tcon.weights = neut_hot_l_post;
        matlabbatch{1}.spm.stats.con.consess{22}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{23}.tcon.name = 'NeutralSuspence_imag_post';
        matlabbatch{1}.spm.stats.con.consess{23}.tcon.weights = neut_sus_i_post;
        matlabbatch{1}.spm.stats.con.consess{23}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{24}.tcon.name = 'NeutralHotspot_imag_post';
        matlabbatch{1}.spm.stats.con.consess{24}.tcon.weights = neut_hot_i_post;
        matlabbatch{1}.spm.stats.con.consess{24}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{25}.tcon.name = 'NeutralSuspence_lis_imag_post';
        matlabbatch{1}.spm.stats.con.consess{25}.tcon.weights = neut_sus_li_post;
        matlabbatch{1}.spm.stats.con.consess{25}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{26}.tcon.name = 'NeutralHotspot_lis_imag_post';
        matlabbatch{1}.spm.stats.con.consess{26}.tcon.weights = neut_hot_li_post;
        matlabbatch{1}.spm.stats.con.consess{26}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{27}.tcon.name = 'Crit-NeutSuspence_lis_imag_post';
        matlabbatch{1}.spm.stats.con.consess{27}.tcon.weights = crit_neut_sus_li_post;
        matlabbatch{1}.spm.stats.con.consess{27}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{28}.tcon.name = 'Crit-NeutHotspot_lis_imag_post';
        matlabbatch{1}.spm.stats.con.consess{28}.tcon.weights = crit_neut_hot_li_post;
        matlabbatch{1}.spm.stats.con.consess{28}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{29}.tcon.name = 'CriticismSuspence_lis_pre_post';
        matlabbatch{1}.spm.stats.con.consess{29}.tcon.weights = crit_sus_l_pre_post;
        matlabbatch{1}.spm.stats.con.consess{29}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{30}.tcon.name = 'CriticismHotspot_lis_pre_post';
        matlabbatch{1}.spm.stats.con.consess{30}.tcon.weights = crit_hot_l_pre_post;
        matlabbatch{1}.spm.stats.con.consess{30}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{31}.tcon.name = 'CriticismSuspence_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{31}.tcon.weights = crit_sus_i_pre_post;
        matlabbatch{1}.spm.stats.con.consess{31}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{32}.tcon.name = 'CriticismHotspot_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{32}.tcon.weights = crit_hot_i_pre_post;
        matlabbatch{1}.spm.stats.con.consess{32}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{33}.tcon.name = 'CriticismSuspence_lis_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{33}.tcon.weights = crit_sus_li_pre_post;
        matlabbatch{1}.spm.stats.con.consess{33}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{34}.tcon.name = 'CriticismHotspot_lis_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{34}.tcon.weights = crit_hot_li_pre_post;
        matlabbatch{1}.spm.stats.con.consess{34}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{35}.tcon.name = 'NeutralSuspence_lis_pre_post';
        matlabbatch{1}.spm.stats.con.consess{35}.tcon.weights = neut_sus_l_pre_post;
        matlabbatch{1}.spm.stats.con.consess{35}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{36}.tcon.name = 'NeutralHotspot_lis_pre_post';
        matlabbatch{1}.spm.stats.con.consess{36}.tcon.weights = neut_hot_l_pre_post;
        matlabbatch{1}.spm.stats.con.consess{36}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{37}.tcon.name = 'NeutralSuspence_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{37}.tcon.weights = neut_sus_i_pre_post;
        matlabbatch{1}.spm.stats.con.consess{37}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{38}.tcon.name = 'NeutralHotspot_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{38}.tcon.weights = neut_hot_i_pre_post;
        matlabbatch{1}.spm.stats.con.consess{38}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{39}.tcon.name = 'NeutralSuspence_lis_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{39}.tcon.weights = neut_sus_li_pre_post;
        matlabbatch{1}.spm.stats.con.consess{39}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{40}.tcon.name = 'NeutralHotspot_lis_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{40}.tcon.weights = neut_hot_li_pre_post;
        matlabbatch{1}.spm.stats.con.consess{40}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{41}.tcon.name = 'Crit-NeutSuspence_lis_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{41}.tcon.weights = crit_neut_sus_li_pre_post;
        matlabbatch{1}.spm.stats.con.consess{41}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{42}.tcon.name = 'Crit-NeutHotspot_lis_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{42}.tcon.weights = crit_neut_hot_li_pre_post;
        matlabbatch{1}.spm.stats.con.consess{42}.tcon.sessrep = 'none';

end
spm('defaults', 'FMRI');
spm_jobman('run', matlabbatch, inputs{:});
end
