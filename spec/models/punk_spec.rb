# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Punk, type: :model do
  it { is_expected.to have_and_belong_to_many(:accessories) }
  it { is_expected.to have_one(:punk_listing) }

  describe '#for_sale' do
    let(:punk) { create(:punk) }
    subject { punk.for_sale }

    context 'when punk has no listing' do
      it { is_expected.to(eq(false)) }
    end

    context 'when punk has listing present but is not available for sale' do
      before { create(:punk_listing, punk_id: punk.id, for_sale: false, sale_price: '100000') }
      it { is_expected.to(eq(false)) }
    end

    context 'when punk has listing present and is available for sale' do
      before { create(:punk_listing, punk_id: punk.id, for_sale: true, sale_price: '100000') }
      it { is_expected.to(eq(true)) }
    end
  end

  describe '#sale_price' do
    let(:punk) { create(:punk) }
    subject { punk.sale_price }

    context 'when punk has no listing' do
      it { is_expected.to(eq(0)) }
    end

    context 'when punk has listing present but is not available for sale' do
      before { create(:punk_listing, punk_id: punk.id, for_sale: false, sale_price: '100000') }
      it { is_expected.to(eq(0)) }
    end

    context 'when punk has listing present and is available for sale' do
      before { create(:punk_listing, punk_id: punk.id, for_sale: true, sale_price: '100000') }
      it { is_expected.to(eq('100000')) }
    end
  end
end
