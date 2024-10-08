#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np


# In[2]:


## part a:


# In[34]:


cm = pd.read_csv("Desktop/Camera.csv", sep=';')


# In[35]:


df = pd.DataFrame(cm);
df


# In[36]:


## part b:


# In[37]:


## checking missing values:


# In[38]:


df.info()


# In[39]:


def minMax(df):
    return pd.Series(index=['min','max'],data=[df.min(),df.max()])
df.apply(minMax)


# In[40]:


df['Max resolution'] = df['Max resolution'].replace((0),np.NaN)
df['Low resolution'] = df['Low resolution'].replace((0),np.NaN)
df['Effective pixels'] = df['Effective pixels'].replace((0),np.NaN)
df['Zoom wide (W)'] = df['Zoom wide (W)'].replace((0),np.NaN)
df['Zoom tele (T)'] = df['Zoom tele (T)'].replace((0),np.NaN)
df['Normal focus range'] = df['Normal focus range'].replace((0),np.NaN)
df['Macro focus range'] = df['Macro focus range'].replace((0),np.NaN)
df['Storage included'] = df['Storage included'].replace((0),np.NaN)
df['Weight (inc. batteries)'] = df['Weight (inc. batteries)'].replace((0),np.NaN)
df['Dimensions'] = df['Dimensions'].replace((0),np.NaN)


# In[41]:


df.info()


# In[42]:


from sklearn.impute import SimpleImputer


# In[43]:


mean_imput = SimpleImputer(missing_values=np.NaN, strategy='mean')


# In[44]:


df['Max resolution'] = mean_imput.fit_transform(df['Max resolution'].values.reshape(-1,1))[:,0]
df['Low resolution'] = mean_imput.fit_transform(df['Low resolution'].values.reshape(-1,1))[:,0]
df['Effective pixels'] = mean_imput.fit_transform(df['Effective pixels'].values.reshape(-1,1))[:,0]
df['Zoom wide (W)'] = mean_imput.fit_transform(df['Zoom wide (W)'].values.reshape(-1,1))[:,0]
df['Zoom tele (T)'] = mean_imput.fit_transform(df['Zoom tele (T)'].values.reshape(-1,1))[:,0]
df['Normal focus range'] = mean_imput.fit_transform(df['Normal focus range'].values.reshape(-1,1))[:,0]
df['Macro focus range'] = mean_imput.fit_transform(df['Macro focus range'].values.reshape(-1,1))[:,0]
df['Storage included'] = mean_imput.fit_transform(df['Storage included'].values.reshape(-1,1))[:,0]
df['Weight (inc. batteries)'] = mean_imput.fit_transform(df['Weight (inc. batteries)'].values.reshape(-1,1))[:,0]
df['Dimensions'] = mean_imput.fit_transform(df['Dimensions'].values.reshape(-1,1))[:,0]


# In[45]:


df.info()


# In[46]:


def minMax(df):
    return pd.Series(index=['min','max'],data=[df.min(),df.max()])
df.apply(minMax)


# In[47]:


## normalizing integer values:


# In[48]:


from sklearn import preprocessing


# In[49]:


df[['Release date', 'Max resolution', 'Low resolution', 'Effective pixels', 'Zoom wide (W)', 'Zoom tele (T)', 'Normal focus range', 'Macro focus range', 'Storage included', 'Weight (inc. batteries)', 'Dimensions']] = preprocessing.normalize(df[['Release date', 'Max resolution', 'Low resolution', 'Effective pixels', 'Zoom wide (W)', 'Zoom tele (T)', 'Normal focus range', 'Macro focus range', 'Storage included', 'Weight (inc. batteries)', 'Dimensions']])
df


# In[50]:


## encoding categorical variable:


# In[51]:


from sklearn.preprocessing import OrdinalEncoder


# In[52]:


encoder = OrdinalEncoder()


# In[53]:


df['Model'] = encoder.fit_transform(df[['Model']])
df


# In[55]:


## part d:


# In[57]:


import seaborn as sns


# In[58]:


sns.pairplot(df)


# In[59]:


## part e:


# In[60]:


y = df['Price']


# In[64]:


x = df.drop(['Price'], axis=1)


# In[65]:


## part f:


# In[66]:


from sklearn.model_selection import train_test_split


# In[67]:


x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=2)


# In[68]:


## part g:


# In[70]:


import statsmodels.api as sm


# In[71]:


x_train = sm.add_constant(x_train)


# In[72]:


model01 = sm.OLS(y_train, x_train).fit()


# In[73]:


model01.summary()


# In[79]:


from sklearn.linear_model import LinearRegression


# In[81]:


model = LinearRegression().fit(x_train, y_train)


# In[74]:


## part h:


# In[82]:


print('intercept:', model.intercept_)


# In[83]:


print('coef:', model.coef_)

