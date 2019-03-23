#!bash

source ~/.bash_profile
moose


exe=../modules/combined/combined-opt

#$exe --n-threads=4 -i andy_plate_mesh_dynVel_fracture_implicit-1_tet10.i 
#$exe --n-threads=4 -i andy_plate_mesh_dynVel_fracture_implicit-2.i 
#$exe --n-threads=8 -i andy_plate_mesh_dynVel_fracture_implicit-2_tet10.i 
#$exe --n-threads=6 -i andy_plate_mesh_dynVel_fracture_implicit-3.i 
#$exe --n-threads=6 -i andy_plate_mesh_dynVel_fracture_implicit-3_tighter.i 
#$exe --n-threads=6 -i andy_plate_mesh_dynVel_fracture_implicit-3_strainSpectral.i 
#$exe --n-threads=6 -i andy_plate_mesh_dynVel_fracture_implicit-3_strainSpectral_threshold.i 
#$exe --n-threads=8 -i andy_plate_mesh_dynVel_fracture_implicit-3_tet10.i 
$exe --n-threads=6 -i andy_plate_mesh_dynVel_fracture_implicit-3_tet10_strainSpectral_smallerLc.i 
#$exe --n-threads=6 -i andy_plate_mesh_dynVel_fracture_implicit-3_tet10_strainSpectral_threshold.i 
$exe --n-threads=6 -i andy_plate_mesh_dynVel_fracture_implicit-3_tet10_strainSpectral_threshold_smallerLc.i 
#$exe --n-threads=4 -i andy_plate_mesh_dynVel_fracture_implicit-4.i 
#$exe --n-threads=8 -i andy_plate_mesh_dynVel_fracture_implicit-8.i 
#$exe --n-threads=8 -i andy_plate_mesh_dynVel_fracture_implicit-8_strainSpectral_threshold.i 
#$exe --n-threads=12 -i andy_plate_mesh_dynVel_fracture_implicit-8_tet10.i 
#$exe --n-threads=12 -i andy_plate_mesh_dynVel_fracture_implicit-8_tet10_strainSpectral_threshold.i 
#$exe --n-threads=1 -i andy_truss.i 
#$exe --n-threads=1 -i andy_truss_indeterminate.i 

#$exe --n-threads=1 -i j2plasticity_better.i 
