
SRCS = driver.cc lex.yy.c
BIN = 113451118.exe
CFLAGS = -O3 -I.
SCANNER = 113451118
#SCANNER = example-flex
FLEX = flex
CC = g++

all: scanner bin

bin: $(SRCS)
	$(CC) $(CFLAGS) -o $(BIN) $(SRCS) 

scanner: $(SCANNER).yy
	$(FLEX) $(SCANNER).yy

clean: 
	rm *.exe lex.yy.c *.o
