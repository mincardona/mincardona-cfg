# compiler/linker executable
CC=gcc
# compiler flags
CFLAGS=-c -std=c99 -Wall -Wpedantic
# linker flags
LDFLAGS=
# header files (.h)
HEADERS=
# source files (.c)
SOURCES=
# object files (.o)
OBJECTS=$(SOURCES:.c=.o)
# output executable (with extension)
OUTFILE=

all: $(OUTFILE)

$(OUTFILE): $(OBJECTS) $(HEADERS)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@

%.o : %.c
	$(CC) $(CFLAGS) $< -o $@

%.h: ;

.PHONY : clean

clean :
	-rm $(OBJ)
