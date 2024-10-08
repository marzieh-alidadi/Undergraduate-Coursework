#!/usr/bin/env python
# coding: utf-8

# In[1]:


## part a:


# In[2]:


import pandas as pd
import numpy as np
from sklearn.impute import SimpleImputer
from sklearn import preprocessing
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier

colnames=['Number of times pregnant.', 'Plasma glucose concentration a 2 hours in an oral glucose tolerance test.'
          , 'Diastolic blood pressure (mm Hg).', 'Triceps skinfold thickness (mm).'
          , '2-Hour serum insulin (mu U/ml).', 'Body mass index (weight in kg/(height in m)^2).'
          , 'Diabetes pedigree function.', 'Age (years).', 'Class variable (0 or 1).'] 

df = pd.read_csv('Desktop/Diabetes.csv', names=colnames, header=None)

df['Plasma glucose concentration a 2 hours in an oral glucose tolerance test.'] = df['Plasma glucose concentration a 2 hours in an oral glucose tolerance test.'].replace((0),np.NaN)
df['Diastolic blood pressure (mm Hg).'] = df['Diastolic blood pressure (mm Hg).'].replace((0),np.NaN)
df['Triceps skinfold thickness (mm).'] = df['Triceps skinfold thickness (mm).'].replace((0),np.NaN)
df['2-Hour serum insulin (mu U/ml).'] = df['2-Hour serum insulin (mu U/ml).'].replace((0),np.NaN)
df['Body mass index (weight in kg/(height in m)^2).'] = df['Body mass index (weight in kg/(height in m)^2).'].replace((0),np.NaN)

mean_imput = SimpleImputer(missing_values=np.NaN, strategy='mean')

df['Plasma glucose concentration a 2 hours in an oral glucose tolerance test.'] = mean_imput.fit_transform(df['Plasma glucose concentration a 2 hours in an oral glucose tolerance test.'].values.reshape(-1,1))[:,0]
df['Diastolic blood pressure (mm Hg).'] = df['Diastolic blood pressure (mm Hg).'] = mean_imput.fit_transform(df['Diastolic blood pressure (mm Hg).'].values.reshape(-1,1))[:,0]
df['Triceps skinfold thickness (mm).'] = mean_imput.fit_transform(df['Triceps skinfold thickness (mm).'].values.reshape(-1,1))[:,0]
df['2-Hour serum insulin (mu U/ml).'] = mean_imput.fit_transform(df['2-Hour serum insulin (mu U/ml).'].values.reshape(-1,1))[:,0]
df['Body mass index (weight in kg/(height in m)^2).'] = mean_imput.fit_transform(df['Body mass index (weight in kg/(height in m)^2).'].values.reshape(-1,1))[:,0]

df_scaleN = preprocessing.normalize(df[['Number of times pregnant.', 'Plasma glucose concentration a 2 hours in an oral glucose tolerance test.'
                                        , 'Diastolic blood pressure (mm Hg).', 'Triceps skinfold thickness (mm).'
                                        , '2-Hour serum insulin (mu U/ml).', 'Body mass index (weight in kg/(height in m)^2).'
                                        , 'Diabetes pedigree function.', 'Age (years).']])
df_scaleN = pd.DataFrame(df_scaleN);
df_scaleN['Class variable (0 or 1).'] = df['Class variable (0 or 1).']
df_scaleN.columns = ['Number of times pregnant.', 'Plasma glucose concentration a 2 hours in an oral glucose tolerance test.'
                     , 'Diastolic blood pressure (mm Hg).', 'Triceps skinfold thickness (mm).'
                     , '2-Hour serum insulin (mu U/ml).', 'Body mass index (weight in kg/(height in m)^2).'
                     , 'Diabetes pedigree function.', 'Age (years).', 'Class variable (0 or 1).'] 

y = df_scaleN['Class variable (0 or 1).']
x = df_scaleN.drop(['Class variable (0 or 1).'], axis=1)

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=2)


# In[14]:


model = RandomForestClassifier(criterion="entropy", max_depth=12).fit(x_train, y_train)


# In[19]:


## part b:


# In[15]:


y_pred = model.predict(x_test)


# In[20]:


## part c:


# In[21]:


from sklearn.metrics import classification_report, confusion_matrix


# In[24]:


print(confusion_matrix(y_test, y_pred))


# In[25]:


## part d:


# In[26]:


print(classification_report(y_test, y_pred))

