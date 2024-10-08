#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
from sklearn.datasets import load_breast_cancer
from sklearn import preprocessing
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import StandardScaler


# **part a:**

# In[2]:


cancer = load_breast_cancer()
type(cancer)


# In[3]:


cancer.keys()


# In[4]:


print(cancer.DESCR)


# In[5]:


cancer.feature_names


# In[6]:


df = pd.DataFrame(cancer.data, columns=cancer.feature_names)
df


# **part b:**

# In[7]:


df['Cancer']=cancer.target
df


# **part c:**

# In[8]:


df.dtypes


# In[9]:


df.isnull().sum()


# In[10]:


df.columns


# In[11]:


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


# **part d:**

# In[12]:


Y = df['Cancer']
X = df.drop(['Cancer'], axis=1)


# **part e:**

# In[13]:


X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.2, random_state=5)


# **part f:**

# In[30]:


clf1 = LogisticRegression().fit(X_train, Y_train)


# **part g:**

# In[31]:


Y_pred = clf1.predict(X_test)
accuracy_score(Y_test, Y_pred)


# **part h:**

# liblinear

# In[32]:


clf_liblinear = LogisticRegression(solver='liblinear').fit(X_train, Y_train)


# In[33]:


Y_pred_liblinear = clf_liblinear.predict(X_test)
accuracy_score(Y_test, Y_pred_liblinear)


# saga

# In[34]:


clf_saga = LogisticRegression(solver='saga').fit(X_train, Y_train)


# In[35]:


Y_pred_saga = clf_saga.predict(X_test)
accuracy_score(Y_test, Y_pred_saga)

