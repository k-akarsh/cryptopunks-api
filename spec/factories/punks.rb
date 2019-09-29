FactoryBot.define do
  factory :punk do
    sequence(:punk_identifier) { |n| n }
    gender { "f" }
  end
end
