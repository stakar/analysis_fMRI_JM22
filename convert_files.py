import subprocess
from os import listdir, rename
import re
import bids_jm22_tools

if __name__ == '__main__':
    zipped = [n for n in listdir() if 'zip' in n]
    for n in zipped:
        print(n)
        subprocess.call(["unzip",f"{n}"])
    #Renaming files
    try:
        dirs = [n for n in listdir() if 'JM22' in n]
        for directory in dirs:
            to_rename = listdir(f"{directory}")
            timepoint = re.search(r"TP\d",directory)[0]
            rename(f"{directory}/{to_rename[0]}",f"{directory}/{timepoint}")
            subprocess.call(["dcm2niix",f"{directory}/{to_rename[0]}",f"{directory}/{timepoint}"])
    except Exception as e:
        print(e)
        
    code = re.search(r"B\d+",dirs[0])[0]

    setup_bids_dirs(code)


    for session,timepoint in zip([1,2],[1,5]):
        move_file(session,timepoint,'json','anat','T1w')
        move_file(session,timepoint,'nii','anat','T1w')
        move_file(session,timepoint,'json','func','run-01','_imagery','_bold')
        move_file(session,timepoint,'nii','func','run-01','_imagery','_bold')
        move_file(session,timepoint,'json','func','run-02','_imagery','_bold')
        move_file(session,timepoint,'nii','func','run-02','_imagery','_bold')

        move_file(session,timepoint,'json','anat','T1w')
        move_file(session,timepoint,'nii','anat','T1w')

        move_file(session,timepoint,'json','func','run-01','_imagery','_bold')
        move_file(session,timepoint,'nii','func','run-01','_imagery','_bold')
        move_file(session,timepoint,'json','func','run-02','_imagery','_bold')
        move_file(session,timepoint,'nii','func','run-02','_imagery','_bold')

        move_file(session,timepoint,'nii','FieldMapPA')
        move_file(session,timepoint,'json','FieldMapPA')

        move_file(session,timepoint,'nii','FieldMapAP')
        move_file(session,timepoint,'json','FieldMapAP')