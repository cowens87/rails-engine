require 'rails_helper'

describe "Items API CRUD Endpoints" do
  describe "Item's Merchant Endpoint" do
    it "can fetch the merchant an item belongs to" do
      id = create(:item).id

      get "/api/v1/items/#{id}/merchant"

      expect(response).to be_successful

      item_merchant = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(item_merchant).to have_key(:id)
      expect(item_merchant[:id]).to be_an(String)

      expect(item_merchant).to have_key(:type)
      expect(item_merchant[:type]).to eq("merchant")

      expect(item_merchant).to have_key(:attributes)
      expect(item_merchant[:attributes]).to be_a(Hash)

      expect(item_merchant[:attributes]).to have_key(:name)
      expect(item_merchant[:attributes][:name]).to be_an(String)
    end
  end 
end