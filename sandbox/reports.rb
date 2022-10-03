#############
#  build report pages from (cached) datasets)
#  to run use:
#
#  $ ruby sandbox/reports.rb

$LOAD_PATH.unshift( "../../pixelart/artbase/artbase-opensea/lib" )
require 'artbase-opensea'



report = Opensea::TimelineCollectionsReport.new( './cache' )
report.save( './TIMELINE.md' )


report = Opensea::TrendingCollectionsReport.new( './cache' )
report.save( './TRENDING.md' )


report = Opensea::TopCollectionsReport.new( './cache' )
report.save( './TOP.md' )


report = Opensea::CollectionsReport.new( './cache' )
report.save( './COLLECTIONS.md' )


puts "bye"
