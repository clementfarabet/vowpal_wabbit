COMPILER = g++
LIBS = -l boost_program_options -l pthread -l z

ARCH = $(shell test `g++ -v 2>&1 | tail -1 | cut -d ' ' -f 3 | cut -d '.' -f 1,2` \< 4.3 && echo -march=nocona || echo -march=native)

BOOST_INCLUDE = /usr/include
BOOST_LIBRARY = /usr/local/lib

OPTIM_FLAGS = -O3 -fomit-frame-pointer -ffast-math -fno-strict-aliasing
WARN_FLAGS = -Wall -pedantic #-Werror 

FLAGS = $(ARCH) $(WARN_FLAGS) $(OPTIM_FLAGS) -D_FILE_OFFSET_BITS=64 -I $(BOOST_INCLUDE) #-DVW_LDA_NO_SSE

all:	spanning_tree

%.o:	 %.cc  %.h
	$(COMPILER) $(FLAGS) -c $< -o $@

%.o:	 %.cc
	$(COMPILER) $(FLAGS) -c $< -o $@

spanning_tree: spanning_tree.o
	$(COMPILER) $(FLAGS) -o $@ $+ 

install: spanning_tree
	cp spanning_tree /usr/local/bin/allreduce

clean:
	rm -f  *.o $(BINARIES) *~ $(MANPAGES)
