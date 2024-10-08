var float: y1;
var float: y2;
var float: y3;
var float: y4;
var float: y5;
var float: y6;
var float: y7;
var float: y8;

constraint 5 * y2 + 4 * y3 - 3 * y4 + 3 * y6 + 3 * y7 <= y8;
constraint 5 * y1 - 4 * y2 + 3 * y3 - 2 * y4 - 4 * y5 - 5 * y6 <= y8;
constraint 5 * y1 - 5 * y2 - 5 * y3 - 1 * y4 + 2 * y5 + 1 * y6 + 2 * y7 <= y8;
constraint - 4 * y1 + 4 * y2 + 1 * y3 + 3 * y4 + 3 * y5 - 3 * y7 <= y8;
constraint y1 + y2 + y3 + y4 + y5 + y6 + y7 = 1;
constraint y1 >= 0;
constraint y2 >= 0;
constraint y3 >= 0;
constraint y4 >= 0;
constraint y5 >= 0;
constraint y6 >= 0;
constraint y7 >= 0;

solve minimize y8;
