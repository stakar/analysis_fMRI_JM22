%-----------------------------------------------------------------------
% Job saved on 06-Jan-2024 15:24:57 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.stats.fmri_spec.dir = '<UNDEFINED>';
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).scans = '<UNDEFINED>';
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi = '<UNDEFINED>';
matlabbatch{1}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi_reg = '<UNDEFINED>';
matlabbatch{1}.spm.stats.fmri_spec.sess(1).hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).scans = '<UNDEFINED>';
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(2).multi = '<UNDEFINED>';
matlabbatch{1}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(2).multi_reg = '<UNDEFINED>';
matlabbatch{1}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'sess';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'CriticismSuspence_lis';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [0.5 0.5 0.5];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'CriticismHotspot_lis';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [0 0 0 0.5];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'CriticismSuspence_imag';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.weights = [0 0 0 0 0.5 0.5 0.5];
matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{4}.tcon.name = 'CriticismHotspot_imag';
matlabbatch{3}.spm.stats.con.consess{4}.tcon.weights = [0 0 0 0 0 0 0 0.5];
matlabbatch{3}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{5}.tcon.name = 'CriticismSuspence_lis_imag';
matlabbatch{3}.spm.stats.con.consess{5}.tcon.weights = [0.5 0.5 0.5 0 0.5 0.5 0.5];
matlabbatch{3}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{6}.tcon.name = 'CriticismHotspot_lis_imag';
matlabbatch{3}.spm.stats.con.consess{6}.tcon.weights = [0 0 0 0.5 0 0 0 0.5];
matlabbatch{3}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{7}.tcon.name = 'NeutralSuspence_lis';
matlabbatch{3}.spm.stats.con.consess{7}.tcon.weights = [0 0 0 0 0 0 0 0 0.5 0.5 0.5];
matlabbatch{3}.spm.stats.con.consess{7}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{8}.tcon.name = 'NeutralHotspot_lis';
matlabbatch{3}.spm.stats.con.consess{8}.tcon.weights = [0 0 0 0 0 0 0 0 0 0 0 0.5];
matlabbatch{3}.spm.stats.con.consess{8}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{9}.tcon.name = 'NeutralSuspence_imag';
matlabbatch{3}.spm.stats.con.consess{9}.tcon.weights = [0 0 0 0 0 0 0 0 0 0 0 0 0.5 0.5 0.5];
matlabbatch{3}.spm.stats.con.consess{9}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{10}.tcon.name = 'NeutralHotspot_imag';
matlabbatch{3}.spm.stats.con.consess{10}.tcon.weights = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5];
matlabbatch{3}.spm.stats.con.consess{10}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{11}.tcon.name = 'NeutralSuspence_lis_imag';
matlabbatch{3}.spm.stats.con.consess{11}.tcon.weights = [0 0 0 0 0 0 0 0 0.5 0.5 0.5 0 0.5 0.5 0.5];
matlabbatch{3}.spm.stats.con.consess{11}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{12}.tcon.name = 'NeutralHotspot_lis_imag';
matlabbatch{3}.spm.stats.con.consess{12}.tcon.weights = [0 0 0 0 0 0 0 0 0 0 0 0.5 0 0 0 0.5];
matlabbatch{3}.spm.stats.con.consess{12}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.consess{13}.tcon.name = 'Crit-NeutSuspence_lis_imag';
matlabbatch{3}.spm.stats.con.consess{13}.tcon.weights = [0.5 0.5 0.5 0 0.5 0.5 0.5 0 -0.5 -0.5 -0.5 0 -0.5 -0.5 -0.5];
matlabbatch{3}.spm.stats.con.consess{13}.tcon.sessrep = 'repl'; 
matlabbatch{3}.spm.stats.con.consess{14}.tcon.name = 'Crit-NeutHotspot_lis_imag';
matlabbatch{3}.spm.stats.con.consess{14}.tcon.weights = [0 0 0 0.5 0 0 0 0.5 0 0 0 -0.5 0 0 0 -0.5];
matlabbatch{3}.spm.stats.con.consess{14}.tcon.sessrep = 'repl';
matlabbatch{3}.spm.stats.con.delete = 1;
