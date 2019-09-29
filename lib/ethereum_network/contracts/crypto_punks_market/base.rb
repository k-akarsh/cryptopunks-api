# frozen_string_literal: true

require './lib/ethereum_network/base'

module EthereumNetwork
  module Contracts
    module CryptoPunksMarket
      class Base
        ABI_FILE_PATH = './lib/ethereum_network/contracts/crypto_punks_market/CryptoPunksMarket.abi'
        class << self
          def contract_instance
            client = EthereumNetwork::Base.client
            name = Rails.application.credentials.config[:crypto_punks_market][:contract_name]
            address = Rails.application.credentials.config[:crypto_punks_market][:contract_address]
            begin
              abi_data = File.read(ABI_FILE_PATH)
            rescue Errno::ENOENT => exception
              warn "Caught exception: #{exception}"
              exit 1
            end
            abi_json = JSON.parse(abi_data).to_json
            Ethereum::Contract.create(client: client, name: name, address: address, abi: abi_json)
          end
        end
      end
    end
  end
end
