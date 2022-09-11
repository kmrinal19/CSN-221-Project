CXX := g++
CXXFLAGS := -g -Wall
SRCDIR := src
BUILDDIR := build
TARGET := bin/parser

OBJECTS = $(BUILDDIR)/instruction.o $(BUILDDIR)/parser.o $(BUILDDIR)/parser.o

$(TARGET): $(OBJECTS)
	$(CXX) -o $(TARGET) $(OBJECTS)

$(BUILDDIR)/instruction.o: $(SRCDIR)/instruction.cpp $(SRCDIR)/instruction.h $(SRCDIR)/utils.h
	$(CXX) $(CXXFLAGS) -c -o $(BUILDDIR)/instruction.o $(SRCDIR)/instruction.cpp

$(BUILDDIR)/parser.o: $(SRCDIR)/parser.cpp $(SRCDIR)/instruction.h $(SRCDIR)/utils.h
	$(CXX) $(CXXFLAGS) -c -o $(BUILDDIR)/parser.o $(SRCDIR)/parser.cpp

$(BUILDDIR)/utils.o: $(SRCDIR)/utils.cpp $(SRCDIR)/instruction.h $(SRCDIR)/utils.h
	$(CXX) $(CXXFLAGS) -c -o $(BUILDDIR)/utils.o $(SRCDIR)/utils.cpp

.PHONY : clean
clean :
	rm edit $(OBJECTS)

