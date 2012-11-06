all: exprtest

exprtest: exprtest.o driver.o parser.tab.o scanner.o
	g++ -Wall -g -o exprtest exprtest.o driver.o parser.tab.o scanner.o 
    
clean:
	rm exprtest driver.o exprtest.o parser.tab.o scanner.o location.hh parser.tab.cpp parser.tab.hpp position.hh scanner.cpp stack.hh
    
driver.o: driver.cpp scanner.hpp driver.hpp parser.tab.hpp
	g++ -c driver.cpp

scanner.o: scanner.cpp scanner.hpp
	g++ -c scanner.cpp

scanner.hpp: parser.tab.hpp

parser.tab.hpp: parser.ypp
	bison parser.ypp
    
parser.tab.o: expression.hpp scanner.hpp driver.hpp parser.tab.hpp parser.tab.cpp
	g++ -c parser.tab.cpp

parser.tab.cpp: parser.ypp
	bison parser.ypp
    
scanner.cpp: scanner.ll
	flex -t scanner.ll > scanner.cpp

exprtest.o: exprtest.cpp
	g++ -c exprtest.cpp
