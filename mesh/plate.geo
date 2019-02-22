lc = 0.1;	
mesh = lc/8; //lc/8 usually;   lc/X, where X is mesh number 
dimX = 1.0;				
//dimY = Sqrt(0.2);	
dimY = 1.0;
dimZ = lc/8; //mesh
rad = 0.1;

notch_width = 0.0;
notch_depth = 0.00;

Point(1) = {0, 0, 0, mesh};
Point(2) = {0, dimY, 0, mesh};
Point(3) = {dimX, dimY, 0, mesh};
Point(4) = {dimX, 0, 0, mesh};
Point(5) = {0, 0, dimZ, mesh};
Point(6) = {0, dimY, dimZ, mesh};
Point(7) = {dimX, dimY, dimZ, mesh};
Point(8) = {dimX, 0, dimZ, mesh};

Point(10) = {dimX/2, dimY/2, 0, mesh};
Point(11) = {dimX/2 + rad, dimY/2, 0, mesh};
Point(12) = {dimX/2, dimY/2 + rad, 0, mesh};
Point(13) = {dimX/2 - rad, dimY/2, 0, mesh};
Point(14) = {dimX/2, dimY/2 - rad, 0, mesh};
Point(110) = {dimX/2, dimY/2, dimZ, mesh};
Point(111) = {dimX/2 + rad, dimY/2, dimZ, mesh};
Point(112) = {dimX/2, dimY/2 + rad, dimZ, mesh};
Point(113) = {dimX/2 - rad, dimY/2, dimZ, mesh};
Point(114) = {dimX/2, dimY/2 - rad, dimZ, mesh};

Line(1) = {6, 5};
Line(2) = {5, 1};
Line(3) = {1, 2};
Line(4) = {2, 6};
Line(5) = {7, 8};
Line(6) = {8, 4};
Line(7) = {4, 3};
Line(8) = {3, 7};
Circle(9) = {11, 10, 12};
Circle(10) = {12, 10, 13};
Circle(11) = {13, 10, 14};
Circle(12) = {14, 10, 11};
Circle(59) = {111, 110, 112};
Circle(60) = {112, 110, 113};
Circle(61) = {113, 110, 114};
Circle(62) = {114, 110, 111};
Line (64) = {11, 111};
Line (65) = {12, 112};
Line (66) = {13, 113};
Line (67) = {14, 114};

Line Loop (63) = {59, 60, 61, 62};
Line Loop (64) = {9, 10, 11, 12};
//Plane Surface (65) = {63};
//Plane Surface (66) = {64};

Line Loop(68) = {66, -60, -65, 10};
Ruled Surface(69) = {68};
Line Loop(70) = {59, -65, -9, 64};
Ruled Surface(71) = {70};
Line Loop(72) = {12, 64, -62, -67};
Ruled Surface(73) = {72};
Line Loop(74) = {61, -67, -11, 66};
Ruled Surface(75) = {74};

Line Loop(13) = {3, 4, 1, 2};
Plane Surface(14) = {13};
Line Loop(15) = {7, 8, 5, 6};
Plane Surface(16) = {15};


Line(17) = {6, 7};
Line(18) = {8, 5};
Line(19) = {1, 4};
Line(20) = {3, 2};
Line Loop(21) = {18, -1, 17, 5};
//Plane Surface(22) = {21};
Line Loop(23) = {17, -8, 20, 4};
Plane Surface(24) = {23};
Line Loop(25) = {3, -20, -7, -19};
//Plane Surface(26) = {25};
Line Loop(27) = {18, 2, 19, -6};
Plane Surface(28) = {27};
//Surface Loop(29) = {22, 28, 14, 26, 24, 16};
Surface Loop(29) = {76, 28, 14, 77, 24, 16, 69, 71, 73, 75};

Plane Surface(76) = {21, 63};
Plane Surface(77) = {25, 64};

Volume(30) = {29};

/*
//this makes it XZ, without it, it's XY
Rotate {{1, 0, 0}, {0, 0, 0}, -Pi/2} {
  Surface{69, 71, 73, 75, 14, 16, 24, 28, 76, 77};
  Volume{30};
}
*/

Physical Volume(1) = {30};
Physical Surface(2) = {14};
Physical Surface(3) = {16};
Physical Surface(4) = {76};
Physical Surface(5) = {77};

Mesh.ElementOrder = 2; //quadratic Tet10 elements
Mesh.MshFileVersion = 1; //save as version 1 for eXlibris code
Mesh 2;
Mesh 3;
