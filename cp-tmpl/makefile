CC=g++
OPTS=-std=c++17

OPTS=-g -std=c++17 -Wall -Wextra -Wformat=2 -Wfloat-equal \
		 -Wshadow -Wno-unused-parameter -fsanitize=address,undefined

all: clean
all: main

main: main.cc 
	$(CC) $(OPTS) $< -o $@

clean:
	$(RM) main 

.PHONY: clean all
