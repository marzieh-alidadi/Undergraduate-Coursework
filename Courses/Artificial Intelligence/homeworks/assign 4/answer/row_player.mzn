var float: x1;
var float: x2;
var float: x3;
var float: x4;
var float: x5;

constraint 5 * x2 + 5 * x3 - 4 * x4 >= x5;
constraint 5 * x1 - 4 * x2 - 5 * x3 + 4 * x4 >= x5;
constraint 4 * x1 + 3 * x2 - 5 * x3 + 1 * x4 >= x5;
constraint - 3 * x1 - 2 * x2 - 1 * x3 + 3 * x4 >= x5;
constraint - 4 * x2 + 2 * x3 + 3 * x4 >= x5;
constraint 3 * x1 - 5 * x2 + 1 * x3 >= x5;
constraint 3 * x1 + 2 * x3 - 3 * x4 >= x5;
constraint x1 + x2 + x3 + x4 = 1;
constraint x1 >= 0;
constraint x2 >= 0;
constraint x3 >= 0;
constraint x4 >= 0;

solve maximize x5;
