#############
#  to run use:
#
#  $ ruby sandbox-lost/query.rb



require 'ethlite'
require 'etherscan-lite'
require 'bytes'
require 'date'
require 'time'




module Alchemy
  class Configuration
    #######################
    ## accessors
    ##  todo/check - change to apikey or api_key or such - why? why not?
    def key()       @key ||= ENV['ALCHEMY_KEY']; end
    def key=(value) @key = value; end
  end # class Configuration

  ## lets you use
  ##   Alchemy.configure do |config|
  ##      config.key = 'xxxx'
  ##   end
  def self.configure() yield( config ); end
  def self.config()    @config ||= Configuration.new;  end


  BASE_NFT = 'https://eth-mainnet.g.alchemy.com/nft/v2/{key}'

  def self.owners_for_collection( contractaddress )
    query = BASE_NFT.sub( '{key}', config.key )
    query += "/getOwnersForCollection/"
    query += "?contractAddress=#{contractaddress}"

    call( query )
  end


  def self.call( src )
    res = Webclient.get(src )
    res.json
  end
end  # module Alchemy




PUNKS_ADDRESS = "0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb"



def update_owners
  data = Alchemy.owners_for_collection( PUNKS_ADDRESS )

  ownerAddresses = data['ownerAddresses']

  pp ownerAddresses
  puts "  #{ownerAddresses.size} address(es)"
  #=>   3585 address(es)

  write_json( "./sandbox-lost/owners.json", ownerAddresses )
end


ownerAddresses = read_json( "./sandbox-lost/owners.json" )
puts "  #{ownerAddresses.size} address(es)"



YEARS_DORMANT = 1





lostAddresses = %w[
  0x7174039818a41E1ae40FDcFA3E293b0f41592AF2
  0x7760E0243cA9BAA630412865DF7b39AfbA42Ff0f
  0xc8c115dcB2910eE8F3dbAC4056B5448C4f624bde
  0x09BdF0eFDfFDb841fAF667CBc4f9c9B09fd6b909
  0x8A873b31646dF1F4de3e28c2f608Bc37f21fE4D7
  0x96cdA18688cB93F0578CE9DFA35014c877624f1F
  0xDe03D31d4EAf058497C7B27CA74E8110014FbF6d
  0xe675218BbA7eC17b0E2231bcAcfe41C07667cbe8
  0x01c59869B44F3Fc5420dbB9166a735CdC020E9Ae
  0x03FbbFE27FAe9bd53dBc5B5c7fC0504c9B3DD0B1
  0x12945660aAaB3fB97F46E18fCee02959C2d13bc5
  0x147A3aaA88c451F97D95684aBFBCc846c22262Ab
  0x18F4F933F8773c5BfbDF1a675F5Fe667bc2020a1
  0x28c89718f4daB5Cf853E37e96735a3cAD85C41d5
  0x2a15cAfb85096027179B5568334a812b13BF268c
  0x4B674e70f6B36801d3bcA071628Cd6759dD3d039
  0x4Ef1aB9a3330C1d7d0A039CDC47eDEB41254E39e
  0x582b2164D8C0AD22E0777275d646F29FD18D27c4
  0x729FbdD2c5662FC11f62104D298BAf06a47b1245
  0x77F713b00cA5f1B258A47Be34d947ABE5617154b
  0x7C892fE9cD3545b2dD30C045555D82f3b76C839a
  0x871f66E0C9C77141d25FB52222AcE830B584F209
  0xbFc586A34128D14ECf29d1aAEB71E08AAE5827CC
  0xC52641D393C78Bc70C25a0ABc99B32A26f38D890
  0xF21E5f7B79FDC4E5695c7349eaFD5bD5981c68b7
  0xF7b33567153e20cDc811e0FE02bD37E0B6893688
  0xf892D9Fa129bD7abA89f29361Fe6C0e749F8935a
  0xFBb0658c4796f66e3376ea9E7CC200C428F217DD
]





inactive = []

delay_in_s = 0.5


# addresses = ownerAddresses[4..7]
addresses = lostAddresses

addresses.each_with_index do |address,i|
    puts "  sleeping #{delay_in_s}s..."
    sleep( delay_in_s )

    puts
    puts "==> [#{i}] query #{address}..."
    txns = Etherscan.txlist( address: address )

    # check for related addresses and
    #   internal transactions (e.g. transferPunk)
    if txns.size == 0
      puts "!! WARN - no txns found / returned for >#{address}<"
      # Check for internal transactions
      txns =  Etherscan.tokentx( address: address,
                                 contractaddress: PUNKS_ADDRESS )
    end

    puts "  #{txns.size} txn(s)"
    # note: timestamp is a string in json responspe
    timestamp = txns[0]['timeStamp'].to_i

    time_between = Time.now - Time.at( timestamp )
    time_between_in_days = time_between  / (60 * 60 * 24)
    puts "  #{time_between_in_days} day(s)  - #{Time.at( timestamp )}"

    if time_between_in_days > (YEARS_DORMANT * 365)
      inactive << address
      puts "!!  longer than #{YEARS_DORMANT} years for >#{address}<"
    end
end


##
#   todo/fix:
# ==> [8] query 0x01c59869B44F3Fc5420dbB9166a735CdC020E9Ae...
# [debug] GET /api?module=account&action=txlist&address=...
# 200 OK -  content_type: application/json, content_length: 172
# !! ETHERSCAN API ERROR:
# 0 No transactions found - []
#
#  - add 0 and No transactions found with result empty
#       as a successs!!!  do not exit!!!!



__END__


total_punks_lost = 0

ETH_NODE  = Ethlite.config.rpc
ETH_balanceOf  = Ethlite::ContractMethod.new( 'balanceOf',
                                             inputs: ['address'],
                                             outputs: ['uint256'] )


addresses = lostAddresses
addresses[0..2].each_with_index do |address,i|
  puts
  puts "==> [#{i}] query #{address}..."

  ## note: convert hex string to binary string (bytes20)
  address_bin = Bytes.hex_to_bin(address)
  punks_held = ETH_balanceOf.do_call( ETH_NODE,
                                      PUNKS_ADDRESS, [address_bin] )

  total_punks_lost += punks_held
  puts  "  #{address} holds #{punks_held}"
end

puts total_punks_lost



puts "bye"