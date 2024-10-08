#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd
import numpy as np


# In[3]:


dt = pd.read_csv("Desktop/Diabetes.csv")


# In[4]:


df = pd.DataFrame(dt);


# In[5]:


df


# In[6]:


## identifying:


# In[7]:


df.info()


# In[8]:


df['Pregnancies'].dtypes


# In[9]:


df[df['Pregnancies'].map(type) != int]


# In[10]:


df['Glucose'].dtypes


# In[11]:


df['Glucose'].map(type)


# In[12]:


df[df['Glucose'].map(type) != str]


# In[13]:


df[(df['Glucose'] < '0') | (df['Glucose'] > '99999') | (df['Glucose'] == '0')]


# In[14]:


df.isnull().tail(50)


# In[15]:


df['BloodPressure'].dtypes


# In[16]:


df[(df['BloodPressure'].map(type) != float) | (df['BloodPressure'] == 0)]


# In[17]:


df['SkinThickness'].dtypes


# In[18]:


df['SkinThickness'].map(type)


# In[19]:


df[(df['SkinThickness'] < '0') | (df['SkinThickness'] > '99999')]


# In[20]:


df[(df['SkinThickness'] == '0')]


# In[21]:


df['Insulin'].dtypes


# In[22]:


df['Insulin'].map(type)


# In[23]:


df[(df['Insulin'] < '0') | (df['Insulin'] > '99999')]


# In[24]:


df[(df['Insulin'] == '0')]


# In[25]:


df['BMI'].dtypes


# In[26]:


df['BMI'].map(type)


# In[27]:


df[(df['BMI'] < '0') | (df['BMI'] > '99999')]


# In[28]:


df[(df['BMI'] == '0.0')]


# In[29]:


df['DiabetesPedigreeFunction'].dtypes


# In[30]:


df['DiabetesPedigreeFunction'].map(type)


# In[31]:


df[(df['DiabetesPedigreeFunction'] < '0') | (df['DiabetesPedigreeFunction'] > '99999')]


# In[32]:


df['Age'].dtypes


# In[33]:


df['Age'].map(type)


# In[34]:


df[(df['Age'] < '0') | (df['Age'] > '99999')]


# In[35]:


df['Outcome'].dtypes


# In[36]:


df['Outcome'].map(type)


# In[37]:


df[(df['Outcome'] < '0') | (df['Outcome'] > '99999')]


# In[38]:


## replacement:


# In[39]:


df.tail


# In[40]:


cleared_df = df
cleared_df = cleared_df.replace(("''"),np.NaN)
cleared_df = cleared_df.replace(('MISS'),np.NaN)
cleared_df = cleared_df.replace(('?'),np.NaN)
cleared_df.tail(50)


# In[41]:


cleared_df['BloodPressure'] = cleared_df['BloodPressure'].replace((0),np.NaN)
cleared_df.tail(50)


# In[42]:


cleared_df['Glucose'] = cleared_df['Glucose'].replace(('0'),np.NaN)
cleared_df.tail(50)


# In[43]:


cleared_df['SkinThickness'] = cleared_df['SkinThickness'].replace(('0'),np.NaN)
cleared_df.tail(50)


# In[44]:


cleared_df['Insulin'] = cleared_df['Insulin'].replace(('0'),np.NaN)
cleared_df.tail(50)


# In[45]:


cleared_df['BMI'] = cleared_df['BMI'].replace(('0.0'),np.NaN)
cleared_df.tail(50)


# In[46]:


cleared_df.to_csv("Desktop/Diabetes_cleared.csv", index=False)


# In[47]:


## Counting Missing values of each column


# In[48]:


cleared_df.isnull().sum()

