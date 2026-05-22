all: calc

calc: v1.tab.c lex.yy.c
	gcc v1.tab.c lex.yy.c -o calc -lfl

v1.tab.c v1.tab.h: v1.y
	bison -d v1.y

lex.yy.c: v1.l v1.tab.h
	flex v1.l

clean:
	rm -f v1.tab.c v1.tab.h lex.yy.c calc

test: calc
	echo "23 + 45 * (12 + 25)" > expression.txt
	./calc