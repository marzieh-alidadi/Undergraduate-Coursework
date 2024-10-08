#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np


# In[2]:


## part a:


# In[3]:


fl = pd.read_csv("Desktop/Flower.csv")


# In[4]:


df = pd.DataFrame(fl);
df


# In[5]:


## part b:


# In[6]:


## checking missing values:


# In[7]:


df.info()


# In[8]:


## normalizing integer values:


# In[9]:


from sklearn import preprocessing


# In[10]:


df_scaleN = preprocessing.normalize(df[['X1', 'X2']])
df_scaleN = pd.DataFrame(df_scaleN);
df_scaleN['Class'] = df['Class']
df_scaleN.columns = ['X1', 'X2', 'Class']
df_ready = df_scaleN
df_ready


# In[11]:


## part c:


# In[38]:


import seaborn as sns
import matplotlib.pyplot as plt


# In[13]:


sns.catplot(x="Class", y="X1", data=df_scaleN)


# In[39]:


plt.scatter(df_ready.Class, df_ready.X1, c ="blue")
plt.show()


# In[14]:


sns.catplot(x="Class", y="X2", data=df_scaleN)


# In[37]:


plt.scatter(df_ready.Class, df_ready.X2, c ="blue")
plt.show()


# In[15]:


## part d:


# In[16]:


y = df_ready['Class']


# In[18]:


x = df_ready.drop(['Class'], axis=1)


# In[19]:


## part e:


# In[20]:


from sklearn.model_selection import train_test_split


# In[25]:


X_train, X_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=2)


# In[26]:


y_train.value_counts()


# In[27]:


y_test.value_counts()


# In[28]:


## part f:


# In[29]:


from sklearn.neural_network import MLPClassifier
mlp = MLPClassifier(hidden_layer_sizes=(10, 10, 10), max_iter=1000)
mlp.fit(X_train, y_train)


# In[30]:


## part g:


# In[31]:


predictions = mlp.predict(X_test)


# In[32]:


from sklearn.metrics import classification_report, confusion_matrix
print(confusion_matrix(y_test,predictions))
print(classification_report(y_test,predictions))


# In[33]:


## part h:


# In[56]:


def plot_prediction(model, X, y):
    x_min, x_max = X.T.iloc[0, :].min() - 1, X.T.iloc[0, :].max() + 1
    y_min, y_max = X.T.iloc[1, :].min() - 1, X.T.iloc[1, :].max() + 1
    h = 0.01

    xx, yy = np.meshgrid(np.arange(x_min, x_max, h), np.arange(y_min, y_max, h))

    Z = model(np.c_[xx.ravel(), yy.ravel()])
    Z = Z.reshape(xx.shape)

    plt.contourf(xx, yy, Z, cmap=plt.cm.Spectral)
    plt.ylabel('X1')
    plt.xlabel('X2')
    plt.scatter(X.T.iloc[0, :], X.T.iloc[1, :], c=y.iloc[:], cmap=plt.cm.Spectral)


# In[58]:


plot_prediction(lambda x: mlp.predict(x), X_train, y_train)


# In[59]:


## part i:


# In[129]:


mlp1 = MLPClassifier(hidden_layer_sizes=(20, 20, 20), max_iter=1000)
mlp1.fit(X_train, y_train)
predictions1 = mlp1.predict(X_test)
print(confusion_matrix(y_test,predictions1))
print(classification_report(y_test,predictions1))


# In[130]:


mlp2 = MLPClassifier(hidden_layer_sizes=(10, 10, 10, 10, 10), max_iter=1000)
mlp2.fit(X_train, y_train)
predictions2 = mlp2.predict(X_test)
print(confusion_matrix(y_test,predictions2))
print(classification_report(y_test,predictions2))


# In[131]:


mlp3 = MLPClassifier(hidden_layer_sizes=(10, 10, 10), max_iter=2000)
mlp3.fit(X_train, y_train)
predictions3 = mlp3.predict(X_test)
print(confusion_matrix(y_test,predictions3))
print(classification_report(y_test,predictions3))


# In[132]:


mlp4 = MLPClassifier(hidden_layer_sizes=(10, 10, 10), max_iter=2500)
mlp4.fit(X_train, y_train)
predictions4 = mlp4.predict(X_test)
print(confusion_matrix(y_test,predictions4))
print(classification_report(y_test,predictions4))


# In[133]:


mlp5 = MLPClassifier(hidden_layer_sizes=(8, 8, 8), max_iter=1000)
mlp5.fit(X_train, y_train)
predictions5 = mlp5.predict(X_test)
print(confusion_matrix(y_test,predictions5))
print(classification_report(y_test,predictions5))


# In[134]:


mlp6 = MLPClassifier(hidden_layer_sizes=(8, 8, 8, 8), max_iter=1000)
mlp6.fit(X_train, y_train)
predictions6 = mlp6.predict(X_test)
print(confusion_matrix(y_test,predictions6))
print(classification_report(y_test,predictions6))


# In[135]:


mlp7 = MLPClassifier(hidden_layer_sizes=(8, 8, 8, 8), max_iter=2000, activation='tanh')
mlp7.fit(X_train, y_train)
predictions7 = mlp7.predict(X_test)
print(confusion_matrix(y_test,predictions7))
print(classification_report(y_test,predictions7))


# In[136]:


mlp8 = MLPClassifier(hidden_layer_sizes=(8, 8, 8, 8, 8), max_iter=2000, activation='identity')
mlp8.fit(X_train, y_train)
predictions8 = mlp8.predict(X_test)
print(confusion_matrix(y_test,predictions8))
print(classification_report(y_test,predictions8))


# In[137]:


mlp9 = MLPClassifier(hidden_layer_sizes=(8, 8, 8, 8), max_iter=2000, activation='logistic')
mlp9.fit(X_train, y_train)
predictions9 = mlp9.predict(X_test)
print(confusion_matrix(y_test,predictions9))
print(classification_report(y_test,predictions9))


# In[138]:


## the best:


# In[140]:


mlp10 = MLPClassifier(hidden_layer_sizes=(8, 8, 8, 8), max_iter=1300)
mlp10.fit(X_train, y_train)
predictions10 = mlp10.predict(X_test)
print(confusion_matrix(y_test,predictions10))
print(classification_report(y_test,predictions10))


# In[ ]:


## default:


# In[146]:


mlp11 = MLPClassifier()
mlp11.fit(X_train, y_train)
predictions11 = mlp11.predict(X_test)
print(confusion_matrix(y_test,predictions11))
print(classification_report(y_test,predictions11))


# In[147]:


## another way: (search)


# In[157]:


mlp12 = MLPClassifier(max_iter=1000)


# In[171]:


parameter_space = {
    'hidden_layer_sizes': [(50,50,50), (50,100,50), (100,)],
    'activation': ['tanh', 'relu']
}


# In[172]:


from sklearn.model_selection import GridSearchCV

clf = GridSearchCV(mlp12, parameter_space, n_jobs=-1, cv=3)
clf.fit(X_train, y_train)


# In[173]:


# Best paramete set
print('Best parameters found:\n', clf.best_params_)

# All results
means = clf.cv_results_['mean_test_score']
stds = clf.cv_results_['std_test_score']
for mean, std, params in zip(means, stds, clf.cv_results_['params']):
    print("%0.3f (+/-%0.03f) for %r" % (mean, std * 2, params))


# In[174]:


y_true, y_pred = y_test , clf.predict(X_test)

from sklearn.metrics import classification_report
print('Results on the test set:')
print(classification_report(y_true, y_pred))


# In[175]:


##with bigger iteration:


# In[176]:


mlp13 = MLPClassifier(max_iter=2000)


# In[177]:


clf2 = GridSearchCV(mlp13, parameter_space, n_jobs=-1, cv=3)
clf2.fit(X_train, y_train)


# In[178]:


# Best paramete set
print('Best parameters found:\n', clf2.best_params_)

# All results
means2 = clf2.cv_results_['mean_test_score']
stds2 = clf2.cv_results_['std_test_score']
for mean2, std2, params2 in zip(means2, stds2, clf2.cv_results_['params']):
    print("%0.3f (+/-%0.03f) for %r" % (mean2, std2 * 2, params2))


# In[179]:


y_true2, y_pred2 = y_test , clf2.predict(X_test)

print('Results on the test set:')
print(classification_report(y_true2, y_pred2))

