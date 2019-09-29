# frozen_string_literal: true

# This model class contains basic infromation about a punk

class Punk < ApplicationRecord
  GENDERS = { 'Male' => 'm', 'Female' => 'f' }.freeze

  has_and_belongs_to_many :accessories
  has_one :punk_listing

end
