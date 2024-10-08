#!/usr/bin/env python
# coding: utf-8

# In[15]:


import pandas as pd
import numpy as np


# In[16]:


## part a:


# In[17]:


hs = pd.read_csv("Desktop/housing.csv")


# In[18]:


df = pd.DataFrame(hs);
df


# In[19]:


df.isnull().sum()


# In[20]:


df = df.dropna(how='any',axis=0) 


# In[21]:


df.isnull().sum()


# In[22]:


df


# In[23]:


## part b:


# In[24]:


df.groupby('ocean_proximity').ocean_proximity.count()


# In[25]:


## part c:


# In[26]:


df.longitude.hist()


# In[27]:


df.latitude.hist()


# In[28]:


df.housing_median_age.hist()


# In[29]:


df.total_rooms.hist()


# In[30]:


df.total_bedrooms.hist()


# In[31]:


df.population.hist()


# In[32]:


df.households.hist()


# In[33]:


df.median_income.hist()


# In[34]:


df.median_house_value.hist()


# In[35]:


df.ocean_proximity.hist()


# In[58]:


## part d:


# In[59]:


import geopandas as gpd
import matplotlib.pyplot as plt


# In[69]:


gdf = gpd.GeoDataFrame(df, geometry=gpd.points_from_xy(df.longitude, df.latitude))
gdf


# In[65]:


base = world.plot(color='white', edgecolor='black')
gdf.plot(ax=base, marker='o', color='green', markersize=4);


# In[66]:


gdf.plot(marker='*', color='green', markersize=4);

