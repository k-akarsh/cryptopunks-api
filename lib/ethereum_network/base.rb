# frozen_string_literal: true

module EthereumNetwork
  class Base
    class << self
      def client
        begin
	  client = Ethereum::HttpClient.new(Rails.application.credentials.config[:provider_url])
        rescue URI::InvalidURIError => exception
          warn "Invalid Provider Url: #{exception}"
          exit 1
        end
	client.default_account = Rails.application.credentials.config[:ethereum_default_account]
	client
      end
    end
  end
end
