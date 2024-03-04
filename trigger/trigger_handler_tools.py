#import packages
import pandas as pd
import numpy as np
import os
from functools import reduce
import re

#pandas version: 1.1.5
#numpy version: 1.24.4
#python version: 3.8.8

def find_subject(subject_code='A001',path='LOG/'):
    """
    Read path, then search in given path person with
    given subject code'
    """
    files = [file for file in os.listdir('LOG/') if 'log' in file]
    return [file for file in files if subject_code in file]

def read_file(filename):
    """
    Read file, check whether it contains proper
    columns (based on first one) and return 
    DataFrame.
    """
    #read file, skiping rows with metadata
    file = pd.read_csv(filename,"\t",skiprows=2)
    #check columns (whether first one is subject)
    if np.any(file.columns.str.contains('Subject')):
        #delete Response (irrelevant for this study, but 
        #ther are some troubles with it)
        file = file.loc[file['Event Type'] != 'Response']
        #if columns are proper, restart index and return
        return file.reset_index()
    else:
        #if columns are not proper, read with skipping
        #different n of rows
        file = pd.read_csv(filename,"\t",skiprows=3)
        #drop unnecessary rows
        file = file.dropna(subset = ['Subject'])
        #delete Response (irrelevant for this study, but 
        #ther are some troubles with it)
        file = file.loc[file['Event Type'] != 'Response']
        #if columns are proper, restart index and return
        return file.reset_index()
    
def get_arg_block(data,blockname='block'):
    """Get arg of blocks in data"""
    return (data
            .loc[(data['Code']
                  .str.lower()
                  .str.contains(blockname.lower())),:]
            .index)

def time_correction(data):
    """
    Corrects time in data from Presentation. 
    Reduce all Time column by time value of first event, 
    then divides by 10000 (to turn into ms).
    Returns whole DataFrame.
    """
    data['Time'] = (data['Time'] - data['Time'].iloc[0])/10000
    return data

def create_file(filename):
    """
    Creates file with given filename
    """
    df = read_file(filename)
    df = time_correction(df)
    args = get_arg_block(df,r'S*P')
    df = df.loc[args]

    result = pd.DataFrame(columns=['Code','Onset','Offset'])
    for ind in range(len(df)):
        part = df.iloc[ind][['Code','Time']]
        try:
            if 'inter' in part['Code']:
                offset = part['Time'] + 15
                duration = 15
            else:
                offset = df.iloc[ind+1]['Time']
                duration = 13
        except:
            pass

        result = result.append({'Code':part['Code'],
                      'Onset':part['Time'],
                      'Offset':offset,
                      'Duration':duration},ignore_index=True)
    return result


def create_file_end_recording(filename):
    """
    Creates file with given filename; 
    it is alternative way, in which 
    """
    df = read_file(filename)
    df = time_correction(df)
    args = get_arg_block(df,r'S*P')
    df = df.loc[args]

    result = pd.DataFrame(columns=['Code','Onset','Offset'])
    for ind in range(len(df)):
        part = df.iloc[ind][['Code','Time']]
        try:
            if 'end' in part['Code']:
                offset = part['Time'] + 15
                duration = 15
            else:
                offset = df.iloc[ind+1]['Time']
                duration = 13
        except:
            pass

        result = result.append({'Code':part['Code'],
                      'Onset':part['Time'],
                      'Offset':offset,
                      'Duration':duration},ignore_index=True)
    return result

def generate_timing_conditions(data,prefix,path=''):
    """
    Generates files (for excel, csv & tsv) with prepared
    events and timings contained in data. Prefix should contain 
    subjects'code, which will be included in name of the file.
    """
    for condition,name in zip(['S','SN'],['krytyka','neutralne']):
        for modality_sign,modality in zip(['$'],['s']):
            for part in ['123','4']:
                (data.loc[data['Code']
                      .str
                      .contains(fr'{condition}\d_P[{part}]{modality_sign}'),]
                 .to_excel(f'{path}{prefix}_{name}_{modality}_P{part}.xlsx'))
                (data.loc[data['Code']
                      .str
                      .contains(fr'{condition}\d_P[{part}]{modality_sign}'),]
                 .to_csv(f'{path}{prefix}_{name}_{modality}_P{part}.csv',';'))
                (data.loc[data['Code']
                      .str
                      .contains(fr'{condition}\d_P[{part}]{modality_sign}'),]
                 .to_csv(f'{path}{prefix}_{name}_{modality}_P{part}.tsv',';'))
              
def FSL_fix(data):
    """
    Return data, with columns adjusted for analysis in FSL (with columns onset/duration/
    weight/trial_type).
    """
    data['weight'] = np.ones(len(data))
    data.columns = ['index','trial_type','onset','offset','duration','weight']
    data['onset'] = np.round(data['onset'])
    return data.loc[:,['onset','duration','weight','trial_type']]

def generate_timing_conditions_FSL(data,prefix):
    """
    Generate timing of conditions, which is adjusted to FSL (with columns onset/duration/
    weight/trial_type). 
    """
    data = FSL_fix(data)
    for condition,name in zip(['S','SN'],
                              ['krytyka','neutralne']):
        for modality_sign,modality in zip(['$','inter'],
                                          ['s','i']):
            for part in ['1','2','3','123','4']:
                (data.loc[data['trial_type']
                      .str
                      .contains(fr'{condition}\d_P[{part}]{modality_sign}'),
                          ['onset','duration','weight']]
                 .to_csv(f'{prefix}_{name}_{modality}_P{part}.tsv',
                         '\t',
                         index=False,
                         header=False))
    if any(data['trial_type'].str.contains(fr'S\d_P\d_T')):
        for modality_sign,modality in zip(['$','inter'],
                                          ['s','i']):
            for part in ['1','2','3','123','4','5','6','7','4567']:
                (data.loc[data['trial_type']
                      .str
                      .contains(fr'S\d_P[{part}]_T{modality_sign}'),
                          ['onset','duration','weight']]
                 .to_csv(f'{prefix}_therapy_{modality}_P{part}_therapy.tsv',
                         '\t',
                         index=False,
                         header=False))
    elif any(data['trial_type'].str.contains(fr'SN\d_P\d_K')):
        for modality_sign,modality in zip(['$','inter'],
                                          ['s','i']):
            for part in ['1','2','3','123','4','5','6','7','4567']:
                (data.loc[data['trial_type']
                      .str
                      .contains(fr'SN\d_P[{part}]_K{modality_sign}'),['onset','duration','weight']]
                 .to_csv(f'{prefix}_therapy_{modality}_P{part}.tsv',
                         '\t',
                         index=False,
                         header=False))
                

def generate_timing_conditions_SPM(data,prefix):
    """
    Generate timing of conditions, which is adjusted to SPM (with columns names/onsets/durations),
    and saved in matlab format. 
    """
    data = FSL_fix(data)
    result = {'names':[],
              'onsets':[],
              'durations':[]}
    for condition,name in zip(['S','SN'],
                              ['krytyka','neutralne']):
        for modality_sign,modality in zip(['$','inter'],
                                          ['s','i']):
            for part in ['1','2','3','4']:
                result['names'].append(fr"{name}_{modality}_P{part}")
                result['onsets'].append((data.loc[data['trial_type']
                                                  .str
                                                  .contains(fr'{condition}\d_P[{part}]{modality_sign}'),
                                                  ['onset']])
                                        .values)
                result['durations'].append((data.loc[data['trial_type']
                      .str
                      .contains(fr'{condition}\d_P[{part}]{modality_sign}'),['duration']]).values)

    if any(data['trial_type'].str.contains(fr'S\d_P\d_T')):
        for modality_sign,modality in zip(['$','inter'],
                                          ['s','i']):
            for part in ['1','2','3']:
                result['names'].append(f'krytyka_{modality}_P{part}')
                result['onsets'].append((data.loc[data['trial_type']
                      .str
                      .contains(fr'S\d_P[{part}]_T{modality_sign}'),['onset']]).values)
                result['durations'].append((data.loc[data['trial_type']
                      .str
                      .contains(fr'S\d_P[{part}]_T{modality_sign}'),['duration']]).values)
            for part in ['4','5','6','7']:
                result['names'].append(f'therapy_{modality}_P{part}')
                result['onsets'].append((data.loc[data['trial_type']
                      .str
                      .contains(fr'S\d_P[{part}]_T{modality_sign}'),['onset']]).values)
                result['durations'].append((data.loc[data['trial_type']
                      .str
                      .contains(fr'S\d_P[{part}]_T{modality_sign}'),['duration']]).values)

    elif any(data['trial_type'].str.contains(fr'SN\d_P\d_K')):
        for modality_sign,modality in zip(['$','inter'],
                                          ['s','i']):
            for part in ['1','2','3']:
                result['names'].append(f'neutralne_{modality}_P{part}')
                result['onsets'].append((data.loc[data['trial_type']
                      .str
                      .contains(fr'SN\d_P[{part}]_K{modality_sign}'),['onset']]).values)
                result['durations'].append((data.loc[data['trial_type']
                      .str
                      .contains(fr'SN\d_P[{part}]_K{modality_sign}'),['duration']]).values)
            for part in ['4','5','6','7']:
                result['names'].append(f'therapy_{modality}_P{part}')
                result['onsets'].append((data.loc[data['trial_type']
                      .str
                      .contains(fr'SN\d_P[{part}]_K{modality_sign}'),['onset']]).values)
                result['durations'].append((data.loc[data['trial_type']
                      .str
                      .contains(fr'SN\d_P[{part}]_K{modality_sign}'),['duration']]).values)
    tmp=np.zeros(len(result['names']),
                 dtype=object)
    tmp[:]=result['names']
    result['names']  = tmp
    savemat(f'{prefix}.mat',result)
    return result
