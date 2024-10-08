#!/usr/bin/env python
# coding: utf-8

# In[4]:


import pandas as pd
import numpy as np


# In[121]:


## part a:


# In[122]:


dt_a = pd.read_csv("Desktop/Diabetes_cleared.csv")


# In[123]:


df_a = pd.DataFrame(dt_a);
df_a


# In[124]:


df_const = df_a
df_const['Pregnancies'] = df_const['Pregnancies'].fillna(9999, inplace=False)
df_const['Glucose'] = df_const['Glucose'].fillna(9999, inplace=False)
df_const['BloodPressure'] = df_const['BloodPressure'].fillna(9999, inplace=False)
df_const['SkinThickness'] = df_const['SkinThickness'].fillna(9999, inplace=False)
df_const['Insulin'] = df_const['Insulin'].fillna(9999, inplace=False)
df_const['BMI'] = df_const['BMI'].fillna(9999, inplace=False)
df_const['DiabetesPedigreeFunction'] = df_const['DiabetesPedigreeFunction'].fillna(9999, inplace=False)
df_const['Age'] = df_const['Age'].fillna(9999, inplace=False)
df_const['Outcome'] = df_const['Outcome'].fillna(9999, inplace=False)
df_const.head(20)


# In[125]:


## part b:


# In[126]:


dt_b = pd.read_csv("Desktop/Diabetes_cleared.csv")


# In[127]:


df_b = pd.DataFrame(dt_b);
df_b


# In[128]:


df_const_col = df_b
df_const_col['Pregnancies'] = df_const_col['Pregnancies'].fillna(6, inplace=False)
df_const_col['Glucose'] = df_const_col['Glucose'].fillna(148, inplace=False)
df_const_col['BloodPressure'] = df_const_col['BloodPressure'].fillna(72, inplace=False)
df_const_col['SkinThickness'] = df_const_col['SkinThickness'].fillna(35, inplace=False)
df_const_col['Insulin'] = df_const_col['Insulin'].fillna(94, inplace=False)
df_const_col['BMI'] = df_const_col['BMI'].fillna(33.6, inplace=False)
df_const_col['DiabetesPedigreeFunction'] = df_const_col['DiabetesPedigreeFunction'].fillna(0.627, inplace=False)
df_const_col['Age'] = df_const_col['Age'].fillna(50, inplace=False)
df_const_col['Outcome'] = df_const_col['Outcome'].fillna(1, inplace=False)
df_const_col.head(20)


# In[129]:


## part c:


# In[130]:


dt_c = pd.read_csv("Desktop/Diabetes_cleared.csv")


# In[131]:


df_c = pd.DataFrame(dt_c);
df_c


# In[132]:


df_const_mean = df_c
df_const_mean['Pregnancies'] = df_const_mean['Pregnancies'].fillna(np.mean(df_const_mean['Pregnancies']), inplace=False)
df_const_mean['Glucose'] = df_const_mean['Glucose'].fillna(np.mean(df_const_mean['Glucose']), inplace=False)
df_const_mean['BloodPressure'] = df_const_mean['BloodPressure'].fillna(np.mean(df_const_mean['BloodPressure']), inplace=False)
df_const_mean['SkinThickness'] = df_const_mean['SkinThickness'].fillna(np.mean(df_const_mean['SkinThickness']), inplace=False)
df_const_mean['Insulin'] = df_const_mean['Insulin'].fillna(np.mean(df_const_mean['Insulin']), inplace=False)
df_const_mean['BMI'] = df_const_mean['BMI'].fillna(np.mean(df_const_mean['BMI']), inplace=False)
df_const_mean['DiabetesPedigreeFunction'] = df_const_mean['DiabetesPedigreeFunction'].fillna(np.mean(df_const_mean['DiabetesPedigreeFunction']), inplace=False)
df_const_mean['Age'] = df_const_mean['Age'].fillna(np.mean(df_const_mean['Age']), inplace=False)
df_const_mean['Outcome'] = df_const_mean['Outcome'].fillna(np.mean(df_const_mean['Outcome']), inplace=False)
df_const_mean.head(20)


# In[133]:


## part d:


# In[134]:


dt_d = pd.read_csv("Desktop/Diabetes_cleared.csv")


# In[135]:


df_d = pd.DataFrame(dt_d);
df_d


# In[136]:


df_const_mode = df_c
df_const_mode['Pregnancies'] = df_const_mode['Pregnancies'].fillna(df_const_mode['Pregnancies'].mode()[0], inplace=False)
df_const_mode['Glucose'] = df_const_mode['Glucose'].fillna(df_const_mode['Glucose'].mode()[0], inplace=False)
df_const_mode['BloodPressure'] = df_const_mode['BloodPressure'].fillna(df_const_mode['BloodPressure'].mode()[0], inplace=False)
df_const_mode['SkinThickness'] = df_const_mode['SkinThickness'].fillna(df_const_mode['SkinThickness'].mode()[0], inplace=False)
df_const_mode['Insulin'] = df_const_mode['Insulin'].fillna(df_const_mode['Insulin'].mode()[0], inplace=False)
df_const_mode['BMI'] = df_const_mode['BMI'].fillna(df_const_mode['BMI'].mode()[0], inplace=False)
df_const_mode['DiabetesPedigreeFunction'] = df_const_mode['DiabetesPedigreeFunction'].fillna(df_const_mode['DiabetesPedigreeFunction'].mode()[0], inplace=False)
df_const_mode['Age'] = df_const_mode['Age'].fillna(df_const_mode['Age'].mode()[0], inplace=False)
df_const_mode['Outcome'] = df_const_mode['Outcome'].fillna(df_const_mode['Outcome'].mode()[0], inplace=False)
df_const_mode.head(20)


# In[137]:


## part e:


# In[138]:


##******************histogram of Glucose for part a****************


# In[139]:


df_const.Glucose.hist()


# In[140]:


##******************histogram of Glucose for part b****************


# In[141]:


df_const_col.Glucose.hist()


# In[142]:


##******************histogram of Glucose for part c****************


# In[143]:


df_const_mean.Glucose.hist()


# In[144]:


##******************histogram of Glucose for part d****************


# In[145]:


df_const_mode.Glucose.hist()


# In[ ]:


##******************histogram of Glucose main data****************


# In[150]:


dt = pd.read_csv("Desktop/Diabetes_cleared.csv")


# In[151]:


df = pd.DataFrame(dt);
df


# In[152]:


df.Glucose.hist()


# In[189]:


## part g:


# In[1]:


pip install -U scikit-learn


# In[2]:


from sklearn.impute import SimpleImputer


# In[5]:


dt_impute = pd.read_csv("Desktop/Diabetes_cleared.csv")


# In[6]:


df_impute = pd.DataFrame(dt_impute);
df_impute


# In[8]:


mean_imput = SimpleImputer(missing_values=np.NaN, strategy='mean')


# In[16]:


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

