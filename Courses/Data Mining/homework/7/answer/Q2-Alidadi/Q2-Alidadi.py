#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
from sklearn.datasets import load_boston
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split


# **part a:**

# In[2]:


boston=load_boston()
type(boston)


# In[3]:


boston.keys()


# In[4]:


print(boston.DESCR)


# In[5]:


boston.feature_names


# **part b:**

# In[6]:


df = pd.DataFrame(boston.data, columns=boston.feature_names)
df


# **part c:**

# In[7]:


df['Price']=boston.target
df


# **part i:**

# In[9]:


df.dtypes


# In[10]:


df.isnull().sum()


# In[11]:


df = pd.get_dummies(df, columns=['CHAS', 'RAD'])
df


# In[12]:


df.columns


# In[13]:


from sklearn import preprocessing


# In[14]:


df[['CRIM', 'ZN', 'INDUS', 'NOX', 'RM', 'AGE', 'DIS', 'TAX', 'PTRATIO', 'B', 'LSTAT']] = preprocessing.normalize(df[['CRIM', 'ZN', 'INDUS', 'NOX', 'RM', 'AGE', 'DIS', 'TAX', 'PTRATIO', 'B', 'LSTAT']])
df


# **part j:**

# In[15]:


Y = df['Price']
X = df.drop(['Price'], axis=1)


# In[16]:


X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.2, random_state=5)


# **part d:**

# In[17]:


from sklearn import linear_model


# In[18]:


clf = linear_model.PoissonRegressor().fit(X_train, Y_train)


# In[19]:


Y_test_predict = clf.predict(X_test)


# **part e:**

# In[20]:


from sklearn.metrics import r2_score
from sklearn import metrics
print("MSE:",metrics.mean_squared_error(Y_test,Y_test_predict))
print("MAE:",metrics.mean_absolute_error(Y_test,Y_test_predict))
print("RMSE:",np.sqrt(metrics.mean_squared_error(Y_test,Y_test_predict)))
print("R_squared:",r2_score(Y_test,Y_test_predict))


# In[21]:


from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
folds = KFold(n_splits = 5, shuffle = True, random_state = 100)
scores = cross_val_score(clf, X, Y, scoring='r2', cv=folds)
scores 


# In[22]:


np.mean(scores)

