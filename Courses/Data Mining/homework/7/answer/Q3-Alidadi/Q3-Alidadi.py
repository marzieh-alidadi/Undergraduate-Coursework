#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
from gsppy.gsp import GSP


# **part a:**

# In[2]:


sq = pd.read_csv("Desktop/sequence.csv", names=['item_set'], delimiter='/')
sq


# In[3]:


df = pd.DataFrame(sq)


# In[4]:


df = pd.DataFrame(df,columns=['index','item_set'])


# In[5]:


for i in range(0,2818):
    df['index'][i]  = i+1
df['index'] = df['index'].astype('int64')


# In[6]:


df


# In[7]:


df['item_set'] = df['item_set'].str.strip(',')
df


# In[8]:


df['item_set'] = df['item_set'].str.replace(",", " ")
df['item_set'] = df['item_set'].str.split()
df


# In[9]:


item_list = []
for i in df['index']:
    item_list.append(df['item_set'][i-1])
item_list


# **part b:**

# In[10]:


result = GSP(item_list).search(0.3)
result


# **part c:**

# In[12]:


result2 = GSP(item_list).search(0.01)
result2


# In[35]:


matching = [s for s in item_list if "Bread" and "Sweet" in s]
matching

