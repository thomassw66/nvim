#!/usr/bin/python3

import sys
import random
import math

if __name__ == "__main__":
    argc = len(sys.argv)

    if argc < 3:
        print("usage ./gen.py seed_value size")
        exit(1)

    seed = int(sys.argv[1])
    random.seed(seed)

    N = int(sys.argv[2])
    if N < 2:
        print("Need N >= 2")
        exit(1)

    T = 1
    print("{}".format(T))

