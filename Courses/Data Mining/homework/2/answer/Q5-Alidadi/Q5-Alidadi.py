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


# In[10]:


import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')


# In[13]:


def outlier_treatment(datacolumn):
 sorted(datacolumn)
 Q1,Q3 = np.percentile(datacolumn , [25,75])
 IQR = Q3 - Q1
 lower_range = Q1 - (1.5 * IQR)
 upper_range = Q3 + (1.5 * IQR)
 return lower_range,upper_range


# In[16]:


lowerbound_preg,upperbound_preg = outlier_treatment(df_impute.Pregnancies)
lowerbound_gluc,upperbound_gluc = outlier_treatment(df_impute.Glucose)
lowerbound_bldp,upperbound_bldp = outlier_treatment(df_impute.BloodPressure)
lowerbound_sknt,upperbound_sknt = outlier_treatment(df_impute.SkinThickness)
lowerbound_insl,upperbound_insl = outlier_treatment(df_impute.Insulin)
lowerbound_bmi,upperbound_bmi = outlier_treatment(df_impute.BMI)
lowerbound_dibt,upperbound_dibt = outlier_treatment(df_impute.DiabetesPedigreeFunction)
lowerbound_age,upperbound_age = outlier_treatment(df_impute.Age)
lowerbound_outc,upperbound_outc = outlier_treatment(df_impute.Outcome)


# In[18]:


df_impute[(df_impute.Pregnancies < lowerbound_preg) | (df_impute.Pregnancies > upperbound_preg)]


# In[19]:


df_impute[(df_impute.Glucose < lowerbound_gluc) | (df_impute.Glucose > upperbound_gluc)]


# In[20]:


df_impute[(df_impute.BloodPressure < lowerbound_bldp) | (df_impute.BloodPressure > upperbound_bldp)]


# In[21]:


df_impute[(df_impute.SkinThickness < lowerbound_sknt) | (df_impute.SkinThickness > upperbound_sknt)]


# In[22]:


df_impute[(df_impute.Insulin < lowerbound_insl) | (df_impute.Insulin > upperbound_insl)]


# In[23]:


df_impute[(df_impute.BMI < lowerbound_bmi) | (df_impute.BMI > upperbound_bmi)]


# In[24]:


df_impute[(df_impute.DiabetesPedigreeFunction < lowerbound_dibt) | (df_impute.DiabetesPedigreeFunction > upperbound_dibt)]


# In[25]:


df_impute[(df_impute.Age < lowerbound_age) | (df_impute.Age > upperbound_age)]


# In[26]:


df_impute[(df_impute.Outcome < lowerbound_outc) | (df_impute.Outcome > upperbound_outc)]


# In[32]:


## *********** BoxPlot ***********


# In[33]:


import seaborn as sns
sns.set_theme(style="whitegrid")


# In[34]:


sns.boxplot(x=df_impute["Pregnancies"])


# In[35]:


sns.boxplot(x=df_impute["Glucose"])


# In[36]:


sns.boxplot(x=df_impute["BloodPressure"])


# In[37]:


sns.boxplot(x=df_impute["SkinThickness"])


# In[38]:


sns.boxplot(x=df_impute["Insulin"])


# In[39]:


sns.boxplot(x=df_impute["BMI"])


# In[40]:


sns.boxplot(x=df_impute["DiabetesPedigreeFunction"])


# In[41]:


sns.boxplot(x=df_impute["Age"])


# In[42]:


sns.boxplot(x=df_impute["Outcome"])


# In[46]:


df_removing1 = df_impute
df_removing1.drop(df_removing1[ (df_removing1.Pregnancies > upperbound_preg) | (df_removing1.Pregnancies < lowerbound_preg) ].index , inplace=True)
df_removing1.drop(df_removing1[ (df_removing1.Glucose > upperbound_gluc) | (df_removing1.Glucose < lowerbound_gluc) ].index , inplace=True)
df_removing1.drop(df_removing1[ (df_removing1.BloodPressure > upperbound_bldp) | (df_removing1.BloodPressure < lowerbound_bldp) ].index , inplace=True)
df_removing1.drop(df_removing1[ (df_removing1.SkinThickness > upperbound_sknt) | (df_removing1.SkinThickness < lowerbound_sknt) ].index , inplace=True)
df_removing1.drop(df_removing1[ (df_removing1.Insulin > upperbound_insl) | (df_removing1.Insulin < lowerbound_insl) ].index , inplace=True)
df_removing1.drop(df_removing1[ (df_removing1.BMI > upperbound_bmi) | (df_removing1.BMI < lowerbound_bmi) ].index , inplace=True)
df_removing1.drop(df_removing1[ (df_removing1.DiabetesPedigreeFunction > upperbound_dibt) | (df_removing1.DiabetesPedigreeFunction < lowerbound_dibt) ].index , inplace=True)
df_removing1.drop(df_removing1[ (df_removing1.Age > upperbound_age) | (df_removing1.Age < lowerbound_age) ].index , inplace=True)
df_removing1.drop(df_removing1[ (df_removing1.Outcome > upperbound_outc) | (df_removing1.Outcome < lowerbound_outc) ].index , inplace=True)
df_removing1


# In[48]:


## part c:


# In[66]:


dt_impute_z = pd.read_csv("Desktop/Diabetes_cleared.csv")


# In[67]:


df_impute_z = pd.DataFrame(dt_impute_z);
df_impute_z


# In[68]:


mean_imput_z = SimpleImputer(missing_values=np.NaN, strategy='mean')


# In[69]:


df_impute_z.Pregnancies = mean_imput_z.fit_transform(df_impute_z['Pregnancies'].values.reshape(-1,1))[:,0]
df_impute_z.Glucose = mean_imput_z.fit_transform(df_impute_z['Glucose'].values.reshape(-1,1))[:,0]
df_impute_z.BloodPressure = mean_imput_z.fit_transform(df_impute_z['BloodPressure'].values.reshape(-1,1))[:,0]
df_impute_z.SkinThickness = mean_imput_z.fit_transform(df_impute_z['SkinThickness'].values.reshape(-1,1))[:,0]
df_impute_z.Insulin = mean_imput_z.fit_transform(df_impute_z['Insulin'].values.reshape(-1,1))[:,0]
df_impute_z.BMI = mean_imput_z.fit_transform(df_impute_z['BMI'].values.reshape(-1,1))[:,0]
df_impute_z.DiabetesPedigreeFunction = mean_imput_z.fit_transform(df_impute_z['DiabetesPedigreeFunction'].values.reshape(-1,1))[:,0]
df_impute_z.Age = mean_imput_z.fit_transform(df_impute_z['Age'].values.reshape(-1,1))[:,0]
df_impute_z.Outcome = mean_imput_z.fit_transform(df_impute_z['Outcome'].values.reshape(-1,1))[:,0]
df_impute_z.head(20)


# In[70]:


from scipy import stats


# In[71]:


df_removing2 = df_impute_z
df_removing2.drop(df_removing2[ (stats.zscore(df_impute_z['Pregnancies']) > 3) | (stats.zscore(df_impute_z['Pregnancies']) < -3) ].index , inplace=True)
df_removing2.drop(df_removing2[ (stats.zscore(df_impute_z['Glucose']) > 3) | (stats.zscore(df_impute_z['Glucose']) < -3) ].index , inplace=True)
df_removing2.drop(df_removing2[ (stats.zscore(df_impute_z['BloodPressure']) > 3) | (stats.zscore(df_impute_z['BloodPressure']) < -3) ].index , inplace=True)
df_removing2.drop(df_removing2[ (stats.zscore(df_impute_z['SkinThickness']) > 3) | (stats.zscore(df_impute_z['SkinThickness']) < -3) ].index , inplace=True)
df_removing2.drop(df_removing2[ (stats.zscore(df_impute_z['Insulin']) > 3) | (stats.zscore(df_impute_z['Insulin']) < -3) ].index , inplace=True)
df_removing2.drop(df_removing2[ (stats.zscore(df_impute_z['BMI']) > 3) | (stats.zscore(df_impute_z['BMI']) < -3) ].index , inplace=True)
df_removing2.drop(df_removing2[ (stats.zscore(df_impute_z['DiabetesPedigreeFunction']) > 3) | (stats.zscore(df_impute_z['DiabetesPedigreeFunction']) < -3) ].index , inplace=True)
df_removing2.drop(df_removing2[ (stats.zscore(df_impute_z['Age']) > 3) | (stats.zscore(df_impute_z['Age']) < -3) ].index , inplace=True)
df_removing2.drop(df_removing2[ (stats.zscore(df_impute_z['Outcome']) > 3) | (stats.zscore(df_impute_z['Outcome']) < -3) ].index , inplace=True)
df_removing2

