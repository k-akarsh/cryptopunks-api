# frozen_string_literal: true

# To run this rake task: bundle exec rake imports:import_punk_listings

require './lib/ethereum_network/contracts/crypto_punks_market/base'

namespace :imports do
  desc 'import the punks listings avilable for sale from Ethereum network'
  task import_punk_listings: :environment do
    contract_instance = EthereumNetwork::Contracts::CryptoPunksMarket::Base.contract_instance
    punks_listings_logger = Logger.new("#{Rails.root}/log/punks_listings.log")

    punks = Punk.all
    punks.find_in_batches(batch_size: 10).each do |group|
      sleep(1)
      group.each do |punk|
        response = contract_instance.call.punks_offered_for_sale(punk.punk_identifier)
        punks_listings_logger.info("Punk listing info fetched for punk identifier #{punk.punk_identifier}: #{response}")
        for_sale = response[0]
        sale_price = response[3]
        import_punk_listing(punk.id, for_sale, sale_price.to_s)
      end
    end
  end

  def import_punk_listing(punk_id, for_sale, sale_price)
    punk_listing = PunkListing.find_by(punk_id: punk_id)
    if punk_listing
      punk_listing.update(for_sale: for_sale, sale_price: sale_price)
    else
      PunkListing.create(punk_id: punk_id, for_sale: for_sale, sale_price: sale_price)
    end
  end
end
