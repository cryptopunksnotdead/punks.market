#############
#  build report pages from (cached) datasets)
#  to run use:
#
#  $ ruby sandbox/reports.rb

$LOAD_PATH.unshift( "../../pixelart/artbase/artbase-opensea/lib" )
require 'artbase-opensea'



## get "canonical / single-source" punk collection slugs
##    from opensea.cache dataset for now

def read_punk_slugs( path )
  recs = read_csv( path )
  puts "  #{recs.size} collection(s)"

  recs = recs.select { |rec| tags = rec['tags']; tags && tags.index('punks') != nil }
  puts "  #{recs.size} collection(s) tagged punks"

  slugs = recs.map { |rec| rec['slug'] }
  slugs = slugs.sort    ## sort a-z

  # pp slugs
  slugs
end



slugs = read_punk_slugs( '../opensea.cache/collections.csv' )



cache_dirs = [
  '../opensea.cache/ethereum',
  '../opensea.cache/openstore'
]


## use select for select slugs to include
##  rename param to slugs? include? with? or such - why? why not?


report = Opensea::TimelineCollectionsReport.new( *cache_dirs,
               select: slugs  )
report.save( './TIMELINE.md' )



report = Opensea::TrendingCollectionsReport.new( *cache_dirs,
                  select: slugs  )
report.save( './TRENDING.md' )


report = Opensea::TopCollectionsReport.new( *cache_dirs,
                     select: slugs  )
report.save( './TOP.md' )


report = Opensea::CollectionsReport.new( *cache_dirs,
                         select: slugs  )
report.save( './COLLECTIONS.md' )


puts "bye"
