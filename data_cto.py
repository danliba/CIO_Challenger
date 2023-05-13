# -*- coding: utf-8 -*-
"""
Created on Thu Mar 18 22:41:52 2021

@author: danli
"""
import pandas as pd
import os 
import numpy as np
import matplotlib.pyplot as plt

path0='D:\\CIO\\ayuda\\icochea\\'
dir_list=os.listdir('D:\\CIO\\ayuda\\icochea\\'); check= 'd'
csv_list = [idx for idx in dir_list if idx[0].lower() == check.lower()]
fn=csv_list[0]

df=pd.read_csv(fn,delimiter=';')
df1=pd.df.iloc[:,9]

df['pres2'] = df['pres2'].astype(int)
df_press = df['press'].map(str) + '.' + df['pres2'].map(str) 
df_temp=df['temp'].map(str) + '.' + df['temp2'].map(str)
df_sal=df['sal'].map(str) + '.' +df['sal2'].map(str)
df_ox=df['DO'].map(str) + '.' +df['do2'].map(str)

df_final=pd.DataFrame([df['Date (MM/DD/YYYY)'],df['Time (HH:mm:ss)'],df_press,df_temp, df_sal,
                       df_ox]).T


datos=np.array(df_final)


#plt.plot(df_temp,df_press, 'o')

