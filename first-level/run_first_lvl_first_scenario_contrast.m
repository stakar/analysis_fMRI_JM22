
workdir = pwd;
basedir = fullfile(pwd, './'); % git repo location
datadir = fullfile(pwd, '../../results_first/'); % fmriprep dataset location
resdir = fullfile(pwd, '../../results_first/'); % output location
triggdir = fullfile(pwd, '../../triggers_first/');

D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);

subjects = {D.name};

%
%
%UWAGA NA T¥ LINIJKÊ KODU!
%Czasami matlab padnie w trakcie analizy, wiec zaczynamy analizê tam gdzie
%skonczyl i wtedy modyfikujemy ktorych badanych ma analizowac, ponizsza
%linijka jest wtedy przydatna.
%subjects = {'sub-B100', 'sub-B103'};
%
%
%
nrun = numel(subjects); % enter the number of runs here

jobfile = {fullfile(basedir, '../1stlvl/run_first_lvl_ver3_job.m')};

jobs = repmat(jobfile, 1, nrun);
inputs = cell(7, nrun);
for crun = 1:nrun
    for n_ses = 1:2
        sub = subjects{crun};
        spmmat=fullfile(resdir, sub, ['stories-model/ses-' num2str(n_ses) '/SPM.mat']);

        load(spmmat);

        crit_sus_l = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*kryty.*_s_P[1-3]', 'once')));

        crit_hot_l = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*kryty.*_s_P4', 'once')));

        crit_sus_i = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*kryty.*_i_P[1-3]', 'once')));

        crit_hot_i = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*kryty.*_i_P4', 'once')));

        crit_sus_li = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*kryty.*_[si]_P[1-3]', 'once')));

        crit_hot_li = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*kryty.*_[si]_P4', 'once')));

        neut_sus_l = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutral.*_s_P[1-3]', 'once')));

        neut_hot_l = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutral.*_s_P4', 'once')));

        neut_sus_i = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutral.*_i_P[1-3]', 'once')));

        neut_hot_i = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutral.*_i_P4', 'once')));

        neut_sus_li = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutral.*_[si]_P[1-3]', 'once')));

        neut_hot_li = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutral.*_[si]_P4', 'once')));

            
        crit_neut_sus_li = (crit_sus_li - neut_sus_li);
        crit_neut_hot_li = (crit_hot_li - neut_hot_li);
        
        criticism_li = (crit_hot_li + crit_sus_li);
        criticism_l = (crit_hot_l + crit_sus_l);
        criticism_i = (crit_hot_i + crit_sus_i);
        
        % Sprawdzenie, czy jest przynajmniej jedno dopasowanie
        if any(contains(SPM.xX.name, 'krytykaTerap'))
            disp('First scenario is criticism');
            first_scen_sus_li = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytykaTerap_[si]_P[1-3]', 'once')));          
            first_scen_sus_l = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytykaTerap_s_P[1-3]', 'once')));
            first_scen_sus_i = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytykaTerap_i_P[1-3]', 'once')));
            first_scen_hot_li = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytykaTerap_[si]_P4', 'once')));          
            first_scen_hot_l = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytykaTerap_s_P4', 'once')));
            first_scen_hot_i = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*krytykaTerap_i_P4', 'once')));

        end
        
        % Sprawdzenie, czy jest przynajmniej jedno dopasowanie
        if any(contains(SPM.xX.name, 'neutralnyTerap'))
            disp('First scenario is neutral');
            first_scen_sus_li = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralnyTerap_[si]_P[1-3]', 'once')));          
            first_scen_sus_l = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralnyTerap_s_P[1-3]', 'once')));
            first_scen_sus_i = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralnyTerap_i_P[1-3]', 'once')));
            first_scen_hot_li = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralnyTerap_[si]_P4', 'once')));          
            first_scen_hot_l = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralnyTerap_s_P4', 'once')));
            first_scen_hot_i = real(~cellfun('isempty', regexp(SPM.xX.name,...
            '.*[1-2].*neutralnyTerap_i_P4', 'once')));

        end
        
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

        matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'CriticismSuspence_lis';
        matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = crit_sus_l;
        matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'CriticismHotspot_lis';
        matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = crit_hot_l;
        matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'CriticismSuspence_imag';
        matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = crit_sus_i;
        matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'CriticismHotspot_imag';
        matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = crit_hot_i;
        matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'CriticismSuspence_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights = crit_sus_li;
        matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = 'CriticismHotspot_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights = crit_hot_li;
        matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{7}.tcon.name = 'NeutralSuspence_lis';
        matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights = neut_sus_l;
        matlabbatch{1}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{8}.tcon.name = 'NeutralHotspot_lis';
        matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights = neut_hot_l;
        matlabbatch{1}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.name = 'NeutralSuspence_imag';
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights = neut_sus_i;
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.name = 'NeutralHotspot_imag';
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights = neut_hot_i;
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{11}.tcon.name = 'NeutralSuspence_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{11}.tcon.weights = neut_sus_li;
        matlabbatch{1}.spm.stats.con.consess{11}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{12}.tcon.name = 'NeutralHotspot_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{12}.tcon.weights = neut_hot_li;
        matlabbatch{1}.spm.stats.con.consess{12}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{13}.tcon.name = 'Crit-NeutSuspence_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{13}.tcon.weights = crit_neut_sus_li;
        matlabbatch{1}.spm.stats.con.consess{13}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{14}.tcon.name = 'Crit-NeutHotspot_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{14}.tcon.weights = crit_neut_hot_li;
        matlabbatch{1}.spm.stats.con.consess{14}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{15}.tcon.name = 'Criticism_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{15}.tcon.weights = criticism_li;
        matlabbatch{1}.spm.stats.con.consess{15}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{16}.tcon.name = 'Criticism_lis';
        matlabbatch{1}.spm.stats.con.consess{16}.tcon.weights = criticism_l;
        matlabbatch{1}.spm.stats.con.consess{16}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{17}.tcon.name = 'Criticism_imag';
        matlabbatch{1}.spm.stats.con.consess{17}.tcon.weights = criticism_i;
        matlabbatch{1}.spm.stats.con.consess{17}.tcon.sessrep = 'none';
                
        matlabbatch{1}.spm.stats.con.consess{18}.tcon.name = 'First_Hotspot_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{18}.tcon.weights = first_scen_hot_li;
        matlabbatch{1}.spm.stats.con.consess{18}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{19}.tcon.name = 'First_Hotspot_lis';
        matlabbatch{1}.spm.stats.con.consess{19}.tcon.weights = first_scen_hot_l;
        matlabbatch{1}.spm.stats.con.consess{19}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{20}.tcon.name = 'First_Hotspot_imag';
        matlabbatch{1}.spm.stats.con.consess{20}.tcon.weights = first_scen_hot_i;
        matlabbatch{1}.spm.stats.con.consess{20}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{21}.tcon.name = 'First_Suspence_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{21}.tcon.weights = first_scen_sus_li;
        matlabbatch{1}.spm.stats.con.consess{21}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{22}.tcon.name = 'First_Suspence_lis';
        matlabbatch{1}.spm.stats.con.consess{22}.tcon.weights = first_scen_sus_l;
        matlabbatch{1}.spm.stats.con.consess{22}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{23}.tcon.name = 'First_Suspence_imag';
        matlabbatch{1}.spm.stats.con.consess{23}.tcon.weights = first_scen_sus_i;
        matlabbatch{1}.spm.stats.con.consess{23}.tcon.sessrep = 'none';
        
        
        matlabbatch{1}.spm.stats.con.consess{24}.tcon.name = 'Therapy_PredError_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{24}.tcon.weights = therapy_pe_li;
        matlabbatch{1}.spm.stats.con.consess{24}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{25}.tcon.name = 'Therapy_PredError_lis';
        matlabbatch{1}.spm.stats.con.consess{25}.tcon.weights = therapy_pe_l;
        matlabbatch{1}.spm.stats.con.consess{25}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{26}.tcon.name = 'Therapy_PredError_imag';
        matlabbatch{1}.spm.stats.con.consess{26}.tcon.weights = therapy_pe_i;
        matlabbatch{1}.spm.stats.con.consess{26}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{27}.tcon.name = 'Therapy_Suspence_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{27}.tcon.weights = therapy_sus_li;
        matlabbatch{1}.spm.stats.con.consess{27}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{28}.tcon.name = 'Therapy_Suspence_lis';
        matlabbatch{1}.spm.stats.con.consess{28}.tcon.weights = therapy_sus_l;
        matlabbatch{1}.spm.stats.con.consess{28}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{29}.tcon.name = 'Therapy_Suspence_imag';
        matlabbatch{1}.spm.stats.con.consess{29}.tcon.weights = therapy_sus_i;
        matlabbatch{1}.spm.stats.con.consess{29}.tcon.sessrep = 'none';
        
        matlabbatch{1}.spm.stats.con.consess{30}.tcon.name = 'Therapy_Intervention_lis_imag';
        matlabbatch{1}.spm.stats.con.consess{30}.tcon.weights = therapy_int_li;
        matlabbatch{1}.spm.stats.con.consess{30}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.consess{31}.tcon.name = 'Therapy_Intervention_lis';
        matlabbatch{1}.spm.stats.con.consess{31}.tcon.weights = therapy_int_l;
        matlabbatch{1}.spm.stats.con.consess{31}.tcon.sessrep = 'none'; 
        matlabbatch{1}.spm.stats.con.consess{32}.tcon.name = 'Therapy_Intervention_imag';
        matlabbatch{1}.spm.stats.con.consess{32}.tcon.weights = therapy_int_i;
        matlabbatch{1}.spm.stats.con.consess{32}.tcon.sessrep = 'none';
        matlabbatch{1}.spm.stats.con.delete = 1;
    spm('defaults', 'FMRI');
    spm_jobman('run', matlabbatch, inputs{:});
    end
end
