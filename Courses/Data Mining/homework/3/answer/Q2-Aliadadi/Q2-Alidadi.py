#!/usr/bin/env python
# coding: utf-8

# In[25]:


import pandas as pd
import numpy as np
import seaborn as sns


# In[26]:


hs = pd.read_csv("Desktop/housing.csv")


# In[27]:


df = pd.DataFrame(hs);
df


# In[28]:


## part a:


# In[29]:


sns.pairplot(df)


# In[30]:


sns.pairplot(df, hue = 'ocean_proximity')


# In[31]:


## part b:


# In[32]:


df.corr()


# In[33]:


## part d:


# In[34]:


from scipy import stats


# In[45]:


median_house_value_array = df.loc[:,'median_house_value']


# In[46]:


median_income_array = df.loc[:,'median_income']


# In[48]:


stats.pearsonr(median_house_value_array, median_income_array)


# In[49]:


## part e:


# In[50]:


df['housing_median_age'].corr(df['total_rooms'], method = 'spearman')


# In[51]:


## part f:


# In[53]:


df['median_house_value'].corr(df['median_income'])


# In[54]:


## part g:


# In[56]:


import seaborn as sns


# In[59]:


sns.heatmap(df.corr());

