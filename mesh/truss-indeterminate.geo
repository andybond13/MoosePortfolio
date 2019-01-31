mesh = 100.0;
Point(1) = {0, 0, 0, mesh};
Point(2) = {48, 0, 0, mesh};
Point(3) = {48, 36, 0, mesh};
Point(4) = {0, 36, 0, mesh};
Line(1) = {1, 2};
Line(2) = {1, 3};
Line(3) = {1, 4};
Line(4) = {2, 3};
Line(5) = {2, 4};
Line(6) = {3, 4};
//Physical Line(30) = {1, 2, 3, 4, 5, 6};
Physical Line(1) = {1};
Physical Line(2) = {2};
Physical Line(3) = {3};
Physical Line(4) = {4};
Physical Line(5) = {5};
Physical Line(6) = {6};
Physical Point(1) = {1};
Physical Point(2) = {2};
Physical Point(3) = {3};
Physical Point(4) = {4};

Mesh.Algorithm = 5;
Mesh.Algorithm3D = 4;
Mesh.MshFileVersion = 1; //save as version 1 for eXlibris code
Mesh 1;
//Mesh.SaveAll = 1;
