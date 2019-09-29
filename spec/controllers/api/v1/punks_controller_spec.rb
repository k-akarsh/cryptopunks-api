# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PunksController, type: :controller do
  describe 'GET #listings' do
    let!(:punks) { create_list(:punk, 4) }
    let!(:expected_response) do
      [{ 'punk_identifier' => punks[0].punk_identifier, 'sale_price' => '200000000' },
       { 'punk_identifier' => punks[2].punk_identifier, 'sale_price' => '300000000' }]
    end

    context 'when no punks are available for sale' do
      before do
        get :listings
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns no listing' do
        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context 'when punks are available for sale' do
      before do
        create(:punk_listing, punk_id: punks[0].id, for_sale: true, sale_price: '200000000')
        create(:punk_listing, punk_id: punks[1].id, for_sale: false, sale_price: '0')
        create(:punk_listing, punk_id: punks[2].id, for_sale: true, sale_price: '300000000')
      end

      before do
        get :listings
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the correct count of punks available for sale' do
        expect(JSON.parse(response.body).count).to eq 2
      end

      it 'returns the list of punks available for sale' do
        expect(JSON.parse(response.body)).to eq expected_response
      end
    end
  end

  describe 'GET #show' do
    let(:punk) { create(:punk) }
    let(:accessory_glasses) { create(:accessory, name: 'Glasses') }
    let(:accessory_hat) { create(:accessory, name: 'Hat') }
    before do
      punk.accessories << [accessory_glasses, accessory_hat]
      create(:punk_listing, punk_id: punk.id, for_sale: true, sale_price: '200000000')
    end

    let(:non_existent_punk_identifier) { 100_000 }

    context 'when punk with given punk_identifier does not exist' do
      before do
        get :show, params: { punk_identifier: non_existent_punk_identifier }
      end

      it 'returns 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns proper message' do
        expect(JSON.parse(response.body)['message']).to eq 'Punk not found for given Punk Identifier'
      end
    end

    context 'when punk with given punk_identifier exists' do
      before do
        get :show, params: { punk_identifier: punk.punk_identifier }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns correct values for punk_identifier, gender, for_sale, sale_price' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['punk_identifier']).to eq punk.punk_identifier
        expect(parsed_response['gender']).to eq Punk::GENDERS.key(punk.gender)
        expect(parsed_response['for_sale']).to eq punk.for_sale
        expect(parsed_response['sale_price']).to eq punk.sale_price
      end

      it 'returns correct list of accessopries' do
        expect(JSON.parse(response.body)['accessories']).to match_array(%w[Glasses Hat])
      end
    end
  end
end
