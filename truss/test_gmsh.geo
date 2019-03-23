Point(1) = {0, 0, 0, 1.0};
Point(2) = {1, 0, 0, 1.0};
Point(3) = {0, 1, 0, 1.0};
Point(4) = {0, 0, 1, 1.0};
Line(1) = {3, 1};
Line(2) = {1, 4};
Line(3) = {1, 2};
Line(4) = {2, 3};
Line(5) = {3, 4};
Line(6) = {4, 2};
Physical Point(1001) = {1};
Physical Point(1002) = {2};
Physical Point(1003) = {3};
Physical Point(1004) = {4};

Physical Line(1000) = {1:6};

Transfinite Line{1:6} = 2;

Mesh 1;
