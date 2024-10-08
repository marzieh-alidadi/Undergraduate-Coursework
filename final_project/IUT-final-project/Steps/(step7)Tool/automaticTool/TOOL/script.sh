#!/bin/bash

Command=${1}

if [ $Command == "--run" ]
then
	echo "."
	flex Tool-first.l
	g++ lex.yy.c
	./a.out
	flex Tool-second.l
	g++ lex.yy.c
	./a.out
	echo "."
	flex Tool-third.l
	g++ lex.yy.c
	./a.out
	flex Tool-fourth.l
	g++ lex.yy.c
	./a.out
	echo "."
	flex Tool-fifth.l
	g++ lex.yy.c
	./a.out
	flex Tool-sixth.l
	g++ lex.yy.c
	echo "Compiling has finished and execution file is created"
	./a.out
	
elif [ $Command == "--remove" ]
then
	rm lex.yy.c a.out Result-first.pml Result-second.pml Result-third.pml Result-fourth.pml Result-fifth.pml Result-Functions-second.txt
	echo "All extra files removed :)"
else
	echo "Unkown command :| "
fi
