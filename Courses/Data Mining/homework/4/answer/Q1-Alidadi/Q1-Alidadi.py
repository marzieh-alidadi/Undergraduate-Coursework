#!/usr/bin/env python
# coding: utf-8

# In[22]:


import pandas as pd
import numpy as np


# In[23]:


## part a:


# In[24]:


vc = pd.read_csv("Desktop/Vehicle.csv")


# In[25]:


df = pd.DataFrame(vc);
df


# In[37]:


## part b:


# In[38]:


## checking missing values:


# In[39]:


df.info()


# In[41]:


## normalizing integer values:


# In[42]:


from sklearn import preprocessing


# In[53]:


df_scaleN = preprocessing.normalize(df[['COMPACTNESS', 'CIRCULARITY', 'DISTANCE_CIRCULARITY', 'RADIUS_RATIO', 'PR.AXIS_ASPECT_RATIO', 'MAX.LENGTH_ASPECT_RATIO', 'SCATTER_RATIO', 'ELONGATEDNESS', 'PR.AXIS_RECTANGULARITY', 'MAX.LENGTH_RECTANGULARITY', 'SCALED_VARIANCE_MAJOR', 'SCALED_VARIANCE_MINOR', 'SCALED_RADIUS_OF_GYRATION', 'SKEWNESS_ABOUT_MAJOR', 'SKEWNESS_ABOUT_MINOR', 'KURTOSIS_ABOUT_MAJOR', 'KURTOSIS_ABOUT_MINOR', 'HOLLOWS_RATIO']])
df_scaleN = pd.DataFrame(df_scaleN);
df_scaleN['Class'] = df['Class']
df_scaleN.columns = ['COMPACTNESS', 'CIRCULARITY', 'DISTANCE_CIRCULARITY', 'RADIUS_RATIO', 'PR.AXIS_ASPECT_RATIO', 'MAX.LENGTH_ASPECT_RATIO', 'SCATTER_RATIO', 'ELONGATEDNESS', 'PR.AXIS_RECTANGULARITY', 'MAX.LENGTH_RECTANGULARITY', 'SCALED_VARIANCE_MAJOR', 'SCALED_VARIANCE_MINOR', 'SCALED_RADIUS_OF_GYRATION', 'SKEWNESS_ABOUT_MAJOR', 'SKEWNESS_ABOUT_MINOR', 'KURTOSIS_ABOUT_MAJOR', 'KURTOSIS_ABOUT_MINOR', 'HOLLOWS_RATIO', 'Class'] 
df_scaleN


# In[54]:


## encoding categorical variable:


# In[55]:


from sklearn.preprocessing import OrdinalEncoder


# In[56]:


encoder = OrdinalEncoder()


# In[58]:


df_ready['Class'] = encoder.fit_transform(df_scaleN[['Class']])
df_ready[['COMPACTNESS', 'CIRCULARITY', 'DISTANCE_CIRCULARITY', 'RADIUS_RATIO', 'PR.AXIS_ASPECT_RATIO', 'MAX.LENGTH_ASPECT_RATIO', 'SCATTER_RATIO', 'ELONGATEDNESS', 'PR.AXIS_RECTANGULARITY', 'MAX.LENGTH_RECTANGULARITY', 'SCALED_VARIANCE_MAJOR', 'SCALED_VARIANCE_MINOR', 'SCALED_RADIUS_OF_GYRATION', 'SKEWNESS_ABOUT_MAJOR', 'SKEWNESS_ABOUT_MINOR', 'KURTOSIS_ABOUT_MAJOR', 'KURTOSIS_ABOUT_MINOR', 'HOLLOWS_RATIO']] = df_scaleN[['COMPACTNESS', 'CIRCULARITY', 'DISTANCE_CIRCULARITY', 'RADIUS_RATIO', 'PR.AXIS_ASPECT_RATIO', 'MAX.LENGTH_ASPECT_RATIO', 'SCATTER_RATIO', 'ELONGATEDNESS', 'PR.AXIS_RECTANGULARITY', 'MAX.LENGTH_RECTANGULARITY', 'SCALED_VARIANCE_MAJOR', 'SCALED_VARIANCE_MINOR', 'SCALED_RADIUS_OF_GYRATION', 'SKEWNESS_ABOUT_MAJOR', 'SKEWNESS_ABOUT_MINOR', 'KURTOSIS_ABOUT_MAJOR', 'KURTOSIS_ABOUT_MINOR', 'HOLLOWS_RATIO']]
df_ready = pd.DataFrame(df_ready);
df_ready.columns = ['COMPACTNESS', 'CIRCULARITY', 'DISTANCE_CIRCULARITY', 'RADIUS_RATIO', 'PR.AXIS_ASPECT_RATIO', 'MAX.LENGTH_ASPECT_RATIO', 'SCATTER_RATIO', 'ELONGATEDNESS', 'PR.AXIS_RECTANGULARITY', 'MAX.LENGTH_RECTANGULARITY', 'SCALED_VARIANCE_MAJOR', 'SCALED_VARIANCE_MINOR', 'SCALED_RADIUS_OF_GYRATION', 'SKEWNESS_ABOUT_MAJOR', 'SKEWNESS_ABOUT_MINOR', 'KURTOSIS_ABOUT_MAJOR', 'KURTOSIS_ABOUT_MINOR', 'HOLLOWS_RATIO', 'Class'] 
df_ready


# In[59]:


## part c:


# In[60]:


import seaborn as sns


# In[62]:


df_ready.corr()


# In[61]:


sns.heatmap(df_ready.corr());


# In[63]:


## part d:


# In[64]:


y = df_ready['Class']


# In[69]:


x = df_ready.drop(['Class'], axis=1)


# In[70]:


## part e:


# In[71]:


from sklearn.model_selection import train_test_split


# In[72]:


x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=2)


# In[76]:


y_train.value_counts()


# In[77]:


y_test.value_counts()


# In[78]:


## part f:


# In[80]:


import statsmodels.tools.tools as stattools
from sklearn.tree import DecisionTreeClassifier, export_graphviz


# In[81]:


c50_01 = DecisionTreeClassifier(criterion="entropy", max_leaf_nodes=6).fit(x_train,y_train)


# In[82]:


from sklearn import tree


# In[83]:


tree.plot_tree(c50_01);


# In[84]:


import matplotlib.pyplot as plt


# In[85]:


fig, axes = plt.subplots(1, 1, figsize=(15, 15))
tree.plot_tree(c50_01, ax=axes);


# In[86]:


## part g:


# In[87]:


y_pred = c50_01.predict(x_test)


# In[88]:


from sklearn.metrics import classification_report, confusion_matrix


# In[89]:


print(confusion_matrix(y_test, y_pred))


# In[91]:


print(classification_report(y_test, y_pred))


# In[93]:


## part i:


# In[94]:


from sklearn.datasets import load_iris


# In[97]:


iris = load_iris()


# In[98]:


clf = c50_01.fit(iris.data, iris.target)


# In[99]:


dot_file = open("Desktop/dot_file.dot", 'w')
tree.export_graphviz(clf, out_file = dot_file)
dot_file.close()
dot_file


# In[101]:


from IPython.display import Image
from sklearn.tree import export_graphviz
from pydotplus import graph_from_dot_data
from graphviz import Source


# In[102]:


Source.from_file("Desktop/dot_file.dot")

