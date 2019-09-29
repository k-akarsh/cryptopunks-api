# frozen_string_literal: true

# This model class contains basic infromation about a punk

class Punk < ApplicationRecord
  GENDERS = { 'Male' => 'm', 'Female' => 'f' }.freeze

  has_and_belongs_to_many :accessories
  has_one :punk_listing

  # Returns list of punks available for sale
  scope :sale_listings, -> { joins(:punk_listing).where('punk_listings.for_sale =?', true) }

  # Determines if punk is available for sale or not
  def for_sale
    punk_listing&.for_sale || false
  end

  # Returns minimum for sale price if punk is available for sale, 0 otherwise
  def sale_price
    return 0 unless for_sale
    punk_listing&.sale_price || 0
  end
end
