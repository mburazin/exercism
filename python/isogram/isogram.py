def is_isogram(string):
    used = set()
    for ch in string.lower():
        if ch in used:
            return False
        if ch.isalpha():
            used.add(ch)
    return True
