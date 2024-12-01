% Load danych z pliku .mat (zakładam, że wcześniej wczytałeś odpowiednie dane)
output_name = 'crit_sus_li_pre_1ttest';
path = 'E:\SPM_test\marsbar_extract\BOLD_1ttest_pre\CriticismSuspence_lis_imag_pre';
load([path '\' output_name '.mat']);

% Krok 1: Wyodrębnienie wyników z marsbara
region_data = SPM.marsY.Y;

% Krok 2: Dodanie nazw regionów jako nagłówków kolumn
num_regions = length(SPM.marsY.regions);
region_names = cell(1, num_regions);
for i = 1:num_regions
    % Poprawa nazw regionów, aby były zgodne z zasadami MATLABa
    region_names{i} = matlab.lang.makeValidName(SPM.marsY.regions{i}.name);
end

% Krok 3: Pobranie listy nazw plików i wyodrębnienie kodów osób badanych
file_names = {SPM.xY.VY.fname}; % List of filenames from SPM.xY.VY
subject_codes = get_subject_array(file_names);

% Krok 4: Przekształcenie wyników w tabelę
results_table = array2table(region_data, 'VariableNames', region_names);

% Dodanie kolumny z kodami osób badanych
results_table.Codes = subject_codes';

% Krok 5: Zapisanie wyników do pliku CSV
output_filename = [output_name '.csv'];
writetable(results_table, output_filename);

disp(['Wyniki zostały zapisane do pliku: ', output_filename]);
