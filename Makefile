CXXFLAGS := -Wall -Wextra
LDFLAGS :=
BISONFLAGS :=

.PHONY: compile clean

run: build/cplusplus-parser
	./$< main.cpp

compile:
	build/cplusplus-parser

clean:
	-rm -r build

build:
	mkdir -p build

build/common.hpp: common.hpp
	cp $< $@

build/cplusplus-parser: build/cplusplus-parser.o build/cplusplus-lexer.o | build
	c++ $(LDFLAGS) -o $@ $^

build/cplusplus-parser.o: build/cplusplus-parser.cpp build/common.hpp | build
	c++ $(CXXFLAGS) -c -o $@ $<

build/cplusplus-parser.cpp: cplusplus-parser.ypp | build
	bison $(BISONFLAGS) -d -o $@ $<

build/cplusplus-lexer.o: build/cplusplus-lexer.cpp build/common.hpp | build
	cc $(CFLAGS) -c -o $@ $<

build/cplusplus-lexer.cpp: cplusplus-lexer.ypp | build
	flex -o $@ $<