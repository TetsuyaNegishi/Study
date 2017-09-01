mycalc: y.tab.c lex.yy.c
	cc -o mycalc y.tab.c lex.yy.c

y.tab.c: mycalc.y
	yacc -dv mycalc.y

lex.yy.c: mycalc.l
	lex mycalc.l

clean:
	rm -f lex.yy.c y.* mycalc
