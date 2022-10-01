#############
#  build report pages from (cached) datasets)
#  to run use:
#
#  $ ruby sandbox/reports.rb

$LOAD_PATH.unshift( "../../pixelart/artbase/artbase-opensea/lib" )
require 'artbase-opensea'


report = Opensea::TrendingCollectionsReport.new
buf = report.build( './cache' )
write_text( "./TRENDING.md", buf )


report = Opensea::TopCollectionsReport.new
buf = report.build( './cache' )
write_text( "./TOP.md", buf )


report = Opensea::CollectionsReport.new
buf = report.build( './cache' )
write_text( "./COLLECTIONS.md", buf )


puts "bye"
