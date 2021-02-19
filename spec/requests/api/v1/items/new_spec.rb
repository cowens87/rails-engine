require 'rails_helper'

describe "Items API CRUD Endpoints" do
  describe 'POST /items' do
    it "can create an item" do
      merchant = create(:merchant)
      item_params = {
        name: 'Teddy Ruxpin',
        description: 'Bring this vintage and classic bear back into your life',
        unit_price: 241.99,
        merchant_id: merchant.id
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item_params)
      
      created_item = Item.last

      expect(response).to be_successful
      expect(response).to have_http_status(:created)
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
    end 
  end
end