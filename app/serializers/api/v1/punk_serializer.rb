# frozen_string_literal: true
module Api
  module V1
    class PunkSerializer < ActiveModel::Serializer
      attributes :punk_identifier, :gender, :accessories, :for_sale, :sale_price

      def gender
        Punk::GENDERS.key(object.gender)
      end

      def accessories
        object.accessories.map(&:name)
      end
    end
  end
end
