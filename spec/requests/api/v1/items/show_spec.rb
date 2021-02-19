require 'rails_helper'

describe "Items API CRUD Endpoints" do
  describe "GET items/:id" do
    it "can fetch one item" do
      merchant1 = create(:merchant).id
      item1     = create(:item, merchant_id: merchant1).id

      get "/api/v1/items/#{item1}"

      item = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Numeric)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Numeric)
    end
  end
end