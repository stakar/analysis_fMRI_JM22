# analysis_fMRI_JM22

## TODO

-- Scripts for 1stLVL, 2ndLvl

## Requirements
Python3, dcm2nifti, dcm2bids, xnatutils (files/BIDS formatting) 
Matlab, SPM12 (1stLvl/2ndLvl analysis)
Pandas (trigger handling)

## Usage BIDS

### 1. Firstly, setup the BIDS folder with:

dcm2bids_scaffold -o bids_folder/

### 2. Then, you can download data using the command:

xnat-get xml_filew_with_subjects -t ./sourcedata/ -k -d

### 3. Put run_bids.py and JM22a_config in the code/ directory in the BIDS folder. Then, from bids_folder run bids analysis, fixing bids, and fmriprep:

python ./code/run_bids.py

python ./code/fix_fmap_jsons.py

python ./code/run_fmriprep.py

### 4. Check fmriprep output

## Usage fMRI analysis

### Run extract confounders, smoothing from preproc directory

It is necessary for obtaining confounders, which will be used as regressors in the 1stLvl analysis. Smoothing is an additional step done before analysis.

## Usage trigger handling

### Use functions or just run notebook from the trigger directory.

Triggers are used in analysis to detect which condition was presented at what time. 

## Notes
When you run fix_fmap_jsons, some files may raise problems - then it is worth checking and exploring whether everything is fine with the files. If something is wrong with bids, and you need to fix one file - modify run_bids (check comments)
