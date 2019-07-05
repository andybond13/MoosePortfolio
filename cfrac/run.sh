#!bash

source ~/.bash_profile
moose


exe=../../modules/combined/combined-opt

#$exe --n-threads=12 -i coarse_volDev_threshold.i
#$exe --n-threads=12 -i coarse_volDevSpectral_threshold.i
#$exe --n-threads=12 -i coarse_full_threshold.i
#$exe --n-threads=12 -i coarse_strainSpectral_threshold.i

#$exe --n-threads=12 -i coarse_thin_volDev_threshold.i
#$exe --n-threads=12 -i coarse_thin_volDevSpectral_threshold.i
#$exe --n-threads=12 -i coarse_thin_full_threshold.i
#$exe --n-threads=12 -i coarse_thin_strainSpectral_threshold.i

#$exe --n-threads=12 -i coarse_volDevSpectral_threshold_2d.i
#$exe --n-threads=12 -i medium_volDevSpectral_threshold_2d.i
#$exe --n-threads=12 -i fine_volDevSpectral_threshold_2d.i

#$exe --n-threads=12 -i coarse_volDevSpectral_threshold_2d_eta.i
#$exe --n-threads=12 -i medium_volDevSpectral_threshold_2d_eta.i
#$exe --n-threads=16 -i fine_volDevSpectral_threshold_2d_eta.i
#$exe --n-threads=12 -i coarse_volDevSpectral_threshold_2d_eta_250.i
#$exe --n-threads=12 -i medium_volDevSpectral_threshold_2d_eta_250.i
$exe --n-threads=16 -i fine_volDevSpectral_threshold_2d_eta_250.i

#$exe --n-threads=12 -i coarse_thin_volDevSpectral_threshold_2d.i
#$exe --n-threads=12 -i medium_thin_volDevSpectral_threshold_2d.i
#$exe --n-threads=12 -i fine_thin_volDevSpectral_threshold_2d.i
