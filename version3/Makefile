all: calc

calc: v3.tab.c lex.yy.c
	gcc v3.tab.c lex.yy.c -o calc -lfl

v3.tab.c v3.tab.h: v3.y
	bison -d v3.y

lex.yy.c: v3.l v3.tab.h
	flex v3.l

clean:
	rm -f v3.tab.c v3.tab.h lex.yy.c calc

test: calc
	./calc