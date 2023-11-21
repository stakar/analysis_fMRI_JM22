
def setup_bids_dirs(code,path=''):
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
    result = []
    for root, dirs, files in walk(path):
        for name in files:
            if fnmatch.fnmatch(name, pattern):
                result.append(ospjoin(root, name))
    return result

#Next is function for moving files to created BIDS template. FieldMaps were created using 
#directions below.
#https://neurostars.org/t/getting-fieldmaps-or-other-multi-echo-data-into-bids-format/1854/4

def move_file(sess = 2, timepoint = 5,extension='json',modality='anat',label='T1w',
              task="",suffix='',old_path_prefix='',new_path_prefix={}): 
    try:
        if modality=='anat':
            filename = find(f'tp{timepoint}*{modality}*.{extension}','.\\')[0]
        elif modality=='func':
            filename = find(f'tp{timepoint}*{label}*.{extension}','.\\')[0]
        elif modality=='FieldMapPA':
            filename = find(f'tp{timepoint}*{label}*.{extension}','.\\')[0]
        elif modality=='FieldMapAP':
            filename = find(f'tp{timepoint}*{label}*.{extension}','.\\')[0]

        path_old, filename = (old_path_prefix = '\\'.join(filename.split('\\')[:-1]),
                          filename.split('\\')[-1])

        path_new = f"{new_path_prefix}sub-{code}/sess-{sess}//{modality}/"
       
        if modality=='FieldMapPA':
            path_new = f"sub-{code}\\sess-{sess}\\fmap\\"
            copyfile(f"{path_old}\\{filename}",
               f"{path_new}\\sub-{code}_sess-{sess}_dir-pa_{label}_epi.{extension}")
        elif modality=='FieldMapAP':
            path_new = f"sub-{code}\\sess-{sess}\\fmap\\"
            copyfile(f"{path_old}\\{filename}",
               f"{path_new}\\sub-{code}_sess-{sess}_dir-ap_{label}_epi.{extension}")
        else:
            copyfile(f"{path_old}\\{filename}",
               f"{path_new}\\sub-{code}_sess-{sess}{task}_{label}{suffix}.{extension}")
    except Exception as e:
        print(e)