
%Stanislaw tutaj wez ogarnij listę osób i w fileloopie wrzuc id osoby aby 
%id bylo brane z listy
workdir = pwd;
basedir = fullfile(pwd, '../../code/'); % git repo location
datadir = fullfile('E:/SPM_test/results_first/'); % fmriprep dataset location
resdir = fullfile(pwd, '../../results_2ndLvl/ttestInd/'); % output location
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
conditions = readtable(fullfile(basedir, 'condition_group.csv'));
IMRS = strcat('sub-',conditions.code(strmatch("exp",conditions.group)));
CONTROL = strcat('sub-',conditions.code(strmatch("cont",conditions.group)));
IMRS = intersect(IMRS, included_subjects);
CONTROL = intersect(CONTROL, included_subjects);







% TRZEBA ZMIENIĆ Z POWROTEM PONIŻSZĄ LINIJKĘ
for fileloop=1:numel(subjects)%pętla, która wykona analizę gPPI na %rosnącym id osób badanych
% for fileloop=1:3%pętla, która wykona analizę gPPI na %rosnącym id osób badanych
    subject = subjects{fileloop};
%     try %funkcja 'try' umożliwi wykonywanie kodu nawet %jeżeli w analizie brakuje nam ciągłości osób badanych -tj. %jeśli wśród 60 osób badanych brakuje nam osoby o id np. %10
        files = sprintf(subject); %jako %subject należy wpisać pierwszy człon id naszych osób %badanych (nazwy folderów zawierających obrazy .nii i %modele)
        name1='E:/SPM_test/VOI_VOI_vmpfc_crithot_li.mat'; %ścieżka do maski będącej %seedem
        VOIr=name1;
        direc= fullfile(sprintf('E:/SPM_test/results_first/%s/stories-model/ses-1/',subject)) ;  %ścieżka do %modelu 1st level będącego podstawą analizy gPPI
        P.subject=files;
        P.directory=[direc];
        P.VOI=[VOIr];
        P.Region='';  %nazwa obszaru seed %- stanie się również nazwą podfolderu z analizą gPPI
        P.analysis='psy'; %deklaracja, że wykonujemy %'physiophysiological interaction'
        P.method='cond'; %jeżeli interesuje nas gPPI to %zostawiamy tak jak jest tutaj. Jeśli chcemy policzyć %klasycznego PPI, to zmieniamy wartość na 'trad'
        P.Estimate=1;
        P.contrast=0; %kontrast do którego zostanie dostosowana analiza. Omnibus %F-test jest domyślny i zostanie utworzony automatycznie. 
        P.extract='eig';
        if ismember(subject,CONTROL)
        P.Tasks= {'0','neutralnyTerap_s_P1_Run1_tp1','neutralnyTerap_s_P2_Run1_tp1','neutralnyTerap_s_P3_Run1_tp1',...
        'neutralnyTerap_s_P4_Run1_tp1','neutralnyTerap_i_P1_Run1_tp1','neutralnyTerap_i_P2_Run1_tp1',...
        'neutralnyTerap_i_P3_Run1_tp1','neutralnyTerap_i_P4_Run1_tp1','krytyka_s_P1_Run1_tp1',...
        'krytyka_s_P2_Run1_tp1','krytyka_s_P3_Run1_tp1','krytyka_s_P4_Run1_tp1',...
        'krytyka_i_P1_Run1_tp1','krytyka_i_P2_Run1_tp1','krytyka_i_P3_Run1_tp1',...
        'krytyka_i_P4_Run1_tp1','neutralne_s_P1_Run1_tp1','neutralne_s_P2_Run1_tp1',...
        'neutralne_s_P3_Run1_tp1','neutralne_s_P4_Run1_tp1','neutralne_i_P1_Run1_tp1',...
        'neutralne_i_P2_Run1_tp1','neutralne_i_P3_Run1_tp1','neutralne_i_P4_Run1_tp1','krytyka_s_P1_Run2_tp1',...
        'krytyka_s_P2_Run2_tp1','krytyka_s_P3_Run2_tp1','krytyka_s_P4_Run2_tp1',...
        'krytyka_i_P1_Run2_tp1','krytyka_i_P2_Run2_tp1','krytyka_i_P3_Run2_tp1',...
        'krytyka_i_P4_Run2_tp1','neutralne_s_P1_Run2_tp1','neutralne_s_P2_Run2_tp1',...
        'neutralne_s_P3_Run2_tp1','neutralne_s_P4_Run2_tp1','neutralne_i_P1_Run2_tp1',...
        'neutralne_i_P2_Run2_tp1','neutralne_i_P3_Run2_tp1','neutralne_i_P4_Run2_tp1',...
        'therapy_s_P1_Run2_tp1','therapy_s_P2_Run2_tp1','therapy_s_P3_Run2_tp1',...
        'therapy_s_P4_Run2_tp1','therapy_s_P5_Run2_tp1','therapy_s_P6_Run2_tp1',...
        'therapy_s_P7_Run2_tp1','therapy_i_P1_Run2_tp1','therapy_i_P2_Run2_tp1',...
        'therapy_i_P3_Run2_tp1','therapy_i_P4_Run2_tp1','therapy_i_P5_Run2_tp1',...
        'therapy_i_P6_Run2_tp1','therapy_i_P7_Run2_tp1','WAIT_TRIAL','STOR_END','Ding'};
        else
                    P.Tasks= {'0','krytykaTerap_s_P1_Run1_tp1','krytykaTerap_s_P2_Run1_tp1','krytykaTerap_s_P3_Run1_tp1',...
        'krytykaTerap_s_P4_Run1_tp1','krytykaTerap_i_P1_Run1_tp1','krytykaTerap_i_P2_Run1_tp1',...
        'krytykaTerap_i_P3_Run1_tp1','krytykaTerap_i_P4_Run1_tp1','krytyka_s_P1_Run1_tp1',...
        'krytyka_s_P2_Run1_tp1','krytyka_s_P3_Run1_tp1','krytyka_s_P4_Run1_tp1',...
        'krytyka_i_P1_Run1_tp1','krytyka_i_P2_Run1_tp1','krytyka_i_P3_Run1_tp1',...
        'krytyka_i_P4_Run1_tp1','neutralne_s_P1_Run1_tp1','neutralne_s_P2_Run1_tp1',...
        'neutralne_s_P3_Run1_tp1','neutralne_s_P4_Run1_tp1','neutralne_i_P1_Run1_tp1',...
        'neutralne_i_P2_Run1_tp1','neutralne_i_P3_Run1_tp1','neutralne_i_P4_Run1_tp1','krytyka_s_P1_Run2_tp1',...
        'krytyka_s_P2_Run2_tp1','krytyka_s_P3_Run2_tp1','krytyka_s_P4_Run2_tp1',...
        'krytyka_i_P1_Run2_tp1','krytyka_i_P2_Run2_tp1','krytyka_i_P3_Run2_tp1',...
        'krytyka_i_P4_Run2_tp1','neutralne_s_P1_Run2_tp1','neutralne_s_P2_Run2_tp1',...
        'neutralne_s_P3_Run2_tp1','neutralne_s_P4_Run2_tp1','neutralne_i_P1_Run2_tp1',...
        'neutralne_i_P2_Run2_tp1','neutralne_i_P3_Run2_tp1','neutralne_i_P4_Run2_tp1',...
        'therapy_s_P1_Run2_tp1','therapy_s_P2_Run2_tp1','therapy_s_P3_Run2_tp1',...
        'therapy_s_P4_Run2_tp1','therapy_s_P5_Run2_tp1','therapy_s_P6_Run2_tp1',...
        'therapy_s_P7_Run2_tp1','therapy_i_P1_Run2_tp1','therapy_i_P2_Run2_tp1',...
        'therapy_i_P3_Run2_tp1','therapy_i_P4_Run2_tp1','therapy_i_P5_Run2_tp1',...
        'therapy_i_P6_Run2_tp1','therapy_i_P7_Run2_tp1','WAIT_TRIAL','STOR_END','Ding'};
        end
        P.Weights=[];
        P.equalroi=0; % 1 oznacza, że wszystkie seedy %muszą być jednakowej wielkości u wszystkich osób. Ta %zasada może być problematyczna jeśli nasz seed znajduje %się blisko krańców mózgu (lub w obszarach podatnych na %zniekształcenia pola podczas skanowania)
        P.FLmask=1; % 0 oznacza, że maska seeda nie będzie %ograniczona przez maskę aktywności z 1st levelu. W %przypadku błędu przy tych ustawieniach można zmienić %P.equalroi=0 i P.FLmask=1
        P.CompContrasts=1;
        mkdir(sprintf('E:/SPM_test/results_first/%s/GPPI/ses-1/vmPFC/', subject));
        direco= fullfile(sprintf('E:/SPM_test/results_first/%s/GPPI/ses-1/vmPFC/', subject)); %ścieżka do zapisania modelu gPPI
        P.outdir=direco;
        %Poniżej należy wypisać interesujące nas kontrasy. %W przypadku
        %t-testu porównanie jest wykonywane w następujący %sposób :left>right
        %UWAGA! Należy na tym etapie zdefiniować wszystkie %interesujące nas
        %porównania. Po obliczeniu modelu nie ma %możliwości dodania nowych
        %kontrastów - będzie to wymagało ponownego %obliczenia modelu z
        %dodatkowymi kontrastami.
        P.Contrasts(1).name='Criticism_PPI_suspence';
        P.Contrasts(1).left={'krytyka_s_P1_Run1_tp1','krytyka_s_P2_Run1_tp1','krytyka_s_P3_Run1_tp1','krytyka_i_P1_Run1_tp1',...
            'krytyka_i_P2_Run1_tp1','krytyka_i_P3_Run1_tp1','krytyka_s_P1_Run2_tp1','krytyka_s_P2_Run2_tp1','krytyka_s_P3_Run2_tp1',...
            'krytyka_i_P1_Run2_tp1','krytyka_i_P2_Run2_tp1','krytyka_i_P3_Run2_tp1'};
        P.Contrasts(1).right={ 'none' };
        P.Contrasts(1).MinEvents=1;
        P.Contrasts(1).STAT='T';
        
        P.Contrasts(2).name='Criticism_all_PPI_hotspot';
        P.Contrasts(2).left={'krytyka_s_P4_Run1_tp1','krytyka_i_P4_Run1_tp1', 'krytyka_s_P4_Run2_tp1','krytyka_i_P4_Run2_tp1'};
        P.Contrasts(2).right={ 'none' };
        P.Contrasts(2).MinEvents=1;
        P.Contrasts(2).STAT='T';
        
 
        
        P.Contrasts(3).name='Criticism_all_PPI';
        P.Contrasts(3).left={'krytyka_s_P1_Run1_tp1','krytyka_s_P2_Run1_tp1','krytyka_s_P3_Run1_tp1','krytyka_i_P1_Run1_tp1',...
            'krytyka_i_P2_Run1_tp1','krytyka_i_P3_Run1_tp1','krytyka_s_P1_Run2_tp1','krytyka_s_P2_Run2_tp1','krytyka_s_P3_Run2_tp1',...
            'krytyka_i_P1_Run2_tp1','krytyka_i_P2_Run2_tp1','krytyka_i_P3_Run2_tp1','krytyka_s_P4_Run1_tp1','krytyka_i_P4_Run1_tp1', 'krytyka_s_P4_Run2_tp1','krytyka_i_P4_Run2_tp1'};
        P.Contrasts(3).right={ 'none' };
        P.Contrasts(3).MinEvents=1;
        P.Contrasts(3).STAT='T';
        
        P.Contrasts(4).name='CriticismNeutral_PPI_hotspot';
        P.Contrasts(4).left={'krytyka_s_P4_Run1_tp1','krytyka_i_P4_Run1_tp1', 'krytyka_s_P4_Run2_tp1','krytyka_i_P4_Run2_tp1'};
        P.Contrasts(4).right={'neutralne_s_P4_Run1_tp1','neutralne_i_P4_Run1_tp1', 'neutralne_s_P4_Run2_tp1','neutralne_i_P4_Run2_tp1'};
        P.Contrasts(4).MinEvents=1;
        P.Contrasts(4).STAT='T';
        
        
        P.Contrasts(5).name='CriticismNeutral_PPI_suspence';
        P.Contrasts(5).left={'krytyka_s_P1_Run1_tp1','krytyka_i_P1_Run1_tp1', 'krytyka_s_P1_Run2_tp1','krytyka_i_P1_Run2_tp1',...
            'krytyka_s_P2_Run1_tp1','krytyka_i_P2_Run1_tp1', 'krytyka_s_P2_Run2_tp1','krytyka_i_P2_Run2_tp1',...
            'krytyka_s_P3_Run1_tp1','krytyka_i_P3_Run1_tp1', 'krytyka_s_P3_Run2_tp1','krytyka_i_P3_Run2_tp1'};
        P.Contrasts(5).right={'neutralne_s_P1_Run1_tp1','neutralne_i_P1_Run1_tp1', 'neutralne_s_P1_Run2_tp1','neutralne_i_P1_Run2_tp1',...
            'neutralne_s_P2_Run1_tp1','neutralne_i_P2_Run1_tp1', 'neutralne_s_P2_Run2_tp1','neutralne_i_P2_Run2_tp1',...
            'neutralne_s_P3_Run1_tp1','neutralne_i_P3_Run1_tp1', 'neutralne_s_P3_Run2_tp1','neutralne_i_P3_Run2_tp1'};
        P.Contrasts(5).MinEvents=1;
        P.Contrasts(5).STAT='T';
        
        P.Contrasts(6).name='CriticismNeutral_PPI_all';
        P.Contrasts(6).left={'krytyka_s_P1_Run1_tp1','krytyka_i_P1_Run1_tp1', 'krytyka_s_P1_Run2_tp1','krytyka_i_P1_Run2_tp1',...
            'krytyka_s_P2_Run1_tp1','krytyka_i_P2_Run1_tp1', 'krytyka_s_P2_Run2_tp1','krytyka_i_P2_Run2_tp1',...
            'krytyka_s_P3_Run1_tp1','krytyka_i_P3_Run1_tp1', 'krytyka_s_P3_Run2_tp1','krytyka_i_P3_Run2_tp1',...
            'krytyka_s_P4_Run1_tp1','krytyka_i_P4_Run1_tp1', 'krytyka_s_P4_Run2_tp1','krytyka_i_P4_Run2_tp1'};
        P.Contrasts(6).right={'neutralne_s_P1_Run1_tp1','neutralne_i_P1_Run1_tp1', 'neutralne_s_P1_Run2_tp1','neutralne_i_P1_Run2_tp1',...
            'neutralne_s_P2_Run1_tp1','neutralne_i_P2_Run1_tp1', 'neutralne_s_P2_Run2_tp1','neutralne_i_P2_Run2_tp1',...
            'neutralne_s_P3_Run1_tp1','neutralne_i_P3_Run1_tp1', 'neutralne_s_P3_Run2_tp1','neutralne_i_P3_Run2_tp1',...
            'neutralne_s_P4_Run1_tp1','neutralne_i_P4_Run1_tp1', 'neutralne_s_P4_Run2_tp1','neutralne_i_P4_Run2_tp1'};
        P.Contrasts(6).MinEvents=1;
        P.Contrasts(6).STAT='T';
        
        save(sprintf('E:/SPM_test/results_first/%s/GPPI/ses-1/vmPFC/GPPImatrix_vmpfc_%s', subject,subject), 'P');
 
 
        PPPI(P, [sprintf('E:/SPM_test/results_first/%s/GPPI/ses-1/vmPFC/GPPImatrix_vmpfc_%s.mat', subject,subject)]);
end




