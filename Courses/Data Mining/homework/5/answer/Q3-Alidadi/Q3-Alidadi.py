#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
get_ipython().run_line_magic('matplotlib', 'inline')


# In[2]:


## part a:


# In[3]:


from sklearn import datasets
iris = datasets.load_iris()

df = pd.DataFrame(iris['data'])
df


# In[4]:


np.unique(iris.target,return_counts=True)


# In[5]:


iris.target_names


# In[6]:


##                 rescaling data to a standard deviation of 1:


# In[7]:


from scipy.cluster.vq import whiten
scaled_data = whiten(df.to_numpy())
scaled_data


# In[8]:


pd.DataFrame(scaled_data).describe()


# In[9]:


from scipy.cluster.hierarchy import fcluster, linkage


# In[10]:


distance_matrix = linkage(scaled_data, method = 'ward', metric = 'euclidean')
distance_matrix


# In[11]:


## part b:


# In[12]:


from scipy.cluster.hierarchy import dendrogram

dn = dendrogram(distance_matrix)
plt.show()


# In[13]:


## part c:


# In[14]:


df['cluster_labels_6'] = fcluster(distance_matrix, 6, depth=6, criterion='distance')
df['cluster_labels_6']


# In[15]:


df.cluster_labels_6.value_counts()


# In[16]:


df['target'] = iris.target
fig, axes = plt.subplots(1, 2, figsize=(16,8))
axes[0].scatter(df[0], df[1], c=df['target'])
axes[1].scatter(df[0], df[1], c=df['cluster_labels_6'], cmap=plt.cm.Set1)
axes[0].set_title('Actual', fontsize=18)
axes[1].set_title('Hierarchical with 6', fontsize=18)


# In[17]:


## part d:


# In[18]:


df['cluster_labels_3'] = fcluster(distance_matrix, 3, depth=3, criterion='distance')
df['cluster_labels_3']


# In[19]:


df.cluster_labels_3.value_counts()


# In[20]:


df['target'] = iris.target
fig, axes = plt.subplots(1, 2, figsize=(16,8))
axes[0].scatter(df[0], df[1], c=df['target'])
axes[1].scatter(df[0], df[1], c=df['cluster_labels_3'], cmap=plt.cm.Set1)
axes[0].set_title('Actual', fontsize=18)
axes[1].set_title('Hierarchical with 3', fontsize=18)

