#############
#  download / cache opensea collection data via api
#  to run use:
#
#  $ ruby sandbox/download.rb


$LOAD_PATH.unshift( "../../pixelart/artbase/artbase-opensea/lib" )
require 'artbase-opensea'




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

   'crypto-marcs',
  'punked-goblins',
  'punk-ape-yacht-club-v2',
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




# slugs = %w[
# ]


cache = OpenSea::Cache.new( './cache' )
cache.download( slugs )


puts "bye"
