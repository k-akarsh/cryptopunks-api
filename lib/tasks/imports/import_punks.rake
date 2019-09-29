# frozen_string_literal: true

# To run this rake task: bundle exec rake imports:import_punks

namespace :imports do
  desc 'import attributes and gender for all punks from the mappings'
  task import_punks: :environment do
    begin
      punks_data_json = File.read('./db/CryptoPunks.json')
    rescue Errno::ENOENT => exception
      warn "Caught exception: #{exception}"
      exit 1
    end
    punks_data_hash = JSON.parse(punks_data_json)
    punks_data_hash.each do |key, value|
      import_punk(punk_identifier = key, punk_attributes = value)
    end
  end

  def import_punk(punk_identifier, punk_attributes)
    gender = punk_attributes['gender']
    accessories = punk_attributes['accessories']
    punk = Punk.where(punk_identifier: punk_identifier).first_or_create(gender: Punk::GENDERS[gender])
    accessories.each do |accessory|
      accessory = Accessory.where(name: accessory).first_or_create
      punk.accessories << accessory unless punk.accessories.include?(accessory)
    end
  end
end
