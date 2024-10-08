include "alldifferent.mzn";

int: N;
int: S = N * N;

array[1..N,1..N] of var 1..S: square;
int: all_sum = S*(S+1) div 2;
int: magic_sum = all_sum div N;

constraint alldifferent( [ square[i,j] | i in 1..N, j in 1..N ] );
constraint forall(i in 1..N)
                ( sum (j in 1..N)(square[i,j]) = magic_sum );
constraint forall(j in 1..N)
                ( sum (i in 1..N)(square[i,j]) = magic_sum );
constraint sum (i in 1..N)(square[i,i]) = magic_sum;
constraint sum (i in 1..N)(square[i,N-i+1]) = magic_sum;

solve satisfy;                

output  [ show(square[i,j]) ++ " " ++ 
         if j == N then
                "\n" else "" endif 
         | i,j in 1..N ];