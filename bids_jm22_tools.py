from os import listdir, makedirs,rename,walk
from shutil import copyfile
from os.path import join as ospjoin
import fnmatch
import subprocess
import re

def setup_bids_dirs(code,path=''):
    """
    Fuction that setups BIDS directories for two sessions, anat, func and fmap
    for each one.
    """
    if f"sub-{code}" not in listdir(f"{path}"):
        makedirs(f"{path}sub-{code}")
        makedirs(f"{path}sub-{code}/sess-1")
        makedirs(f"{path}sub-{code}/sess-1/anat")
        makedirs(f"{path}sub-{code}/sess-1/fmap")
        makedirs(f"{path}sub-{code}/sess-1/func")
        makedirs(f"{path}sub-{code}/sess-2")
        makedirs(f"{path}sub-{code}/sess-2/anat")
        makedirs(f"{path}sub-{code}/sess-2/fmap")
        makedirs(f"{path}sub-{code}/sess-2/func")
        

def find(pattern, path):
    """Simple function for finding file in a given path based on pattern"""
    result = []
    for root, dirs, files in walk(path):
        for name in files:
            if fnmatch.fnmatch(name, pattern):
                result.append(ospjoin(root, name))
    return result

#Next is function for moving files to created BIDS template. FieldMaps were 
#created using 
#directions below.
#https://neurostars.org/t/getting-fieldmaps-or-other-multi-echo-data-into-bids-
#format/1854/4


        
def move_file(sess = 2, 
              timepoint = 5,
              extension='json',
              modality='anat',
              label='T1w',
              task="",
              suffix='',
              code='B000',
              old_path_prefix='./',
              new_path_prefix=''): 
    """Function for moving file to BIDS directory, renaming according to 
    BIDS system."""
    try:
        if modality=='anat':
            filename = find(f'*{code}*{timepoint}*{modality}*.{extension}',
                            old_path_prefix)[0]
        elif modality=='func':
            filename = find(f'*{code}*{timepoint}*{label}*.{extension}',
                            old_path_prefix)[0]
        elif modality=='FieldMapPA':
            filename = find(f'*{code}*{timepoint}*{modality}*.{extension}',
                            old_path_prefix)[0]
        elif modality=='FieldMapAP':
            filename = find(f'*{code}*{timepoint}*{modality}*.{extension}',
                            old_path_prefix)[0]
    
        path_old,filename=('/'.join(filename.split('/')[:-1]),
                          filename.split('/')[-1])
    
    
        path_new = f"{new_path_prefix}sub-{code}/sess-{sess}/{modality}"
       
        if modality=='FieldMapPA':
            path_new = f"{new_path_prefix}sub-{code}/sess-{sess}/fmap"
            copyfile(f"{path_old}/{filename}",
               f"{path_new}/sub-{code}_sess-{sess}_dir-pa_{label}_epi.{extension}")
        elif modality=='FieldMapAP':
            path_new = f"{new_path_prefix}sub-{code}/sess-{sess}/fmap"
            copyfile(f"{path_old}/{filename}",
               f"{path_new}/sub-{code}_sess-{sess}_dir-ap_{label}_epi.{extension}")
        else:
            copyfile(f"{path_old}/{filename}",
               f"{path_new}/sub-{code}_sess-{sess}{task}_{label}{suffix}.{extension}")
    except Exception as e:
        print(e)

