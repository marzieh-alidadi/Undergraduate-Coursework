#!/usr/bin/env python
# coding: utf-8

# In[30]:


## part a:


# In[31]:


# I have installed it before, with this command:
#conda install mlxtend --channel conda-forge


# In[32]:


import pandas as pd
from mlxtend.frequent_patterns import apriori
from mlxtend.frequent_patterns import association_rules
from mlxtend import preprocessing


# In[33]:


## part b:


# In[34]:


bs=pd.read_csv('Desktop/Basket.csv',names=['item_set'],delimiter=';')
bs


# In[35]:


bs['item_set']=bs['item_set'].str.replace(',', ' ')
bs


# In[36]:


df = pd.DataFrame(bs)
df


# In[37]:


item_list = []
for num in range(0, len(df.index)-1):
    tmp_df = df.loc[df.index == num]
    tmp_items = tmp_df.item_set.tolist()
    item_list.append(tmp_items)

print(item_list[1:3])


# In[38]:


online_encoder = preprocessing.TransactionEncoder()
online_encoder_array = online_encoder.fit_transform(item_list)


# In[39]:


online_encoder_df = pd.DataFrame(online_encoder_array, columns=online_encoder.columns_)
online_encoder_df


# In[40]:


## part c:


# In[41]:


frequent_itemsets = apriori(online_encoder_df, min_support=0.1, use_colnames=False)
frequent_itemsets


# In[42]:


## part d:


# In[43]:


pip install pyfpgrowth


# In[44]:


import pyfpgrowth


# In[ ]:


patterns = pyfpgrowth.find_frequent_patterns(online_encoder_df,0.1)


# In[39]:


## part e:


# In[ ]:


rules = association_rules(frequent_itemsets, metric="lift", min_threshold=1)
rules

