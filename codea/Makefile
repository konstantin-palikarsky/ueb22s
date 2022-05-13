all: compile


genhelp: gen_helpers.c gen_helpers.h
		gcc -g -c -pedantic -Wall gen_helpers.c

gentree: tree.c tree.h
		gcc -g -c -pedantic -Wall tree.c

bfe: genhelp gentree
		bfe < burm_code_gen.bfe | iburg > code_gen.c

symtab: symtab.c symtab.h
		gcc -g -c -pedantic -Wall symtab.c

ox:	parser.y tokscanner.l symtab
		ox parser.y tokscanner.l

scanner: ox
		flex oxout.l

parser: ox
		bison -d -v oxout.y

generator: bfe 
		gcc -g -c -pedantic -Wall code_gen.c

compile: scanner parser generator
		gcc -c lex.yy.c
		gcc -c oxout.tab.c

		gcc -g symtab.o oxout.tab.o lex.yy.o tree.o gen_helpers.o code_gen.o -ly -ll -o codea

clean:
		rm -f *.o lex.yy.c oxout* code_gen.* codea