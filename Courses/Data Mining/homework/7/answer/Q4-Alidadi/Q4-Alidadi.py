#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np


# **part a:**

# In[2]:


hr = pd.read_csv("Desktop/Heart.csv")


# In[3]:


df = pd.DataFrame(hr)
df


# In[4]:


df.dtypes


# In[5]:


df.isnull().sum()


# In[6]:


df = df.dropna()


# In[7]:


df.isnull().sum()


# In[8]:


df


# **part b:**

# In[26]:


df['C'] = np.arange(df.shape[0])
df


# In[35]:


item_list = (df[df['target'] =='1']
             .groupby(['gender','exercise induced angina', 'C']))


# In[36]:


item_list


# In[37]:


from mlxtend.frequent_patterns import apriori
from mlxtend.frequent_patterns import association_rules


# In[ ]:


# Build up the frequent items
frequent_itemsets = apriori(item_list, min_support=0.2, use_colnames=True)


# In[ ]:


frequent_itemsets.head()


# In[ ]:


# Create the rules
rules = association_rules(frequent_itemsets, metric="lift", min_threshold=1)
rules


# In[ ]:


rules[ (rules2['lift'] >= 4) &
        (rules2['confidence'] >= 0.5) ]

