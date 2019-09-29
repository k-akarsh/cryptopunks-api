# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Punk, type: :model do
  it { is_expected.to have_and_belong_to_many(:accessories) }
  it { is_expected.to have_one(:punk_listing) }
end
