#!/usr/bin/env python
# coding: utf-8

# In[1]:


ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
SPECIAL_CHARS = " ,.-;:_?!="

def decrypt(cipher_text):
    key = find_key_from_cipher(cipher_text)
    plain_text = ""
    for letter in cipher_text:
        if letter in SPECIAL_CHARS:
            plain_text += letter
            continue
        index = ALPHABET.find(letter.upper())
        new_index = flatten(index - key)
        plain_text += ALPHABET[new_index]
    return plain_text

def flatten(number) :
    return number - (26*(number//26))

def find_key_from_cipher(cipher_text):
    index_of_most_common_letter = 0 #Index of 'e' then 'a' then 'r' , 'i' , ...
    distribution_dict = analyse_letter_distribution(cipher_text)
    common_letters = sorted(distribution_dict, key=distribution_dict.get, reverse=True)
    key = ALPHABET.find(common_letters[0].upper()) - index_of_most_common_letter
    return key

def analyse_letter_distribution(cipher_text):
    distribution_dict = {}
    for letter in cipher_text:
        if letter in SPECIAL_CHARS:
            continue
        if letter not in distribution_dict:
            distribution_dict[letter] = 1
        else:
            distribution_dict[letter] += 1
    if len(distribution_dict.values()) != len(distribution_dict.values()):
        print("Multiple letters appear the same amount of times! Uh oh.")
    return distribution_dict


# In[2]:


decrypt("KfpjSjykqncfuutsUqfdXytwjhfzlmymnofhpnslBmfyxFuuxjxxntsx")

