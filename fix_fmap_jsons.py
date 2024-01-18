#Script for fixing error in fmap jsons,
#dcm2bids is adding prefix ("bids::sub-nnn") in IntendedFor
#which makes those sjons unusable for fmriprep.
#This script is fixing that.
import json
from os import listdir
PATH = './' 
#find all subjects directory
DIRECTORIES = [n for n in listdir(PATH) if 'sub' in n]
# make fix for every file
for directory in DIRECTORIES:
    for n in [1,2]:
        for mode in ['AP','PA']:
            try:
                #create name of file
                file = f'{PATH}{directory}/ses-{n}/fmap/{directory}'\
                f'_ses-{n}_dir-{mode}_epi.json' 
                with open(file) as f:
                    data = json.load(f)
                #fix is getting rid of "bids::sub-nnn" from IntendedFor
                to_strip = f'bids::{directory}/'
                data['IntendedFor'] = [n.strip(to_strip)\
                                       for n in data['IntendedFor']]
                with open(file,'w') as f:
                    json.dump(data,f,indent=4)
            except Exception as e:
                #Some Error handling, just in case.
                print(f'{e}\nProblem with file {directory}')