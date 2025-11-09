CXX := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -pedantic

.PHONY: all clean

all: clean app

app: main.o greeter.o
	$(CXX) $(CXXFLAGS) -o app main.o greeter.o

main.o: _src/main.cpp _inc/greeter.h
	$(CXX) $(CXXFLAGS) -I_inc -c _src/main.cpp -o main.o

greeter.o: _src/greeter.cpp _inc/greeter.h
	$(CXX) $(CXXFLAGS) -I_inc -c _src/greeter.cpp -o greeter.o

clean:
	@echo "Cleaning build artifacts..."
	rm -f app main.o greeter.o

