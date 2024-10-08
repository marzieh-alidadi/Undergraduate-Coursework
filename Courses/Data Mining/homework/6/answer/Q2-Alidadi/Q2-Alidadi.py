#!/usr/bin/env python
# coding: utf-8

# In[38]:


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.datasets import load_boston
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split


# In[39]:


## part a:


# In[40]:


boston=load_boston()
type(boston)


# In[41]:


boston.keys()


# In[106]:


print(boston.DESCR)


# In[43]:


boston.feature_names


# In[44]:


## part b:


# In[49]:


df = pd.DataFrame(boston.data, columns=boston.feature_names)
df


# In[50]:


## part c:


# In[51]:


df['Price']=boston.target
df


# In[52]:


## part i:


# In[54]:


df.dtypes


# In[56]:


df.isnull().sum()


# In[57]:


df = pd.get_dummies(df, columns=['CHAS', 'RAD'])
df


# In[58]:


df.columns


# In[59]:


from sklearn import preprocessing


# In[60]:


df[['CRIM', 'ZN', 'INDUS', 'NOX', 'RM', 'AGE', 'DIS', 'TAX', 'PTRATIO', 'B', 'LSTAT']] = preprocessing.normalize(df[['CRIM', 'ZN', 'INDUS', 'NOX', 'RM', 'AGE', 'DIS', 'TAX', 'PTRATIO', 'B', 'LSTAT']])
df


# In[61]:


## part j:


# In[65]:


Y = df['Price']
X = df.drop(['Price'], axis=1)


# In[66]:


X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.3, random_state=5)


# In[67]:


## part d:


# In[68]:


from sklearn.linear_model import LinearRegression


# In[69]:


model = LinearRegression().fit(X_train, Y_train)


# In[81]:


Y_test_predict = model.predict(X_test)


# In[71]:


## part e:


# In[82]:


from sklearn.metrics import r2_score
from sklearn import metrics
print("MSE:",metrics.mean_squared_error(Y_test,Y_test_predict))
print("MAE:",metrics.mean_absolute_error(Y_test,Y_test_predict))
print("RMSE:",np.sqrt(metrics.mean_squared_error(Y_test,Y_test_predict)))
print("R_squared:",r2_score(Y_test,Y_test_predict))


# In[103]:


## part f:


# In[104]:


from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
folds = KFold(n_splits = 5, shuffle = True, random_state = 100)
scores = cross_val_score(model, X, Y, scoring='r2', cv=folds)
scores 


# In[105]:


np.mean(scores)

