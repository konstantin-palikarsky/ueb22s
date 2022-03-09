all: compile

lex: scanner.l
		flex scanner.l

compile: lex
		gcc lex.yy.c -o scanner -lfl 

clean:
	rm -f lex.yy.c scanner