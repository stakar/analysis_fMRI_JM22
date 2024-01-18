# analysis_fMRI_JM22

## Requirements
Python3, dcm2nifti, dcm2bids, xnatutils

## Usage
### 1. Firstly, setup BIDS folder with:

dcm2bids_scaffold -o bids_folder/

### 2. Then, you can download data using command:

xnat-get xml_filew_with_subjects -t ./sourcedata/ -k -d

### 3. Put run_bids.py and JM22a_config in code/ directory in BIDS folder. Then, from bids_folder run bids analysis, fixing bids and fmriprep:

python ./code/run_bids.py

python ./code/fix_fmap_jsons.py

python ./code/run_fmriprep.py
