
#Deduplication of leaking reads in scATAC-Seq
#this script is prepared by Ruslan Al-Ali
#2018-2019(c)

import fileinput
import sys
import os
import math
import numpy as np
import pandas as pd
import pysam
import time
from difflib import SequenceMatcher
from collections import Counter
import math
import statistics
from scipy import stats
import matplotlib.pyplot as plt


list_of_files= [f for f in os.listdir() if f.startswith('AS')]

small_list=list(list_of_files)


for j in list(list_of_files):
    start_time = time.time()

    file_name_work= "dedup_"+ j
    #Get reference
    pd_origin=pd.DataFrame()
    pd_temp=pd.read_csv(file_name_work,header=None)
    pd_origin=pd_temp.iloc[np.array(list(range(int(len(pd_temp)/4))))*4]
    pd_origin.index = list(range(len(pd_origin)))
    temp=pd_temp.iloc[np.array(list(range(int(len(pd_temp)/4))))*4+1]
    temp.index = list(range(len(pd_origin)))
    pd_origin=pd.concat([pd_origin, temp], axis=1, sort=False) 
    temp=pd_temp.iloc[np.array(list(range(int(len(pd_temp)/4))))*4+2]
    temp.index = list(range(len(pd_origin)))
    pd_origin=pd.concat([pd_origin, temp], axis=1, sort=False) 
    temp=pd_temp.iloc[np.array(list(range(int(len(pd_temp)/4))))*4+3]
    temp.index = list(range(len(pd_origin)))
    pd_origin=pd.concat([pd_origin, temp], axis=1, sort=False) 
    pd_origin.columns=["name","seq","direction","quality"]
    del pd_temp
    del temp
    sequences=pd_origin["seq"]
    temp=sequences.duplicated()
    pd_origin=pd_origin.drop(pd_origin[temp].index)
    print(file_name_work)

    #compare with all file
    for file_name in small_list:
        if (file_name_work!="dedup_"+file_name):
            #print(file_name)
            pd_origin1=pd.DataFrame()
            pd_temp=pd.read_csv("dedup_"+file_name,header=None)
            pd_origin1=pd_temp.iloc[np.array(list(range(int(len(pd_temp)/4))))*4]
            pd_origin1.index = list(range(len(pd_origin1)))
            temp=pd_temp.iloc[np.array(list(range(int(len(pd_temp)/4))))*4+1]
            temp.index = list(range(len(pd_origin1)))
            pd_origin1=pd.concat([pd_origin1, temp], axis=1, sort=False) 
            temp=pd_temp.iloc[np.array(list(range(int(len(pd_temp)/4))))*4+2]
            temp.index = list(range(len(pd_origin1)))
            pd_origin1=pd.concat([pd_origin1, temp], axis=1, sort=False) 
            temp=pd_temp.iloc[np.array(list(range(int(len(pd_temp)/4))))*4+3]
            temp.index = list(range(len(pd_origin1)))
            pd_origin1=pd.concat([pd_origin1, temp], axis=1, sort=False) 
            pd_origin1.columns=["name","seq","direction","quality"]
            del pd_temp
            del temp

            sequences=pd.concat([pd_origin1["seq"],pd_origin["seq"]],sort=False)
            temp=sequences.duplicated()[(len(pd_origin1)):]
            number=len(temp)-sum(temp)
            #print(temp)
            if (number>100):
                pd_origin=pd_origin.drop(pd_origin[temp].index)
            else:
                print(file_name_work +" Ended here:" + file_name)
                break
    print(sys.getsizeof(pd_origin)/1024)
    print(number)
    pd.set_option("display.max_colwidth", 1000)
    pd_origin.values.tofile("clean_"+file_name_work,sep="\n",format="%s")
    print(time.time()-start_time)


   
