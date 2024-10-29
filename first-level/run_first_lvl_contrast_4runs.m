
workdir = pwd;
basedir = fullfile(pwd, './'); % git repo location
datadir = fullfile(pwd, '../../results_4lvl/'); % fmriprep dataset location
resdir = fullfile(pwd, '../../results_4lvl/'); % output location
triggdir = fullfile(pwd, '../../triggers_first_scenario/');

D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);

subjects = {D.name};

%
%
%UWAGA NA T¥ LINIJKÊ KODU!
%Czasami matlab padnie w trakcie analizy, wiec zaczynamy analizê tam gdzie
%skonczyl i wtedy modyfikujemy ktorych badanych ma analizowac, ponizsza
%linijka jest wtedy przydatna.
% subjects = {'sub-B100', 'sub-B103'};
%
%
%
nrun = numel(subjects); % enter the number of runs here

jobfile = {fullfile(basedir, '../1stlvl/run_first_lvl_ver3_job.m')};

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


        crit_neut_sus_li_pre = (crit_sus_li_pre - neut_sus_li_pre);
        crit_neut_hot_li_pre = (crit_hot_li_pre - neut_hot_li_pre);
        
        crit_neut_sus_li_post = (crit_sus_li_post - neut_sus_li_post);
        crit_neut_hot_li_post = (crit_hot_li_post - neut_hot_li_post);
        
        crit_sus_l_pre_post = (crit_sus_l_pre - crit_sus_l_post);
        
        crit_sus_i_pre_post = (crit_sus_i_pre - crit_sus_i_post);
        
        crit_sus_li_pre_post = (crit_sus_li_pre - crit_sus_li_post);
        
        crit_hot_l_pre_post = (crit_hot_l_pre - crit_hot_l_post);
        
        crit_hot_i_pre_post = (crit_hot_i_pre - crit_hot_i_post);
        
        crit_hot_li_pre_post = (crit_hot_li_pre - crit_hot_li_post);
        
        neut_sus_l_pre_post = (neut_sus_l_pre - neut_sus_l_post);
        
        neut_sus_i_pre_post = (neut_sus_i_pre - neut_sus_i_post);
        
        neut_sus_li_pre_post = (neut_sus_li_pre - neut_sus_li_post);
        
        neut_hot_l_pre_post = (neut_hot_l_pre - neut_hot_l_post);
        
        neut_hot_i_pre_post = (neut_hot_i_pre - neut_hot_i_post);
        
        neut_hot_li_pre_post = (neut_hot_li_pre - neut_hot_li_post);
        
        crit_neut_sus_li_pre_post = (crit_neut_sus_li_pre - crit_neut_sus_li_post);
        crit_neut_hot_li_pre_post = (crit_neut_hot_li_pre - crit_neut_hot_li_post);
        
        
        criticism_li_pre = (crit_hot_li_pre + crit_sus_li_pre);
        criticism_l_pre = (crit_hot_l_pre + crit_sus_l_pre);
        criticism_i_pre = (crit_hot_i_pre + crit_sus_i_pre);
        
        
        criticism_li_post = (crit_hot_li_post + crit_sus_li_post);
        criticism_l_post = (crit_hot_l_post + crit_sus_l_post);
        criticism_i_post = (crit_hot_i_post + crit_sus_i_post);
        

        criticism_li_pre_post = (crit_hot_li_pre_post + crit_sus_li_pre_post);
        criticism_l_pre_post = (crit_hot_l_pre_post + crit_sus_l_pre_post);
        criticism_i_pre_post = (crit_hot_i_pre_post + crit_sus_i_pre_post);
        
        % Sprawdzenie, czy jest przynajmniej jedno dopasowanie
        if any(contains(SPM.xX.name, 'krytykaTerap'))
            disp('First scenario is criticism');
            first_scen_sus_li_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytykaTerap_[si]_P[1-3]', 'once')));          
            first_scen_sus_l_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytykaTerap_s_P[1-3]', 'once')));
            first_scen_sus_i_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytykaTerap_i_P[1-3]', 'once')));
            first_scen_hot_li_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytykaTerap_[si]_P4', 'once')));          
            first_scen_hot_l_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytykaTerap_s_P4', 'once')));
            first_scen_hot_i_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytykaTerap_i_P4', 'once')));
            first_scen_sus_li_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*krytykaTerap_[si]_P[1-3]', 'once')));          
            first_scen_sus_l_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*krytykaTerap_s_P[1-3]', 'once')));
            first_scen_sus_i_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*krytykaTerap_i_P[1-3]', 'once')));
            first_scen_hot_li_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*krytykaTerap_[si]_P4', 'once')));          
            first_scen_hot_l_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*krytykaTerap_s_P4', 'once')));
            first_scen_hot_i_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*krytykaTerap_i_P4', 'once')));

        end
                
        
        % Sprawdzenie, czy jest przynajmniej jedno dopasowanie
        if any(contains(SPM.xX.name, 'neutralnyTerap'))
            disp('First scenario is neutral');
            first_scen_sus_li_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralnyTerap_[si]_P[1-3]', 'once')));          
            first_scen_sus_l_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralnyTerap_s_P[1-3]', 'once')));
            first_scen_sus_i_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralnyTerap_i_P[1-3]', 'once')));
            first_scen_hot_li_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralnyTerap_[si]_P4', 'once')));          
            first_scen_hot_l_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralnyTerap_s_P4', 'once')));
            first_scen_hot_i_pre = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralnyTerap_i_P4', 'once')));
            first_scen_sus_li_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*neutralnyTerap_[si]_P[1-3]', 'once')));          
            first_scen_sus_l_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*neutralnyTerap_s_P[1-3]', 'once')));
            first_scen_sus_i_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*neutralnyTerap_i_P[1-3]', 'once')));
            first_scen_hot_li_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*neutralnyTerap_[si]_P4', 'once')));          
            first_scen_hot_l_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*neutralnyTerap_s_P4', 'once')));
            first_scen_hot_i_post = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[3-4].*neutralnyTerap_i_P4', 'once')));
        end
        first_scen_sus_li_pre_post = first_scen_sus_li_pre-first_scen_sus_li_post;
        first_scen_sus_l_pre_post = first_scen_sus_l_pre-first_scen_sus_l_post;
        first_scen_sus_i_pre_post = first_scen_sus_i_pre-first_scen_sus_i_post;
        first_scen_hot_li_pre_post = first_scen_hot_li_pre-first_scen_hot_li_post;
        first_scen_hot_l_pre_post = first_scen_hot_l_pre-first_scen_hot_l_post;
        first_scen_hot_i_pre_post = first_scen_hot_i_pre-first_scen_hot_i_post;
        
        therapy_sus_li = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*therapy.*_[si]_P[123]', 'once')));
        therapy_sus_l = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*therapy.*_[s]_P[123]', 'once')));
        therapy_sus_i = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*therapy.*_[i]_P[123]', 'once')));
        
        therapy_pe_li = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*therapy.*_[si]_P4', 'once')));
        therapy_pe_l = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*therapy.*_[s]_P4', 'once')));
        therapy_pe_i = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*therapy.*_[i]_P4', 'once')));
        
        therapy_int_li = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*therapy.*_[si]_P[4567]', 'once')));
        therapy_int_l = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*therapy.*_[s]_P[4567]', 'once')));
        therapy_int_i = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*therapy.*_[i]_P[4567]', 'once')));
        
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
        
        matlabbatch{1}.spm.stats.con.consess{43}.tcon.name = 'Criticism_lis_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{43}.tcon.weights = criticism_li_pre;
        matlabbatch{1}.spm.stats.con.consess{43}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{44}.tcon.name = 'Criticism_lis_pre';
        matlabbatch{1}.spm.stats.con.consess{44}.tcon.weights = criticism_l_pre;
        matlabbatch{1}.spm.stats.con.consess{44}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{45}.tcon.name = 'Criticism_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{45}.tcon.weights = criticism_i_pre;
        matlabbatch{1}.spm.stats.con.consess{45}.tcon.sessrep = 'none';
                
        matlabbatch{1}.spm.stats.con.consess{46}.tcon.name = 'First_Hotspot_lis_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{46}.tcon.weights = first_scen_hot_li_pre;
        matlabbatch{1}.spm.stats.con.consess{46}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{47}.tcon.name = 'First_Hotspot_lis_pre';
        matlabbatch{1}.spm.stats.con.consess{47}.tcon.weights = first_scen_hot_l_pre;
        matlabbatch{1}.spm.stats.con.consess{47}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{48}.tcon.name = 'First_Hotspot_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{48}.tcon.weights = first_scen_hot_i_pre;
        matlabbatch{1}.spm.stats.con.consess{48}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{49}.tcon.name = 'First_Suspence_lis_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{49}.tcon.weights = first_scen_sus_li_pre;
        matlabbatch{1}.spm.stats.con.consess{49}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{50}.tcon.name = 'First_Suspence_lis_pre';
        matlabbatch{1}.spm.stats.con.consess{50}.tcon.weights = first_scen_sus_l_pre;
        matlabbatch{1}.spm.stats.con.consess{50}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{51}.tcon.name = 'First_Suspence_imag_pre';
        matlabbatch{1}.spm.stats.con.consess{51}.tcon.weights = first_scen_sus_i_pre;
        matlabbatch{1}.spm.stats.con.consess{51}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{52}.tcon.name = 'Criticism_lis_imag_post';
        matlabbatch{1}.spm.stats.con.consess{52}.tcon.weights = criticism_li_post;
        matlabbatch{1}.spm.stats.con.consess{52}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{53}.tcon.name = 'Criticism_lis_post';
        matlabbatch{1}.spm.stats.con.consess{53}.tcon.weights = criticism_l_post;
        matlabbatch{1}.spm.stats.con.consess{53}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{54}.tcon.name = 'Criticism_imag_post';
        matlabbatch{1}.spm.stats.con.consess{54}.tcon.weights = criticism_i_post;
        matlabbatch{1}.spm.stats.con.consess{54}.tcon.sessrep = 'none';
                
        matlabbatch{1}.spm.stats.con.consess{55}.tcon.name = 'First_Hotspot_lis_imag_post';
        matlabbatch{1}.spm.stats.con.consess{55}.tcon.weights = first_scen_hot_li_post;
        matlabbatch{1}.spm.stats.con.consess{55}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{56}.tcon.name = 'First_Hotspot_lis_post';
        matlabbatch{1}.spm.stats.con.consess{56}.tcon.weights = first_scen_hot_l_post;
        matlabbatch{1}.spm.stats.con.consess{56}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{57}.tcon.name = 'First_Hotspot_imag_post';
        matlabbatch{1}.spm.stats.con.consess{57}.tcon.weights = first_scen_hot_i_post;
        matlabbatch{1}.spm.stats.con.consess{57}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{58}.tcon.name = 'First_Suspence_lis_imag_post';
        matlabbatch{1}.spm.stats.con.consess{58}.tcon.weights = first_scen_sus_li_post;
        matlabbatch{1}.spm.stats.con.consess{58}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{59}.tcon.name = 'First_Suspence_lis_post';
        matlabbatch{1}.spm.stats.con.consess{59}.tcon.weights = first_scen_sus_l_post;
        matlabbatch{1}.spm.stats.con.consess{59}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{60}.tcon.name = 'First_Suspence_imag_post';
        matlabbatch{1}.spm.stats.con.consess{60}.tcon.weights = first_scen_sus_i_post;
        matlabbatch{1}.spm.stats.con.consess{60}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{61}.tcon.name = 'Criticism_lis_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{61}.tcon.weights = criticism_li_pre_post;
        matlabbatch{1}.spm.stats.con.consess{61}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{62}.tcon.name = 'Criticism_lis_pre_post';
        matlabbatch{1}.spm.stats.con.consess{62}.tcon.weights = criticism_l_pre_post;
        matlabbatch{1}.spm.stats.con.consess{62}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{63}.tcon.name = 'Criticism_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{63}.tcon.weights = criticism_i_pre_post;
        matlabbatch{1}.spm.stats.con.consess{63}.tcon.sessrep = 'none';
                
        matlabbatch{1}.spm.stats.con.consess{64}.tcon.name = 'First_Hotspot_lis_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{64}.tcon.weights = first_scen_hot_li_pre_post;
        matlabbatch{1}.spm.stats.con.consess{64}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{65}.tcon.name = 'First_Hotspot_lis_pre_post';
        matlabbatch{1}.spm.stats.con.consess{65}.tcon.weights = first_scen_hot_l_pre_post;
        matlabbatch{1}.spm.stats.con.consess{65}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{66}.tcon.name = 'First_Hotspot_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{66}.tcon.weights = first_scen_hot_i_pre_post;
        matlabbatch{1}.spm.stats.con.consess{66}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{67}.tcon.name = 'First_Suspence_lis_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{67}.tcon.weights = first_scen_sus_li_pre_post;
        matlabbatch{1}.spm.stats.con.consess{67}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{68}.tcon.name = 'First_Suspence_lis_pre_post';
        matlabbatch{1}.spm.stats.con.consess{68}.tcon.weights = first_scen_sus_l_pre_post;
        matlabbatch{1}.spm.stats.con.consess{68}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{69}.tcon.name = 'First_Suspence_imag_pre_post';
        matlabbatch{1}.spm.stats.con.consess{69}.tcon.weights = first_scen_sus_i_pre_post;
        matlabbatch{1}.spm.stats.con.consess{69}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{70}.tcon.name = 'Therapy_PredError_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{70}.tcon.weights = therapy_pe_li;
        matlabbatch{1}.spm.stats.con.consess{70}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{71}.tcon.name = 'Therapy_PredError_lis';
        matlabbatch{1}.spm.stats.con.consess{71}.tcon.weights = therapy_pe_l;
        matlabbatch{1}.spm.stats.con.consess{71}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{72}.tcon.name = 'Therapy_PredError_imag';
        matlabbatch{1}.spm.stats.con.consess{72}.tcon.weights = therapy_pe_i;
        matlabbatch{1}.spm.stats.con.consess{72}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{73}.tcon.name = 'Therapy_Suspence_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{73}.tcon.weights = therapy_sus_li;
        matlabbatch{1}.spm.stats.con.consess{73}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{74}.tcon.name = 'Therapy_Suspence_lis';
        matlabbatch{1}.spm.stats.con.consess{74}.tcon.weights = therapy_sus_l;
        matlabbatch{1}.spm.stats.con.consess{74}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{75}.tcon.name = 'Therapy_Suspence_imag';
        matlabbatch{1}.spm.stats.con.consess{75}.tcon.weights = therapy_sus_i;
        matlabbatch{1}.spm.stats.con.consess{75}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{76}.tcon.name = 'Therapy_Intervention_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{76}.tcon.weights = therapy_int_li;
        matlabbatch{1}.spm.stats.con.consess{76}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{77}.tcon.name = 'Therapy_Intervention_lis';
        matlabbatch{1}.spm.stats.con.consess{77}.tcon.weights = therapy_int_l;
        matlabbatch{1}.spm.stats.con.consess{77}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{78}.tcon.name = 'Therapy_Intervention_imag';
        matlabbatch{1}.spm.stats.con.consess{78}.tcon.weights = therapy_int_i;
        matlabbatch{1}.spm.stats.con.consess{78}.tcon.sessrep = 'none';

end
spm('defaults', 'FMRI');
spm_jobman('run', matlabbatch, inputs{:});
end
