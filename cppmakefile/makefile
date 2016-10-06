# compiler/linker executable
CC=g++
# compiler flags
CFLAGS=-c -std=c++11 -Wall -Wpedantic -Wextra
# header files (.h, .hpp)
HEADERS=
# source files (.cpp)
SOURCES=
# object files (.o)
OBJECTS=$(SOURCES:.cpp=.o)
# linker flags
LDFLAGS=
# output file (with extension)
OUTFILE=

all: $(OUTFILE)

$(OUTFILE): $(OBJECTS) $(HEADERS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

%.o : %.cpp
	$(CC) $(CFLAGS) $< -o $@

%.h: ;

%.hpp: ;

.PHONY : clean

clean :
	-rm $(OBJ)
