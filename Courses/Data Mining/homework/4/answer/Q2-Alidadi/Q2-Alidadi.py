#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np


# In[2]:


## part a:


# In[3]:


colnames=['Number of times pregnant.', 'Plasma glucose concentration a 2 hours in an oral glucose tolerance test.'
          , 'Diastolic blood pressure (mm Hg).', 'Triceps skinfold thickness (mm).'
          , '2-Hour serum insulin (mu U/ml).', 'Body mass index (weight in kg/(height in m)^2).'
          , 'Diabetes pedigree function.', 'Age (years).', 'Class variable (0 or 1).'] 


# In[4]:


df = pd.read_csv('Desktop/Diabetes.csv', names=colnames, header=None)
df


# In[5]:


## part b:


# In[6]:


## checking missing values and outliers:


# In[7]:


df.info()


# In[8]:


def minMax(df):
    return pd.Series(index=['min','max'],data=[df.min(),df.max()])
df.apply(minMax)


# In[9]:


df['Plasma glucose concentration a 2 hours in an oral glucose tolerance test.'] = df['Plasma glucose concentration a 2 hours in an oral glucose tolerance test.'].replace((0),np.NaN)
df['Diastolic blood pressure (mm Hg).'] = df['Diastolic blood pressure (mm Hg).'].replace((0),np.NaN)
df['Triceps skinfold thickness (mm).'] = df['Triceps skinfold thickness (mm).'].replace((0),np.NaN)
df['2-Hour serum insulin (mu U/ml).'] = df['2-Hour serum insulin (mu U/ml).'].replace((0),np.NaN)
df['Body mass index (weight in kg/(height in m)^2).'] = df['Body mass index (weight in kg/(height in m)^2).'].replace((0),np.NaN)


# In[10]:


from sklearn.impute import SimpleImputer


# In[11]:


mean_imput = SimpleImputer(missing_values=np.NaN, strategy='mean')


# In[12]:


df['Plasma glucose concentration a 2 hours in an oral glucose tolerance test.'] = mean_imput.fit_transform(df['Plasma glucose concentration a 2 hours in an oral glucose tolerance test.'].values.reshape(-1,1))[:,0]
df['Diastolic blood pressure (mm Hg).'] = df['Diastolic blood pressure (mm Hg).'] = mean_imput.fit_transform(df['Diastolic blood pressure (mm Hg).'].values.reshape(-1,1))[:,0]
df['Triceps skinfold thickness (mm).'] = mean_imput.fit_transform(df['Triceps skinfold thickness (mm).'].values.reshape(-1,1))[:,0]
df['2-Hour serum insulin (mu U/ml).'] = mean_imput.fit_transform(df['2-Hour serum insulin (mu U/ml).'].values.reshape(-1,1))[:,0]
df['Body mass index (weight in kg/(height in m)^2).'] = mean_imput.fit_transform(df['Body mass index (weight in kg/(height in m)^2).'].values.reshape(-1,1))[:,0]


# In[13]:


def minMax(df):
    return pd.Series(index=['min','max'],data=[df.min(),df.max()])
df.apply(minMax)


# In[14]:


df.info()


# In[15]:


## normalizing integer values:


# In[16]:


from sklearn import preprocessing


# In[17]:


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
df_scaleN


# In[18]:


## part c:


# In[19]:


y = df_scaleN['Class variable (0 or 1).']


# In[20]:


x = df_scaleN.drop(['Class variable (0 or 1).'], axis=1)


# In[21]:


## part d:


# In[22]:


from sklearn.model_selection import train_test_split


# In[23]:


x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=2)


# In[24]:


y_train.value_counts()


# In[25]:


y_test.value_counts()


# In[26]:


## part e:


# In[32]:


from sklearn.ensemble import RandomForestClassifier


# In[33]:


model = RandomForestClassifier(criterion="entropy", max_depth=3).fit(x_train, y_train)


# In[34]:


## part f:


# In[35]:


y_pred = model.predict(x_test)


# In[36]:


from sklearn.metrics import classification_report, confusion_matrix


# In[37]:


print(confusion_matrix(y_test, y_pred))


# In[38]:


print(classification_report(y_test, y_pred))


# In[39]:


## part g:


# In[40]:


## max_depth=2


# In[41]:


model1 = RandomForestClassifier(criterion="entropy", max_depth=2).fit(x_train, y_train)


# In[43]:


y_pred1 = model1.predict(x_test)


# In[44]:


print(confusion_matrix(y_test, y_pred1))


# In[62]:


print(classification_report(y_test, y_pred1))


# In[45]:


## max_depth=1


# In[46]:


model2 = RandomForestClassifier(criterion="entropy", max_depth=1).fit(x_train, y_train)


# In[47]:


y_pred2 = model2.predict(x_test)


# In[48]:


print(confusion_matrix(y_test, y_pred2))


# In[63]:


print(classification_report(y_test, y_pred2))


# In[50]:


## max_depth=4


# In[51]:


model3 = RandomForestClassifier(criterion="entropy", max_depth=4).fit(x_train, y_train)


# In[52]:


y_pred3 = model3.predict(x_test)


# In[53]:


print(confusion_matrix(y_test, y_pred3))


# In[65]:


print(classification_report(y_test, y_pred3))


# In[54]:


## max_depth=5


# In[55]:


model4 = RandomForestClassifier(criterion="entropy", max_depth=5).fit(x_train, y_train)


# In[56]:


y_pred4 = model4.predict(x_test)


# In[57]:


print(confusion_matrix(y_test, y_pred4))


# In[66]:


print(classification_report(y_test, y_pred4))


# In[58]:


## max_depth=6


# In[59]:


model5 = RandomForestClassifier(criterion="entropy", max_depth=6).fit(x_train, y_train)


# In[60]:


y_pred5 = model5.predict(x_test)


# In[61]:


print(confusion_matrix(y_test, y_pred5))


# In[68]:


print(classification_report(y_test, y_pred5))


# In[69]:


## max_depth=7


# In[70]:


model6 = RandomForestClassifier(criterion="entropy", max_depth=7).fit(x_train, y_train)


# In[71]:


y_pred6 = model6.predict(x_test)


# In[72]:


print(confusion_matrix(y_test, y_pred6))


# In[73]:


print(classification_report(y_test, y_pred6))


# In[74]:


## max_depth=10


# In[75]:


model7 = RandomForestClassifier(criterion="entropy", max_depth=10).fit(x_train, y_train)


# In[76]:


y_pred7 = model7.predict(x_test)


# In[77]:


print(confusion_matrix(y_test, y_pred7))


# In[78]:


print(classification_report(y_test, y_pred7))


# In[113]:


## max_depth=11


# In[122]:


model8 = RandomForestClassifier(criterion="entropy", max_depth=11).fit(x_train, y_train)


# In[123]:


y_pred8 = model8.predict(x_test)


# In[124]:


print(confusion_matrix(y_test, y_pred8))


# In[125]:


print(classification_report(y_test, y_pred8))


# In[126]:


## max_depth=12


# In[139]:


model9 = RandomForestClassifier(criterion="entropy", max_depth=12).fit(x_train, y_train)


# In[140]:


y_pred9 = model9.predict(x_test)


# In[141]:


print(confusion_matrix(y_test, y_pred9))


# In[142]:


print(classification_report(y_test, y_pred9))


# In[177]:


## max_depth=13


# In[178]:


model10 = RandomForestClassifier(criterion="entropy", max_depth=13).fit(x_train, y_train)


# In[179]:


y_pred10 = model10.predict(x_test)


# In[180]:


print(confusion_matrix(y_test, y_pred10))


# In[181]:


print(classification_report(y_test, y_pred10))


# In[182]:


## max_depth=16


# In[183]:


model11 = RandomForestClassifier(criterion="entropy", max_depth=16).fit(x_train, y_train)


# In[184]:


y_pred11 = model11.predict(x_test)


# In[185]:


print(confusion_matrix(y_test, y_pred11))


# In[186]:


print(classification_report(y_test, y_pred11))

