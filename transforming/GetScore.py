#!/usr/bin/python

def GetScore(OutOfString):
    try:
        elem = [x for x in OutOfString.lower().split(' ') if x is not '']        
        if len(elem) != 4 or elem[1]+elem[2] != "outof":  #'out' not in elem or 'of' not in elem:
            return None
        return float(elem[0])/float(elem[-1])
    except:
        return None 
