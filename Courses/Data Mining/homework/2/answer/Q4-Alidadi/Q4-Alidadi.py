#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
from sklearn.impute import SimpleImputer


# In[4]:


## part b:


# In[2]:


dt_impute = pd.read_csv("Desktop/Diabetes_cleared.csv")


# In[3]:


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


## part c:


# In[8]:


##******************* MinMaxScaler *****************


# In[10]:


from sklearn.preprocessing import MinMaxScaler


# In[34]:


scaleM = MinMaxScaler()
df_scaleM = scaleM.fit_transform(df_impute)
df_scaleM = pd.DataFrame(df_scaleM);
df_scaleM.columns =['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI', 'DiabetesPedigreeFunction', 'Age', 'Outcome'] 
df_scaleM.head(20)


# In[23]:


##******************* StandardScaler *****************


# In[24]:


from sklearn.preprocessing import StandardScaler


# In[35]:


scaleS = StandardScaler()
df_scaleS = scaleS.fit_transform(df_impute)
df_scaleS = pd.DataFrame(df_scaleS);
df_scaleS.columns =['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI', 'DiabetesPedigreeFunction', 'Age', 'Outcome'] 
df_scaleS.head(20)


# In[26]:


##******************* Normalize *****************


# In[27]:


from sklearn import preprocessing


# In[36]:


df_scaleN = preprocessing.normalize(df_impute)
df_scaleN = pd.DataFrame(df_scaleN);
df_scaleN.columns =['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI', 'DiabetesPedigreeFunction', 'Age', 'Outcome'] 
df_scaleN.head(20)


# In[32]:


## part d:


# In[ ]:


##******************* Historam for MinMaxScaler *****************


# In[37]:


df_scaleM.Glucose.hist()


# In[38]:


##******************* Historam for Normalize *****************


# In[39]:


df_scaleN.Glucose.hist()

