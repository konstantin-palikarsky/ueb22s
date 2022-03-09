all: compile

ox:	parser.y tokscanner.l
		ox parser.y tokscanner.l

scanner: ox
		flex oxout.l

parser: ox
		bison -d -v oxout.y

symtab: symtab.c
		gcc -g -c -pedantic -Wall symtab.c

compile: scanner parser symtab
		gcc -c lex.yy.c
		gcc -c oxout.tab.c

		gcc -g symtab.o oxout.tab.o lex.yy.o -ly -ll -o ag

clean:
		rm -f *.o lex.yy.c oxout* ag