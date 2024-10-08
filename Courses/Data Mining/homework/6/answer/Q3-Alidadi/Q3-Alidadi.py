#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
from sklearn.datasets import load_breast_cancer


# In[6]:


## part a:


# In[4]:


cancer = load_breast_cancer()
print(cancer.DESCR)


# In[5]:


df = pd.DataFrame(cancer.data, columns=cancer.feature_names)
df


# In[7]:


## part b:


# In[8]:


df['Cancer']=cancer.target
df


# In[9]:


## part c:


# In[10]:


df.dtypes


# In[11]:


df.isnull().sum()


# In[12]:


df.columns


# In[14]:


from sklearn import preprocessing


# In[15]:


df[['mean radius', 'mean texture', 'mean perimeter', 'mean area',
       'mean smoothness', 'mean compactness', 'mean concavity',
       'mean concave points', 'mean symmetry', 'mean fractal dimension',
       'radius error', 'texture error', 'perimeter error', 'area error',
       'smoothness error', 'compactness error', 'concavity error',
       'concave points error', 'symmetry error', 'fractal dimension error',
       'worst radius', 'worst texture', 'worst perimeter', 'worst area',
       'worst smoothness', 'worst compactness', 'worst concavity',
       'worst concave points', 'worst symmetry', 'worst fractal dimension']] = preprocessing.normalize(df[['mean radius', 'mean texture', 'mean perimeter', 'mean area',
                                                                                                           'mean smoothness', 'mean compactness', 'mean concavity',
                                                                                                           'mean concave points', 'mean symmetry', 'mean fractal dimension',
                                                                                                           'radius error', 'texture error', 'perimeter error', 'area error',
                                                                                                           'smoothness error', 'compactness error', 'concavity error',
                                                                                                           'concave points error', 'symmetry error', 'fractal dimension error',
                                                                                                           'worst radius', 'worst texture', 'worst perimeter', 'worst area',
                                                                                                           'worst smoothness', 'worst compactness', 'worst concavity',
                                                                                                           'worst concave points', 'worst symmetry', 'worst fractal dimension']])
df


# In[16]:


## part d:


# In[17]:


Y = df['Cancer']
X = df.drop(['Cancer'], axis=1)


# In[19]:


from sklearn.model_selection import train_test_split


# In[20]:


X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.2, random_state=5)


# In[21]:


## part e:


# In[22]:


from sklearn.neural_network import MLPClassifier
mlp = MLPClassifier(hidden_layer_sizes=(10, 10, 10), max_iter=1000)
mlp.fit(X_train, Y_train)


# In[23]:


predictions = mlp.predict(X_test)


# In[24]:


## part f:


# In[25]:


from sklearn.metrics import classification_report, confusion_matrix
print(confusion_matrix(Y_test,predictions))
print(classification_report(Y_test,predictions))


# In[26]:


## part g:


# In[51]:


from sklearn.decomposition import PCA


# In[52]:


X.corr()


# In[53]:


pca01 = PCA(n_components=2)
principComp = pca01.fit_transform(X)


# In[54]:


pca01.explained_variance_ratio_


# In[55]:


np.cumsum(pca01.explained_variance_ratio_)


# In[56]:


X_pca=pd.DataFrame(principComp)


# In[57]:


X_pca.corr()


# In[58]:


from mpl_toolkits import mplot3d
import matplotlib.pyplot as plt


# In[61]:


fig = plt.figure(figsize=(20,10))
ax = fig.add_subplot(111, projection='3d')
ax.scatter(X_pca[0], X_pca[1], Y,
            c=Y, linewidths=1,
            edgecolor='k', s=100, alpha = 0.5)

ax.set_title("plot")
ax.set_xlabel("0")
ax.set_ylabel("1")
ax.set_zlabel("Cancer")
ax.dist = 10

plt.autoscale(enable=True, axis='x', tight=True)    

plt.show()


# In[62]:


## part h:


# In[65]:


X_train_pca, X_test_pca, Y_train_pca, Y_test_pca = train_test_split(X_pca, Y, test_size = 0.2, random_state=5)


# In[66]:


mlp_pca = MLPClassifier(hidden_layer_sizes=(10, 10, 10), max_iter=1000)
mlp_pca.fit(X_train_pca, Y_train_pca)


# In[67]:


predictions_pca = mlp_pca.predict(X_test_pca)


# In[68]:


print(confusion_matrix(Y_test_pca,predictions_pca))
print(classification_report(Y_test_pca,predictions_pca))

