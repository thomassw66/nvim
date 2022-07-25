#!/usr/bin/python3

import sys
import random
import math


# good tool to visualize at https://csacademy.com/app/graph_editor/
# Generates objects for testing.
class Generator:

    def undirected_graph(self, num_vertices, num_edges):
        # generate a random graph with N vertices and M edges.
        # shuffling the edges and choosing the first K has the
        # effect of simulating an N choose K sample.
        edges = []
        for i in range(N):
            for j in range(i + 1, N):
                edges += [(i + 1, j + 1)]

        random.shuffle(edges)
        #for i in range(M):
        #    a, b = elements[i]
        #    print("{} {}".format(a, b))
        return edges[0:M]

    # Source: https://arxiv.org/pdf/1202.6590.pdf
    # Roughly O(N ** 5) so avoid N > 100
    # Slow but samples uniformly among the space of all directed graphs.
    def directed_acyclic_graph(self, num_vertices):
        N = num_vertices

        # precompute binomial coefficients
        nCr = [[0] * (N + 1) for i in range(N + 1)]
        for i in range(N + 1):
            for j in range(i + 1):
                if i == 0 or j == i:
                    nCr[i][j] = 1
                else:
                    nCr[i][j] = nCr[i - 1][j - 1] + nCr[i - 1][j]

        # a_nk = the number of directed acyclic graphs with  n vertices and k end nodes
        b_nk = [[0] * (N + 1) for i in range(N + 1)]
        a_nk = [[0] * (N + 1) for i in range(N + 1)]
        a_n = [0] * (N + 1)

        a_n[0] = 1
        a_nk[0][0] = 1
        b_nk[0][0] = 1

        for n in range(1, N + 1):
            if n == 1:
                a_nk[n][0] = 1
            for k in range(1, n):
                b_nk[n][k] = sum([
                    ((2**k - 1)**s) * (2**(k * (n - k - s))) * a_nk[n - k][s]
                    for s in range(1, n - k + 1)
                ])
                a_nk[n][k] = nCr[n][k] * b_nk[n][k]
            a_nk[n][n] = 1
            b_nk[n][n] = 1
            a_n[n] = sum([a_nk[n][k] for k in range(1, n + 1)])

        # verify this matches https://oeis.org/A003024
        # print("a_n = {}".format(a_n))

        n = N

        # sample a number between 1 and a_n[n]
        num_bits = int(math.ceil(math.log(a_n[n], 2)))
        r = 0
        while True:
            r = 1
            for j in range(1, num_bits + 1):
                r = r + 2**(j - 1) * random.randint(0, 1)

            # sample a number less than a_n, reject if greater.
            if r <= a_n[n]:
                break

        # sample the number of outpoints
        k = 1
        while r > a_nk[n][k]:
            r = r - a_nk[n][k]
            k = k + 1

        K = [k]
        r = r // nCr[n][k] + (0 if r % nCr[n][k] == 0 else 1)
        # r = int(math.ceil(r / nCr[n][k]))
        m = n - k
        while m > 0:
            s = 1
            t = (2**k - 1)**s * (2**(k * (m - s))) * a_nk[m][s]
            while r > t:
                r = r - t
                s += 1
                t = (2**k - 1)**s * (2**(k * (m - s))) * a_nk[m][s]

            denom = (nCr[m][s] * (2**k - 1)**s * (2**(k * (m - s))))
            r = r // denom + (0 if r % denom == 0 else 1)
            #r = int(
            #    math.ceil(r / (nCr[m][s] * (2**k - 1)**s * (2**(k * (m - s))))))
            n = m
            k = s
            m = n - k
            K.append(k)

        # Q is the resulting adjacency matrix of the graph.
        Q = [[0
              for i in range(num_vertices + 1)]
             for j in range(num_vertices + 1)]

        I = len(K)
        j = K[I - 1]

        # print("n = {}".format(n))
        # print("K = {}".format(K))

        for i in range(I - 1, 0, -1):
            for l in range(j - K[i] + 1, j + 1):
                while True:
                    for m in range(j + 1, j + K[i - 1] + 1):
                        Q[m][l] = random.randint(0, 1)
                    if sum([Q[m][l] for m in range(j + 1, j + K[i - 1] + 1)
                           ]) > 0:
                        break
                for m in range(j + K[i - 1] + 1, n + 1):
                    Q[m][l] = random.randint(0, 1)
            j = j + K[i - 1]

        edges = []
        for i in range(1, len(Q)):
            for j in range(1, len(Q[i])):
                if Q[i][j]:
                    edges.append((i, j))

        perm = [i for i in range(1, num_vertices + 1)]
        random.shuffle(perm)

        permuted_edges = []
        for a, b in edges:
            if random.randint(0, 1) == 1:
                permuted_edges.append((perm[a - 1], perm[b - 1]))
            else:
                permuted_edges.append((perm[b - 1], perm[a - 1]))
        random.shuffle(permuted_edges)

        return edges


def generate_random_tree(V):
    edges = []
    for i in range(2, V + 1):
        # generate a random edge between { 1 .. i-1 } and i
        edges.append((random.randrange(1, i), i))

    perm = [i for i in range(1, V + 1)]

    random.shuffle(perm)
    random.shuffle(edges)

    shuffled_edges = []
    for a, b in edges:
        if random.randint(0, 1) == 1:
            shuffled_edges.append((perm[a - 1], perm[b - 1]))
        else:
            shuffled_edges.append((perm[b - 1], perm[a - 1]))

    return shuffled_edges


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


    g = Generator()
    edges = g.directed_acyclic_graph(N)
    # print("{} {}".format(N, len(edges)))
    for u, v in edges:
        print("{} {}".format(u, v))

    # print(generate_random_tree(N))
    """
    M = random.randrange(0, N * (N - 1) / 2)
    print("1")
    print("{} {}".format(N, M))

    # A
    A = [random.randrange(0, 10**4) for i in range(N)]
    print(" ".join(map(str, A)))

    # generate a random graph with N vertices and M edges.
    # shuffling the edges and choosing the first K has the
    # effect of simulating an N choose K sample.
    elements = []
    for i in range(N):
        for j in range(i + 1, N):
            elements += [(i + 1, j + 1)]

    #edges
    random.shuffle(elements)
    for i in range(M):
        a, b = elements[i]
        print("{} {}".format(a, b))
    """
