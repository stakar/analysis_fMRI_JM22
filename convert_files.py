import subprocess
from os import listdir, rename
from shutil import move
import re

if __name__ == '__main__':
    zipped = [n for n in listdir() if 'zip' in n]
    for n in zipped:
        print(n)
        subprocess.call(["unzip",f"{n}"])
    #Renaming files
    try:
        dirs = [n for n in listdir() if 'JM22' in n]
        
        for directory in dirs:
            move(directory,'source_data/')
            to_rename = listdir(f"source_data/{directory}")
            timepoint = re.search(r"TP\d",f"source_data/{directory}")[0]
            rename(f"source_data/{directory}/{to_rename[0]}",
                   f"source_data/{directory}/{directory}")
            subprocess.call(["dcm2niix",
                             f"source_data/{directory}/{directory}",
                             f"source_data/{directory}/{directory}"])
    except Exception as e:
        print(e)

    print('Conversion dcm to nifti is done.')   