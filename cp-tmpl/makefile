CC=g++
OPTS=-std=c++17

main: main.cc 
	$(CC) $(OPTS) main.cc -o main

format: main.cc 
	clang-format -i -style=Google main.cc 
