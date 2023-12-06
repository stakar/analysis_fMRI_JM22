from os import listdir
import re
from bids_jm22_tools import setup_bids_dirs, move_file

PATH = 'source_data/'
DESTINATION = 'bids/'
if __name__ == '__main__':

    dirs = [n for n in listdir(PATH) if 'JM22' in n]
    
    
    for directory in dirs:
        try:
            code = re.search(r"B\d+",directory)[0]
        
            if len(code)>0:
                setup_bids_dirs(code,DESTINATION)
                print(f'Setup of bids for {code} is done!')
            
            
                for session,timepoint in zip([1,2],[1,5]):
                    for extension in ['nii','json']:
                        for modality,label,task,suffix in zip(
                                ['anat','func','func','FieldMapAP','FieldMapPA'],
                                ['T1w','run-01','run-02','fmap','fmap'],
                                ['','_imagery','_imagery','',''],
                                ['','_bold','_bold','_epi','_epi']
                                ):
                    
                            move_file(session,
                                      timepoint,
                                      extension,
                                      modality,
                                      label,
                                      task,
                                      suffix,
                                      code=code,
                                      old_path_prefix=PATH,
                                      new_path_prefix=DESTINATION)
                
        except Exception as e:
            print(e)
            print(f'Creation of BIDS failed for {directory}')