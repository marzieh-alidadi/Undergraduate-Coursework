#!/usr/bin/env python
# coding: utf-8

# In[31]:


import pandas as pd
import numpy as np


# In[32]:


sp = pd.read_csv("Desktop/smartphone.csv")


# In[33]:


df = pd.DataFrame(sp);
df


# In[34]:


## part a:


# In[35]:


crosstab_01 = pd.crosstab(df['Company'], df['Capacity'], margins=True)
crosstab_01


# In[36]:


## part b:


# In[37]:


crosstab_02 = pd.crosstab([df['Company'],df['Weight']], columns=df['inch'], margins=True)
crosstab_02


# In[38]:


## part c:


# In[39]:


crosstab_03 = pd.crosstab(df['Company'],df['OS'])
crosstab_03


# In[40]:


crosstab_03.plot(kind = 'bar', stacked = True)


# In[41]:


crosstab_norm_03 = crosstab_03.div(crosstab_03.sum(1), axis = 0)
crosstab_norm_03.plot(kind='bar', stacked = True)


# In[42]:


crosstab_04 = pd.crosstab(df['OS'],df['Company'])
crosstab_04


# In[43]:


crosstab_04.plot(kind = 'bar', stacked = True)


# In[44]:


crosstab_norm_04 = crosstab_04.div(crosstab_04.sum(1), axis = 0)
crosstab_norm_04.plot(kind='bar', stacked = True)

