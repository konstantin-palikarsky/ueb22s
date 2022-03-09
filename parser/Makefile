all: combined

scanner: tokscanner.l
		flex tokscanner.l

parser: parser.y
		bison -d parser.y

combined: scanner parser
		gcc parser.tab.c lex.yy.c -o parser

clean:
		rm -f lex.yy.c parser.tab.* parser