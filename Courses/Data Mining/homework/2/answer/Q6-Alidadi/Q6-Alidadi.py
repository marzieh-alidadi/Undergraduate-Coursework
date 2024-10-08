#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
from sklearn.impute import SimpleImputer


# In[2]:


## part a:


# In[3]:


dt_impute = pd.read_csv("Desktop/Diabetes_cleared.csv")


# In[4]:


df_impute = pd.DataFrame(dt_impute);
df_impute


# In[5]:


mean_imput = SimpleImputer(missing_values=np.NaN, strategy='mean')


# In[6]:


df_impute.Pregnancies = mean_imput.fit_transform(df_impute['Pregnancies'].values.reshape(-1,1))[:,0]
df_impute.Glucose = mean_imput.fit_transform(df_impute['Glucose'].values.reshape(-1,1))[:,0]
df_impute.BloodPressure = mean_imput.fit_transform(df_impute['BloodPressure'].values.reshape(-1,1))[:,0]
df_impute.SkinThickness = mean_imput.fit_transform(df_impute['SkinThickness'].values.reshape(-1,1))[:,0]
df_impute.Insulin = mean_imput.fit_transform(df_impute['Insulin'].values.reshape(-1,1))[:,0]
df_impute.BMI = mean_imput.fit_transform(df_impute['BMI'].values.reshape(-1,1))[:,0]
df_impute.DiabetesPedigreeFunction = mean_imput.fit_transform(df_impute['DiabetesPedigreeFunction'].values.reshape(-1,1))[:,0]
df_impute.Age = mean_imput.fit_transform(df_impute['Age'].values.reshape(-1,1))[:,0]
df_impute.Outcome = mean_imput.fit_transform(df_impute['Outcome'].values.reshape(-1,1))[:,0]
df_impute.head(20)


# In[7]:


## part b:


# In[8]:


df_impute['Pregnancies'] = pd.cut(df_impute['Pregnancies'], bins=3, labels=['bucket_1', 'bucket_2', 'bucket_3'])
df_impute.head()
df_impute['Pregnancies'].hist()


# In[9]:


df_impute['Age'] = pd.cut(df_impute['Age'], bins=4, labels=['bucket_1', 'bucket_2', 'bucket_3', 'bucket_4'])
df_impute.head()
df_impute['Age'].hist()

