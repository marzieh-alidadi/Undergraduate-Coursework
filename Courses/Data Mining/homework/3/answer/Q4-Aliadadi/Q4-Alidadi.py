#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
import random


# In[2]:


tr = pd.read_csv("Desktop/thyroid.csv")


# In[3]:


df = pd.DataFrame(tr);
df


# In[8]:


## part a:


# In[9]:


df_train, df_test = train_test_split(df, test_size = 0.2, random_state = 1)


# In[10]:


print(df.shape)
print(df_train.shape)
print(df_test.shape)


# In[11]:


df_train.to_csv("Desktop/thyroid_train.csv", index=False)
df_test.to_csv("Desktop/thyroid_test.csv", index=False)


# In[13]:


## part c:


# In[17]:


df['Outcome'].value_counts()


# In[15]:


df_train['Outcome'].value_counts()


# In[16]:


df_test['Outcome'].value_counts()

