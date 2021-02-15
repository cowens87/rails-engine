require 'rails_helper'

describe 'Merchants API' do
  describe 'Merchant Find Endpoint Happy Path' do
    it 'can find a merchants matching name search' do
      create(:merchant, name: "All Things Fluffy")
      create(:merchant, name: 'Fluffy Tings')
      merchant3 = create(:merchant, name: 'Fluff -n- Stuff')

      get '/api/v1/merchants/find?name=flu'

      merchant = JSON.parse(response.body, symbolize_names: true)
      
      expect(merchant.count).to eq(1)
      expect(response).to be_successful

      found_merchant = merchant[:data]
      
      expect(found_merchant).to have_key(:id)
      expect(found_merchant[:id]).to be_an(String)
      expect(found_merchant[:id]).to_not eq(merchant3.id)

      expect(found_merchant[:attributes]).to have_key(:name)
      expect(found_merchant[:attributes][:name]).to be_a(String)
    end
  end

  describe 'Merchant Find Endpoint Sad Path' do
    it 'will return a 204 if there are no name matches' do
      create(:merchant, name: "All Things Fluffy")
      create(:merchant, name: 'Fluffy Tings')
      create(:merchant, name: 'Fluff -n- Stuff')

      get '/api/v1/merchants/find?name=xyz'

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end
end
