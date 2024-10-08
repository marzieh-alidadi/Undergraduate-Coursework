#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np


# In[2]:


tr = pd.read_csv("Desktop/thyroid.csv")


# In[3]:


## part a:


# In[4]:


df = pd.DataFrame(tr);
df.head(10)


# In[5]:


df.isnull().sum()


# In[6]:


df = df.replace(('?'),np.NaN)
df.head(10)


# In[7]:


df['T3_resin'] = df['T3_resin'].astype(float)
df['Serum_thyroxin'] = df['Serum_thyroxin'].astype(float)
df['Serum_triiodothyronine'] = df['Serum_triiodothyronine'].astype(float)
df['Basal_TSH'] = df['Basal_TSH'].astype(float)
df['Abs_diff_TSH'] = df['Abs_diff_TSH'].astype(float)
df['Outcome'] = df['Outcome'].astype(float)
df.head(10)


# In[8]:


df['T3_resin'] = df['T3_resin'].fillna(np.mean(df['T3_resin']), inplace=False)
df['Serum_thyroxin'] = df['Serum_thyroxin'].fillna(np.mean(df['Serum_thyroxin']), inplace=False)
df['Serum_triiodothyronine'] = df['Serum_triiodothyronine'].fillna(np.mean(df['Serum_triiodothyronine']), inplace=False)
df['Basal_TSH'] = df['Basal_TSH'].fillna(np.mean(df['Basal_TSH']), inplace=False)
df['Abs_diff_TSH'] = df['Abs_diff_TSH'].fillna(np.mean(df['Abs_diff_TSH']), inplace=False)
df['Outcome'] = df['Outcome'].fillna(np.mean(df['Outcome']), inplace=False)
df.head(10)


# In[9]:


df.isnull().sum()


# In[10]:


## part b:


# In[11]:


df.corr()


# In[12]:


import seaborn as sns


# In[13]:


sns.heatmap(df.corr());


# In[14]:


## part c:


# In[15]:


df['Outcome'].value_counts()


# In[16]:


df.loc[(df['Outcome'] > 1) & (df['Outcome'] < 2), 'Outcome'] = 1
df['Outcome']


# In[17]:


df['Outcome'].value_counts()


# In[18]:


to_resample = df.loc[df['Outcome'] == 2]


# In[19]:


our_resample = to_resample.sample(n = 125, replace = True)


# In[20]:


df_balanced = pd.concat([df, our_resample])


# In[21]:


df_balanced['Outcome'].value_counts()


# In[22]:


## part d:


# In[23]:


from sklearn.model_selection import train_test_split


# In[24]:


y = df_balanced['Outcome']


# In[25]:


x = df_balanced.drop(['Outcome'], axis=1)


# In[26]:


x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=2)


# In[27]:


print(x_train.shape);
print(x_test.shape);
print(y_train.shape);
print(y_test.shape);


# In[28]:


## part e:


# In[29]:


import statsmodels.tools.tools as stattools
from sklearn.tree import DecisionTreeClassifier, export_graphviz


# In[30]:


cart = DecisionTreeClassifier(criterion = "gini", max_leaf_nodes=6).fit(x_train,y_train)


# In[31]:


from sklearn import tree


# In[32]:


tree.plot_tree(cart);


# In[33]:


import matplotlib.pyplot as plt


# In[34]:


fig, axes = plt.subplots(1, 1, figsize=(15, 15))
tree.plot_tree(cart, ax=axes);


# In[35]:


## part f:


# In[36]:


y_pred = cart.predict(x_test)


# In[37]:


from sklearn.metrics import classification_report, confusion_matrix


# In[38]:


print(confusion_matrix(y_test, y_pred))


# In[39]:


print(classification_report(y_test, y_pred))


# In[40]:


## part g:


# In[41]:


########### max_depth=1


# In[42]:


cart1 = DecisionTreeClassifier(criterion = "gini", max_depth=1).fit(x_train,y_train)


# In[43]:


y_pred_1 = cart1.predict(x_test)


# In[44]:


print(confusion_matrix(y_test, y_pred_1))
print(classification_report(y_test, y_pred_1))


# In[45]:


########### max_depth=2


# In[46]:


cart2 = DecisionTreeClassifier(criterion = "gini", max_depth=2).fit(x_train,y_train)


# In[47]:


y_pred_2 = cart2.predict(x_test)


# In[48]:


print(confusion_matrix(y_test, y_pred_2))
print(classification_report(y_test, y_pred_2))


# In[49]:


########### max_depth=3


# In[50]:


cart3 = DecisionTreeClassifier(criterion = "gini", max_depth=3).fit(x_train,y_train)


# In[51]:


y_pred_3 = cart3.predict(x_test)


# In[52]:


print(confusion_matrix(y_test, y_pred_3))
print(classification_report(y_test, y_pred_3))


# In[53]:


########### max_depth=4


# In[54]:


cart4 = DecisionTreeClassifier(criterion = "gini", max_depth=4).fit(x_train,y_train)


# In[55]:


y_pred_4 = cart4.predict(x_test)


# In[56]:


print(confusion_matrix(y_test, y_pred_4))
print(classification_report(y_test, y_pred_4))


# In[57]:


########### max_depth=5


# In[58]:


cart5 = DecisionTreeClassifier(criterion = "gini", max_depth=5).fit(x_train,y_train)


# In[59]:


y_pred_5 = cart5.predict(x_test)


# In[60]:


print(confusion_matrix(y_test, y_pred_5))
print(classification_report(y_test, y_pred_5))


# In[61]:


########### max_depth=6


# In[62]:


cart6 = DecisionTreeClassifier(criterion = "gini", max_depth=6).fit(x_train,y_train)


# In[63]:


y_pred_6 = cart6.predict(x_test)


# In[64]:


print(confusion_matrix(y_test, y_pred_6))
print(classification_report(y_test, y_pred_6))


# In[65]:


########### max_depth=7


# In[66]:


cart7 = DecisionTreeClassifier(criterion = "gini", max_depth=7).fit(x_train,y_train)


# In[67]:


y_pred_7 = cart7.predict(x_test)


# In[68]:


print(confusion_matrix(y_test, y_pred_7))
print(classification_report(y_test, y_pred_7))


# In[69]:


########### max_depth=8


# In[70]:


cart8 = DecisionTreeClassifier(criterion = "gini", max_depth=8).fit(x_train,y_train)


# In[71]:


y_pred_8 = cart8.predict(x_test)


# In[72]:


print(confusion_matrix(y_test, y_pred_8))
print(classification_report(y_test, y_pred_8))


# In[73]:


########### max_depth=9


# In[74]:


cart9 = DecisionTreeClassifier(criterion = "gini", max_depth=9).fit(x_train,y_train)


# In[75]:


y_pred_9 = cart9.predict(x_test)


# In[76]:


print(confusion_matrix(y_test, y_pred_9))
print(classification_report(y_test, y_pred_9))


# In[77]:


########### max_depth=auto


# In[78]:


cart10 = DecisionTreeClassifier(criterion = "gini").fit(x_train,y_train)


# In[79]:


y_pred_10 = cart9.predict(x_test)


# In[80]:


print(confusion_matrix(y_test, y_pred_10))
print(classification_report(y_test, y_pred_10))


# In[81]:


fig, axes = plt.subplots(1, 1, figsize=(15, 15))
tree.plot_tree(cart10, ax=axes);


# In[82]:


## part h:


# In[83]:


print(cart.feature_importances_)


# In[84]:


feat_importances = pd.Series(cart.feature_importances_, index=x_train.columns)
feat_importances.nlargest(10).plot(kind='barh')
plt.show()


# In[85]:


## part i:


# In[86]:


from sklearn.datasets import load_iris


# In[87]:


iris = load_iris()


# In[88]:


clf = cart9.fit(iris.data, iris.target)


# In[89]:


dot_file = open("Desktop/dot_file.dot", 'w')
tree.export_graphviz(clf, out_file = dot_file)
dot_file.close()
dot_file


# In[90]:


## part j:


# In[91]:


pip install pydotplus


# In[92]:


from IPython.display import Image
from sklearn.tree import export_graphviz
from pydotplus import graph_from_dot_data


# In[98]:


conda install python-graphviz


# In[101]:


from graphviz import Source


# In[103]:


import os
os.environ['PATH'] = os.environ['PATH']+';'+os.environ['CONDA_PREFIX']+r"\Library\bin\graphviz"


# In[104]:


Source.from_file("Desktop/dot_file.dot")

