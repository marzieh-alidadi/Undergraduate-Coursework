#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np


# In[2]:


## part a:


# In[3]:


bn = pd.read_csv("Desktop/Banknote.csv", header=None)


# In[4]:


df = pd.DataFrame(bn);
df


# In[5]:


## part b:


# In[6]:


## checking missing values:


# In[7]:


df.info()


# In[8]:


## normalizing integer values:


# In[9]:


from sklearn import preprocessing


# In[10]:


df_scaleN = preprocessing.normalize(df[[0, 1, 2, 3]])
df_scaleN = pd.DataFrame(df_scaleN);
df_scaleN['4'] = df[4]
df_ready = df_scaleN
df_ready


# In[11]:


## part c:


# In[12]:


y = df_ready['4']


# In[13]:


X = df_ready.drop(['4'], axis=1)


# In[14]:


from sklearn.cluster import KMeans
kmeans = KMeans(n_clusters=2)
kmeans.fit(X)
y_kmeans = kmeans.predict(X)


# In[15]:


## part d:


# In[16]:


centroids = kmeans.cluster_centers_
centroids = pd.DataFrame(centroids)
centroids


# In[17]:


## part e:


# In[18]:


from mpl_toolkits import mplot3d
import matplotlib.pyplot as plt


# In[19]:


fig = plt.figure(figsize=(20,10))
ax = fig.add_subplot(111, projection='3d')
ax.scatter(X[0], X[1], X[2],
            c=y_kmeans, cmap='viridis',
            edgecolor='k', s=40, alpha = 0.5)

ax.set_title("plot")
ax.set_xlabel("0")
ax.set_ylabel("1")
ax.set_zlabel("2")
ax.dist = 10

ax.scatter(centroids[0], centroids[1], centroids[2],
           s = 300, c = 'r', marker='x', label = 'Centroid')

plt.autoscale(enable=True, axis='x', tight=True)    

plt.show()


# In[20]:


## part g:


# In[21]:


kmeans.inertia_


# In[22]:


## part h:


# In[35]:


inertias = []; 
for i in range(1, 6): 
    kmeans1 = KMeans(n_clusters=i).fit(X);
    inertias.append(kmeans1.inertia_);
inertias


# In[31]:


## part i:


# In[36]:


fig = plt.figure()
ax = plt.axes()
x = np.linspace(1, 5, 5)
plt.xlabel('Values of K')
plt.ylabel('inertias')
ax.plot(x, inertias);


# In[84]:


## part j:


# In[85]:


from sklearn.metrics import silhouette_score
silhouette_score(X, y_kmeans)


# In[86]:


np.unique(kmeans.labels_)


# In[90]:


silhouettes = [];
for i in range(2, 6):
    kmeans2 = KMeans(n_clusters=i).fit(X);
    y_kmeans2 = kmeans2.predict(X);
    silhouettes.append(silhouette_score(X, y_kmeans2));
silhouettes


# In[91]:


silhouette = [];
for i in range(2,6):
    kmeans2 = KMeans(n_clusters=i).fit(X,y);
    silhouette.append(silhouette_score(X, kmeans2.labels_, metric='euclidean'));
silhouette


# In[92]:


fig = plt.figure()
ax = plt.axes()
x2 = np.linspace(2, 5, 4)
plt.xlabel('Values of K')
plt.ylabel('silhouette')
ax.plot(x2, silhouette);

