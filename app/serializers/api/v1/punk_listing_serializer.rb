# frozen_string_literal: true
module Api
  module V1
    class PunkListingSerializer < ActiveModel::Serializer
      attributes :punk_identifier, :sale_price
    end
  end
end
