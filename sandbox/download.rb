#############
#  download / cache opensea collection data via api
#  to run use:
#
#  $ ruby sandbox/download.rb


$LOAD_PATH.unshift( "../../pixelart/artbase/artbase-opensea/lib" )
require 'artbase-opensea'



def download( slugs, delay_in_s: 2 )

  cache_dir =  './cache'

slugs.each do |slug|

  puts
  puts "==> fetching #{slug}..."

  raw = Opensea.collection( slug )

  ## note: simplify result
  ##  remove nested 'collection' level

  data = raw['collection']

  ## remove editors  - do not care for now
  data.delete( 'editors' )


  path = "#{cache_dir}/#{slug}/collection.json"

  write_json( path, data )

  puts "  sleeping #{delay_in_s}s..."
  sleep( delay_in_s )
end
end


ethereum_slugs = [
  'cryptopunks',
  'official-v1-punks',
  'v3-cryptopunks',

  'philipinternproject',
  'crypto-phunks',
  'v1-phunks',
  'v3phunks',

  'galacticaliensocialclub',
  'thesaudis',
  'thejews-nft',
  'the-americans-nft',
  'phunksinblack',
]

more_ethereum_slugs = %w[
]

openstore_slugs = [
  'morepunks',    #
  'weape24',
]

more_openstore_slugs = %w[

]

more_slugs = %w[
  binaryapes

  anime-punks
  athletes-101
  basicboredapeclub
  beautiful-female-punks
  bladerunner-punks
  bwpunks
  cinepunkss
  wastelandpunks
  clout-punks
  cryptoapes-official
  cryptoluxurypunks
  dogepunks-collection
  dubaipeeps
  figurepunks
  frontphunks
  genius-punks
  ghozalipunk
  goodbye-punks
  high-effort-punks
  histopunks
  kimono-punks
  mafia-punks-club
  monkepunks
  onlypunksnft
  pixel-gals
  punkoftheday
  scifipunks
  the-pixel-portraits-og
  the-pixel-portraits
  thecryptogenius
  unofficialpunks
  wunks
  youtubepunks
]

slugs = ethereum_slugs +
        more_ethereum_slugs +
        openstore_slugs +
        more_openstore_slugs +
        more_slugs


pp slugs


download( slugs )


puts "bye"
