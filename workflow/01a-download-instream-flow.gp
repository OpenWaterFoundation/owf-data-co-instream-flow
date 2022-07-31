# Download the current instream flow reaches and convert to GeoJSON:
# - this needs to be run daily since ISF reaches are published daily
# - save each file locally and then read and write to make sure GeoJSON file is saved as latest spec
CreateFolder(Folder="downloads/ISF_Reach",CreateParentFolders="True",IfFolderExists="Ignore")
CreateFolder(Folder="downloads/ISF_Termini",CreateParentFolders="True",IfFolderExists="Ignore")
CreateFolder(Folder="downloads/ISF_Lakes",CreateParentFolders="True",IfFolderExists="Ignore")
WebGet(URL="https://dnrftp.state.co.us/CDSS/GIS/ISF_Reach.zip",OutputFile="downloads/ISF_Reach/ISF_Reach.zip")
WebGet(URL="https://dnrftp.state.co.us/CDSS/GIS/ISF_Termini.zip",OutputFile="downloads/ISF_Termini/ISF_Termini.zip")
WebGet(URL="https://dnrftp.state.co.us/CDSS/GIS/ISF_Lakes.zip",OutputFile="downloads/ISF_Lakes/ISF_Lakes.zip")
# =====================================================
# Process each shapefile.
#
# ISF_Reach
# Unzip the shapefile.
UnzipFile(File="downloads/ISF_Reach/ISF_Reach.zip",OutputFolder="downloads/ISF_Reach",IfFolderDoesNotExist="Create")
# Read the file from 'downloads/' and then write to '../data'.
ReadGeoLayerFromShapefile(InputFile="downloads/ISF_Reach/ISF_Reach.shp",GeoLayerID="ISF_Reach",Name="Instream Flow Reaches",Description="Instream flow reaches")
# Write the file as GeoJSON.
WriteGeoLayerToGeoJSON(GeoLayerID="ISF_Reach",OutputFile="../data/co-isf-reaches.geojson")
#
# ISF_Termini
# Unzip the shapefile.
UnzipFile(File="downloads/ISF_Termini/ISF_Termini.zip",OutputFolder="downloads/ISF_Termini",IfFolderDoesNotExist="Create")
# Read the file from 'downloads/' and then write to '../data'.
ReadGeoLayerFromShapefile(InputFile="downloads/ISF_Termini/ISF_Termini.shp",GeoLayerID="ISF_Termini",Name="Instream Flow Termini",Description="Instream flow termini")
# Write the file as GeoJSON.
WriteGeoLayerToGeoJSON(GeoLayerID="ISF_Termini",OutputFile="../data/co-isf-reach-termini.geojson")
#
# ISF_Lakes
# Unzip the shapefile.
UnzipFile(File="downloads/ISF_Lakes/ISF_Lakes.zip",OutputFolder="downloads/ISF_Lakes",IfFolderDoesNotExist="Create")
# Read the file from 'downloads/' and then write to '../data'.
ReadGeoLayerFromShapefile(InputFile="downloads/ISF_Lakes/ISF_Lakes.shp",GeoLayerID="ISF_Lakes",Name="Natural Lake Levels",Description="Natural lake levels")
# Write the file as GeoJSON.
WriteGeoLayerToGeoJSON(GeoLayerID="ISF_Lakes",OutputFile="../data/co-natural-lakes.geojson")
