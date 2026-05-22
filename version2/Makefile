all: calc

calc: v2.tab.c lex.yy.c
	gcc v2.tab.c lex.yy.c -o calc -lfl

v2.tab.c v2.tab.h: v2.y
	bison -d v2.y

lex.yy.c: v2.l v2.tab.h
	flex v2.l

clean:
	rm -f v2.tab.c v2.tab.h lex.yy.c calc

test: calc
	echo "23 + 45 * (12 + 25)" > expression.txt
	./calc