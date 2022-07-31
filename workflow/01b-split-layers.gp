# Split the full statewide layers into layers by water district:
# - read the input layers from GeoJSON so that there are no issues with coordinate reference system
#
# Make sure a folder exists for the processing.
CreateFolder(Folder="downloads/split",CreateParentFolders="True",IfFolderExists="Ignore")
# Read the statewide layers:
# - found that the downloaded layer had geometry errors so a copy that was fixed in QGIS with "Fix Geometries"
# ReadGeoLayerFromGeoJSON(InputFile="../data/co-isf-reaches.geojson",GeoLayerID="co-isf-reaches")
ReadGeoLayerFromGeoJSON(InputFile="results/co-isf-reaches-fixed.geojson",GeoLayerID="co-isf-reaches")
ReadGeoLayerFromGeoJSON(InputFile="../data/co-isf-reach-termini.geojson",GeoLayerID="co-isf-reach-termini")
ReadGeoLayerFromGeoJSON(InputFile="../data/co-natural-lakes.geojson",GeoLayerID="co-natural-lakes")
#
# Download and read the district boundaries.
WebGet(URL="https://data.openwaterfoundation.org/state/co/dwr/districts/co-dwr-district-3.geojson",OutputFile="downloads/split/co-dwr-district-3.geojson")
ReadGeoLayerFromGeoJSON(InputFile="downloads/split/co-dwr-district-3.geojson",GeoLayerID="district3")
#
# Download and read the division boundaries.
WebGet(URL="https://data.openwaterfoundation.org/state/co/dwr/divisions/co-dwr-division-1.geojson",OutputFile="downloads/split/co-dwr-division-1.geojson")
ReadGeoLayerFromGeoJSON(InputFile="downloads/split/co-dwr-division-1.geojson",GeoLayerID="division1")
#
# First split the main layers by division:
# - can do this since all features have division
# - can't split by district because features don't have a district (may or may not have WDID)
SplitGeoLayerByAttribute(InputGeoLayerID="co-isf-reaches",AttributeName="Division")
WriteGeoLayerToGeoJSON(GeoLayerID="co-isf-reaches_Division_1",OutputFile="../data/co-isf-reaches-division1.geojson")
WriteGeoLayerToGeoJSON(GeoLayerID="co-isf-reaches_Division_2",OutputFile="../data/co-isf-reaches-division2.geojson")
WriteGeoLayerToGeoJSON(GeoLayerID="co-isf-reaches_Division_3",OutputFile="../data/co-isf-reaches-division3.geojson")
WriteGeoLayerToGeoJSON(GeoLayerID="co-isf-reaches_Division_4",OutputFile="../data/co-isf-reaches-division4.geojson")
WriteGeoLayerToGeoJSON(GeoLayerID="co-isf-reaches_Division_5",OutputFile="../data/co-isf-reaches-division5.geojson")
WriteGeoLayerToGeoJSON(GeoLayerID="co-isf-reaches_Division_6",OutputFile="../data/co-isf-reaches-division6.geojson")
WriteGeoLayerToGeoJSON(GeoLayerID="co-isf-reaches_Division_7",OutputFile="../data/co-isf-reaches-division7.geojson")
#
# Split termini:
# - can't use split on termini because division is not an attribute
# - therefore must use intersect with the specific division
IntersectGeoLayer(GeoLayerID="co-isf-reach-termini",IntersectGeoLayerID="division1",OutputGeoLayerID="co-isf-reach-termini-division1")
WriteGeoLayerToGeoJSON(GeoLayerID="co-isf-reach-termini-division1",OutputFile="../data/co-isf-reach-termini-division1.geojson")
#
# Split natural lakes:
# - can't use split on termini because division is not an attribute
# - therefore must use intersect with the specific division
IntersectGeoLayer(GeoLayerID="co-natural-lakes",IntersectGeoLayerID="division1",OutputGeoLayerID="co-natural-lakes-division1")
WriteGeoLayerToGeoJSON(GeoLayerID="co-natural-lakes-division1",OutputFile="../data/co-natural-lakes-division1.geojson")
#
# Intersect the district with the instream flow features:
# - allow extending outside so that reaches are complete
# - TODO smalers 2022-07-29 need to figure out how to include termini that are outside of the basin
IntersectGeoLayer(GeoLayerID="co-isf-reaches",IntersectGeoLayerID="district3",OutputGeoLayerID="co-isf-reaches-district3")
WriteGeoLayerToGeoJSON(GeoLayerID="co-isf-reaches-district3",OutputFile="../data/co-isf-reaches-district3.geojson")
#
IntersectGeoLayer(GeoLayerID="co-isf-reach-termini",IntersectGeoLayerID="district3",OutputGeoLayerID="co-isf-reach-termini-district3")
WriteGeoLayerToGeoJSON(GeoLayerID="co-isf-reach-termini-district3",OutputFile="../data/co-isf-reach-termini-district3.geojson")
#
IntersectGeoLayer(GeoLayerID="co-natural-lakes",IntersectGeoLayerID="district3",OutputGeoLayerID="co-natural-lakes-district3")
WriteGeoLayerToGeoJSON(GeoLayerID="co-natural-lakes-district3",OutputFile="../data/co-natural-lakes-district3.geojson")