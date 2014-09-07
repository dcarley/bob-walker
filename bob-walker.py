#!/usr/bin/env python

import argparse
from random import randint


# How bob speaks depends on whether he is being drunk and/or random
# Given a word, we format bob's output according to inebriation and randomness
def bob_say(word, drunk, random):
    if random:
        slurring = 'e' * randint(1, 3)
        elongation = randint(1,3)
    else:
        slurring = 'eee'
        elongation = 3
    if drunk:
        shout = randint(1,10)
        slurred = word.replace('e', slurring) + word[len(word) - 1] * elongation
        if (shout > 9):
            print slurred.upper()
        else:
            print slurred
    else:
        print word


# We're going to tell bob to do something with command line options. This
# function asks him to listen to certain options, anything else will cause him
# to throw an exception and print out his help page.
def bob_heard():
    try:
        parser = argparse.ArgumentParser(
            description='bob walker emulation in Python')
        parser.add_argument('-a', '--all',
                            help='Everything but drunk and random',
                            default=False, action='store_true')
        parser.add_argument('-d', '--drunk', help='Slur the words a bit',
                            default=False, action='store_true')
        parser.add_argument('-p', '--programming', help='Talk programming!',
                            default=False, action='store_true')
        parser.add_argument('-r', '--random',
                            help='Be less consistent',
                            default=False, action='store_true')
        parser.add_argument('-s', '--sport', help='Talk sport', default=False,
                            action='store_true')
        parser.add_argument('-x', '--christmas', help='Christmas mode',
                            default=False, action='store_true')
        heard = parser.parse_args()
        if heard.all:
            heard.sport = True
            heard.programming = True
            heard.christmas = True
        return heard
    except:
        return None


# Depending on how bob is feeling and what he's heard us asking him to do, his
# vocabulary may change, so given a particular state of bob, return a list of
# all the words he might say.
def bob_vocabulary(bob):
    wordlist = ['beer', 'beard', 'pie']
    if bob.programming:
        wordlist.append('chef')
        wordlist.append('perl')
        wordlist.append('CPAN')
    if bob.sport:
        wordlist.append('cricket')
        wordlist.append('rugby')
    if bob.christmas:
        wordlist.append('mince pies')
        wordlist.append('reindeer')
    return wordlist


# Let's try to emulate a bob!
if __name__ == "__main__":
    try:
        bob = bob_heard()
        words = bob_vocabulary(bob)
        c = 0
        while c < 1000000:
            try:
                if bob.random:
                    word = words[randint(0, len(words))-1]
                else:
                    word = words[c % len(words)]
                bob_say(word, bob.drunk, bob.random)
                c += 1
            except KeyboardInterrupt:
                # It looks like you're giving up. That must mean it's PUB TIME!
                print 'PUB TIME!'
                break
    except Exception:
        # Something went wrong. We don't care what it is, beer will fix that.
        print ''
        print 'I think you might need another pint!'
