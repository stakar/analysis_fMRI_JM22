# -*- coding: utf-8 -*-
"""
Created on Tue Jan  2 15:19:09 2024

@author: skarkosz

"""
from os import listdir
import subprocess
import re
#Set up global variables
PATH = 'sourcedata/'

if __name__ == '__main__':
    #search for directories with data from study
    dirs = [n for n in listdir(PATH) if 'JM' in n]
    #if any of the bids needs fixing after running whole command,
    #you may want to change "JM" into subject code (eg. B999), 
    #to run command only for concrete subject. 
    print(dirs)
    #for each directory, find subject's code (exception handling
    #for files where is no subject code or time point), 
    #each subject code is B + 3 digits
    #each time point is either 1 or 5
    #then run dcm2bids command
    for directory in dirs: 
        try: 
            subject = re.search(r"B\d+",directory)[0]
            timepoint = re.search(r"TP\d",directory)[0][-1]
            timepoint = {'1':'1','5':'2'}[timepoint] #change 5 to 2
            subprocess.call(["dcm2bids", 
                             "-d", 
                             f"{PATH}/{directory}", 
                             "-p",
                             subject, 
                             "-s",
                             timepoint, 
                             "-c",
                             "code/jm22a_config.json",
                             "--auto_extract_entities"])
        except Exception as e:
            print(e)
            print(f"Problem with {directory}")