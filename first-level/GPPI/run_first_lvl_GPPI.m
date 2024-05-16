
%Stanislaw tutaj wez ogarnij listę osób i w fileloopie wrzuc id osoby aby 
%id bylo brane z listy
workdir = pwd;
basedir = fullfile(pwd, '../code/'); % git repo location
datadir = fullfile(pwd, '../results/'); % fmriprep dataset location
resdir = fullfile(pwd, '../results_2ndLvl/ttestInd/'); % output location
D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);
subjects = {D.name};

% for fileloop=1:numel(subjects)%pętla, która wykona analizę gPPI na %rosnącym id osób badanych
%     subject = subjects{fileloop};
%     try %funkcja 'try' umożliwi wykonywanie kodu nawet %jeżeli w analizie brakuje nam ciągłości osób badanych -tj. %jeśli wśród 60 osób badanych brakuje nam osoby o id np. %10
%         files = sprintf(subject); %jako %subject należy wpisać pierwszy człon id naszych osób %badanych (nazwy folderów zawierających obrazy .nii i %modele)
%         name1='E:/SPM_test/code/masks/VOI_VOI_vmpfc.mat'; %ścieżka do maski będącej %seedem
%         VOIr=name1;
%         direc= sprintf('E:/SPM_test/results_ppi/%s/stories-model/ses-1/',subject) ;  %ścieżka do %modelu 1st level będącego podstawą analizy gPPI
%         P.subject=files;
%         P.directory=[direc];
%         P.VOI=[VOIr];
%         P.Region='';  %nazwa obszaru seed %- stanie się również nazwą podfolderu z analizą gPPI
%         P.analysis='psy'; %deklaracja, że wykonujemy %'physiophysiological interaction'
%         P.method='cond'; %jeżeli interesuje nas gPPI to %zostawiamy tak jak jest tutaj. Jeśli chcemy policzyć %klasycznego PPI, to zmieniamy wartość na 'trad'
%         P.Estimate=1;
%         P.contrast=0; %kontrast do którego zostanie dostosowana analiza. Omnibus %F-test jest domyślny i zostanie utworzony automatycznie. 
%         P.extract='eig';
%         
% %         P.Tasks= {'krytyka_s_P1' 'krytyka_s_P2' 'krytyka_s_P3' 'krytyka_s_P4' 'krytyka_i_P1' 'krytyka_i_P2' 'krytyka_i_P3'  'krytyka_i_P4' 'neutralne_s_P1' 'neutralne_s_P2' 'neutralne_s_P3' 'neutralne_s_P4' 'neutralne_i_P1' 'neutralne_i_P2' 'neutralne_i_P3' 'neutralne_i_P4' 'therapy_s_P4' 'therapy_s_P5' 'therapy_s_P6' 'therapy_s_P7' 'neutralne_i_P1' 'neutralne_i_P2' 'neutralne_i_P3' 'therapy_i_P4' 'therapy_i_P5' 'therapy_i_P6' 'therapy_i_P7' }; %należy wpisać WSZYSTKIE warunki z modelu %1st level
%         P.Tasks= {'0','krytyka_s_P1_Run1','krytyka_s_P2_Run1','krytyka_s_P3_Run1','krytyka_s_P4_Run1',...
%             'krytyka_i_P1_Run1','krytyka_i_P2_Run1','krytyka_i_P3_Run1','krytyka_i_P4_Run1','neutralne_s_P1_Run1',...
%             'neutralne_s_P2_Run1','neutralne_s_P3_Run1','neutralne_s_P4_Run1','neutralne_i_P1_Run1','neutralne_i_P2_Run1',...
%             'neutralne_i_P3_Run1','neutralne_i_P4_Run1','krytyka_s_P1_Run2','krytyka_s_P2_Run2','krytyka_s_P3_Run2',...
%             'krytyka_s_P4_Run2','krytyka_i_P1_Run2','krytyka_i_P2_Run2','krytyka_i_P3_Run2','krytyka_i_P4_Run2',...
%             'neutralne_s_P1_Run2','neutralne_s_P2_Run2','neutralne_s_P3_Run2','neutralne_s_P4_Run2','neutralne_i_P1_Run2',...
%             'neutralne_i_P2_Run2','neutralne_i_P3_Run2','neutralne_i_P4_Run2','therapy_s_P4_Run2','therapy_s_P5_Run2','therapy_s_P6_Run2','therapy_s_P7_Run2',...
%             'therapy_i_P4_Run2','therapy_i_P5_Run2','therapy_i_P6_Run2','therapy_i_P7_Run2'};
%         P.Weights=[];
%         P.equalroi=0; % 1 oznacza, że wszystkie seedy %muszą być jednakowej wielkości u wszystkich osób. Ta %zasada może być problematyczna jeśli nasz seed znajduje %się blisko krańców mózgu (lub w obszarach podatnych na %zniekształcenia pola podczas skanowania)
%         P.FLmask=1; % 0 oznacza, że maska seeda nie będzie %ograniczona przez maskę aktywności z 1st levelu. W %przypadku błędu przy tych ustawieniach można zmienić %P.equalroi=0 i P.FLmask=1
%         P.CompContrasts=1;
%         direco= fullfile(sprintf('../PPI/ses-1/%s/', subject)); %ścieżka do zapisania modelu gPPI
%         P.outdir=direco;
%         %Poniżej należy wypisać interesujące nas kontrasy. %W przypadku
%         %t-testu porównanie jest wykonywane w następujący %sposób :left>right
%         %UWAGA! Należy na tym etapie zdefiniować wszystkie %interesujące nas
%         %porównania. Po obliczeniu modelu nie ma %możliwości dodania nowych
%         %kontrastów - będzie to wymagało ponownego %obliczenia modelu z
%         %dodatkowymi kontrastami.
%         P.Contrasts(1).name='Criticism_PPI_suspence';
%         P.Contrasts(1).left={'krytyka_s_P1_Run1','krytyka_s_P2_Run1','krytyka_s_P3_Run1','krytyka_i_P1_Run1',...
%             'krytyka_i_P2_Run1','krytyka_i_P3_Run1','krytyka_s_P1_Run2','krytyka_s_P2_Run2','krytyka_s_P3_Run2',...
%             'krytyka_i_P1_Run2','krytyka_i_P2_Run2','krytyka_i_P3_Run2'};
%         P.Contrasts(1).right={ 'none' };
%         P.Contrasts(1).MinEvents=1;
%         P.Contrasts(1).STAT='T';
%         
%         P.Contrasts(2).name='Criticism_all_PPI_hotspot';
%         P.Contrasts(2).left={'krytyka_s_P4_Run1','krytyka_i_P4_Run1', 'krytyka_s_P4_Run2','krytyka_i_P4_Run2'};
%         P.Contrasts(2).right={ 'none' };
%         P.Contrasts(2).MinEvents=1;
%         P.Contrasts(2).STAT='T';
%         
%         P.Contrasts(3).name='CriticismNeutral_PPI_hotspot';
%         P.Contrasts(3).left={'krytyka_s_P4_Run1','krytyka_i_P4_Run1', 'krytyka_s_P4_Run2','krytyka_i_P4_Run2'};
%         P.Contrasts(3).right={'neutralne_s_P4_Run1','neutralne_i_P4_Run1', 'neutralne_s_P4_Run2','neutralne_i_P4_Run2'};
%         P.Contrasts(3).MinEvents=1;
%         P.Contrasts(3).STAT='T';
%         save('GPPImatrix', 'P');
%  
%  
%         PPPI(P, ['E:\SPM_test\code\GPPImatrix.mat']);
% end
% end
% 

for fileloop=1:numel(subjects)%pętla, która wykona analizę gPPI na %rosnącym id osób badanych
    subject = subjects{fileloop};
    try %funkcja 'try' umożliwi wykonywanie kodu nawet %jeżeli w analizie brakuje nam ciągłości osób badanych -tj. %jeśli wśród 60 osób badanych brakuje nam osoby o id np. %10
        files = sprintf(subject); %jako %subject należy wpisać pierwszy człon id naszych osób %badanych (nazwy folderów zawierających obrazy .nii i %modele)
        name1='E:/SPM_test/code/masks/VOI_VOI_vmpfc.mat'; %ścieżka do maski będącej %seedem
        VOIr=name1;
        direc= sprintf('E:/SPM_test/results_ppi/%s/ses-2/',subject) ;  %ścieżka do %modelu 1st level będącego podstawą analizy gPPI
        P.subject=files;
        P.directory=[direc];
        P.VOI=[VOIr];
        P.Region='';  %nazwa obszaru seed %- stanie się również nazwą podfolderu z analizą gPPI
        P.analysis='psy'; %deklaracja, że wykonujemy %'physiophysiological interaction'
        P.method='cond'; %jeżeli interesuje nas gPPI to %zostawiamy tak jak jest tutaj. Jeśli chcemy policzyć %klasycznego PPI, to zmieniamy wartość na 'trad'
        P.Estimate=1;
        P.contrast=0; %kontrast do którego zostanie dostosowana analiza. Omnibus %F-test jest domyślny i zostanie utworzony automatycznie. 
        P.extract='eig';
        
%         P.Tasks= {'krytyka_s_P1' 'krytyka_s_P2' 'krytyka_s_P3' 'krytyka_s_P4' 'krytyka_i_P1' 'krytyka_i_P2' 'krytyka_i_P3'  'krytyka_i_P4' 'neutralne_s_P1' 'neutralne_s_P2' 'neutralne_s_P3' 'neutralne_s_P4' 'neutralne_i_P1' 'neutralne_i_P2' 'neutralne_i_P3' 'neutralne_i_P4' 'therapy_s_P4' 'therapy_s_P5' 'therapy_s_P6' 'therapy_s_P7' 'neutralne_i_P1' 'neutralne_i_P2' 'neutralne_i_P3' 'therapy_i_P4' 'therapy_i_P5' 'therapy_i_P6' 'therapy_i_P7' }; %należy wpisać WSZYSTKIE warunki z modelu %1st level
        P.Tasks= {'0','krytyka_s_P1_Run1','krytyka_s_P2_Run1','krytyka_s_P3_Run1','krytyka_s_P4_Run1',...
            'krytyka_i_P1_Run1','krytyka_i_P2_Run1','krytyka_i_P3_Run1','krytyka_i_P4_Run1','neutralne_s_P1_Run1',...
            'neutralne_s_P2_Run1','neutralne_s_P3_Run1','neutralne_s_P4_Run1','neutralne_i_P1_Run1','neutralne_i_P2_Run1',...
            'neutralne_i_P3_Run1','neutralne_i_P4_Run1','krytyka_s_P1_Run2','krytyka_s_P2_Run2','krytyka_s_P3_Run2',...
            'krytyka_s_P4_Run2','krytyka_i_P1_Run2','krytyka_i_P2_Run2','krytyka_i_P3_Run2','krytyka_i_P4_Run2',...
            'neutralne_s_P1_Run2','neutralne_s_P2_Run2','neutralne_s_P3_Run2','neutralne_s_P4_Run2','neutralne_i_P1_Run2',...
            'neutralne_i_P2_Run2','neutralne_i_P3_Run2','neutralne_i_P4_Run2','therapy_s_P4_Run2','therapy_s_P5_Run2','therapy_s_P6_Run2','therapy_s_P7_Run2',...
            'therapy_i_P4_Run2','therapy_i_P5_Run2','therapy_i_P6_Run2','therapy_i_P7_Run2'};
        P.Weights=[];
        P.equalroi=0; % 1 oznacza, że wszystkie seedy %muszą być jednakowej wielkości u wszystkich osób. Ta %zasada może być problematyczna jeśli nasz seed znajduje %się blisko krańców mózgu (lub w obszarach podatnych na %zniekształcenia pola podczas skanowania)
        P.FLmask=1; % 0 oznacza, że maska seeda nie będzie %ograniczona przez maskę aktywności z 1st levelu. W %przypadku błędu przy tych ustawieniach można zmienić %P.equalroi=0 i P.FLmask=1
        P.CompContrasts=1;
        direco= fullfile(sprintf('../PPI/ses-2/%s/', subject)); %ścieżka do zapisania modelu gPPI
        P.outdir=direco;
        %Poniżej należy wypisać interesujące nas kontrasy. %W przypadku
        %t-testu porównanie jest wykonywane w następujący %sposób :left>right
        %UWAGA! Należy na tym etapie zdefiniować wszystkie %interesujące nas
        %porównania. Po obliczeniu modelu nie ma %możliwości dodania nowych
        %kontrastów - będzie to wymagało ponownego %obliczenia modelu z
        %dodatkowymi kontrastami.
        P.Contrasts(1).name='Criticism_PPI_suspence';
        P.Contrasts(1).left={'krytyka_s_P1_Run1','krytyka_s_P2_Run1','krytyka_s_P3_Run1','krytyka_i_P1_Run1',...
            'krytyka_i_P2_Run1','krytyka_i_P3_Run1','krytyka_s_P1_Run2','krytyka_s_P2_Run2','krytyka_s_P3_Run2',...
            'krytyka_i_P1_Run2','krytyka_i_P2_Run2','krytyka_i_P6_Run2'};
        P.Contrasts(1).right={ 'none' };
        P.Contrasts(1).MinEvents=1;
        P.Contrasts(1).STAT='T';
        
        P.Contrasts(2).name='Criticism_all_PPI_hotspot';
        P.Contrasts(2).left={'krytyka_s_P4_Run1','krytyka_i_P4_Run1', 'krytyka_s_P4_Run2','krytyka_i_P4_Run2'};
        P.Contrasts(2).right={ 'none' };
        P.Contrasts(2).MinEvents=1;
        P.Contrasts(2).STAT='T';
        
        P.Contrasts(3).name='CriticismNeutral_PPI_hotspot';
        P.Contrasts(3).left={'krytyka_s_P4_Run1','krytyka_i_P4_Run1', 'krytyka_s_P4_Run2','krytyka_i_P4_Run2'};
        P.Contrasts(3).right={'neutralne_s_P4_Run1','neutralne_i_P4_Run1', 'neutralne_s_P4_Run2','neutralne_i_P4_Run2'};
        P.Contrasts(3).MinEvents=1;
        P.Contrasts(3).STAT='T';
        save('GPPImatrix', 'P');
 
 
        PPPI(P, ['E:\SPM_test\code\GPPImatrix.mat']);
end
end
