import string

def is_pangram(sentence):
    alphabet = set(string.ascii_lowercase)
    letters = set(sentence.lower())
    return alphabet.issubset(letters)
