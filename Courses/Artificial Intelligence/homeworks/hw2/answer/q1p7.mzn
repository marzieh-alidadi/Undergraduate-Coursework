%question 1 part 7
%In the description, A is shown by 1 - B is shown by 2 - C is shown by 3

var {3}: x1;
var {2,3}: x2;
var {1,2,3}: x3;
var {1,2,3}: x4;
var {2,3}: x5;

constraint x1 != x2;
constraint x2 != x3;
constraint x2 != x4;
constraint x3 != x5;
constraint x4 != x5;

solve satisfy;

output ["x1 = \(x1)\n",
        "x2 = \(x2)\n",
        "x3 = \(x3)\n",
        "x4 = \(x4)\n",
        "x5 = \(x5)\n"];