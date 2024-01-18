# -*- coding: utf-8 -*-
"""
Created on Thu Jan 18 13:24:42 2024

@author: skarkosz
"""

from os import listdir
import subprocess
import re

N_THREADS = "4"
WORKSPACE = "../fmriprep_workspace/"
FS_LICENSE = "derivatives/license.txt"
PATH = "./"
DESTINATION = "derivatives/"
if __name__ == '__main__':
    #search for directories with data from study
    #search for directories with data from study
    subject_list = [n for n in listdir(PATH) if 'sub-' in n][5:10]
    print(subject_list)
    for subject in subject_list: 
        try: 
            subprocess.call(["fmriprep-docker",
                             PATH,
                             DESTINATION,
                             "--participant-label",
                             subject,
                             "--skip-bids-validation",
                             "--md-only-boilerplate",
                             "--fs-license-file",
                             FS_LICENSE,
                             "--longitudinal",
                             "--fs-no-reconall",
                             "--nthreads",
                             N_THREADS,
                             "--stop-on-first-crash",
                             "-w",
                             WORKSPACE
                             ])
        except Exception as e:
            print(f"{e}\nProblem with {subject}")