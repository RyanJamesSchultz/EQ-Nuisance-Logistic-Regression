#!/bin/sh

# Requires the installation of the LibComCat Python library (https://doi.org/10.5066/P91WN1UQ).

# Predefine some variables.
LatU="38"
LatL="28"
LonU="-94"
LonL="-101"
st="2010-01-01"
et="2020-01-01"

# Define some dependent variables.
box="-b $LonL $LonU $LatL $LatU -s $st -e $et"

# Specify the comcat Python enviroment.
source /opt/anaconda3/bin/activate comcat

# Get the catalogue data.
getcsv IS.csv $box
getcsv IS_smap.csv -p shakemap $box
getcsv IS_dyfi.csv -p dyfi $box

# Get the ShakeMap and DYFI data.
getproduct shakemap "grid.xml" -d /Users/rjs10/Desktop/nuisance/data/ShakeMap/ $box
getproduct dyfi "cdi_zip.txt" -d /Users/rjs10/Desktop/nuisance/data/DYFI/ $box



