# frozen_string_literal: true

module Api
  module V1
    class PunksController < ApplicationController
      def listings
        punks_sale_listings = Punk.sale_listings
        render json: punks_sale_listings, each_serializer: PunkListingSerializer
      end

      def show
        punk = Punk.find_by(punk_identifier: params[:punk_identifier])
        if punk
          render json: punk, serializer: PunkSerializer
        else
          render json: { message: 'Punk not found for given Punk Identifier' }, status: 404
        end
      end
    end
  end
end
