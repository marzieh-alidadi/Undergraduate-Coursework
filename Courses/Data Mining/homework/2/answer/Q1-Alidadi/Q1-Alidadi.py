#!/usr/bin/env python
# coding: utf-8

# In[8]:


import pandas as pd
import numpy as np


# In[9]:


## part a:


# In[10]:


vh = pd.read_csv("Desktop/Vehicle.csv")


# In[11]:


df = pd.DataFrame(vh);


# In[14]:


df


# In[15]:


## part b:


# In[16]:


df.info()


# In[17]:


## part c:


# In[45]:


df_new = df[ (df['CIRCULARITY'] > 50) & (df['CIRCULARITY'] < 60) ]


# In[48]:


df_new


# In[51]:


df_new.to_csv("Desktop/Vehicle_new.csv")


# In[53]:


## part d:


# In[66]:


average = np.mean(df['RADIUS_RATIO'])
average


# In[67]:


minimum = np.min(df['RADIUS_RATIO'])
minimum


# In[68]:


maximum = np.max(df['RADIUS_RATIO'])
maximum


# In[69]:


standard_deviation = np.std(df['RADIUS_RATIO'])
standard_deviation


# In[65]:


# part e:


# In[75]:


conditions = [
    (df['ELONGATEDNESS'] < 30),
    (df['ELONGATEDNESS'] >= 30) & (df['ELONGATEDNESS'] <= 45),
    (df['ELONGATEDNESS'] > 45)    
]


# In[79]:


values = ['LOW', 'MEDIUM', 'HIGH']


# In[80]:


df['ElonBin']  = np.select(conditions, values)


# In[92]:


df[['ELONGATEDNESS', 'ElonBin']].head(n=20)


# In[100]:


## part f:


# In[115]:


df.groupby('Class', as_index=False)['DISTANCE_CIRCULARITY'].mean()


# In[116]:


## part g:


# In[117]:


df.corr()


# In[ ]:


## part h:


# In[118]:


df.SCATTER_RATIO.hist()

