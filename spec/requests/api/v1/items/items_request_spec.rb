require 'rails_helper'

describe "Items API CRUD Endpoints" do
  describe 'GET /items' do
    it "can fetch all books" do
      merchant1 = create(:merchant).id
      item1     = create(:item, merchant_id: merchant1)
      item2     = create(:item, merchant_id: merchant1)
      item3     = create(:item, merchant_id: merchant1)
      merchant2 = create(:merchant).id
      item1     = create(:item, merchant_id: merchant2)
      item2     = create(:item, merchant_id: merchant2)
      item3     = create(:item, merchant_id: merchant2)

      get '/api/v1/items'

      expect(response).to be_successful
    
      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(items.count).to eq(6)

      items.each do |item|
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

  describe 'PATCH /items/:id' do
    it "can update a item" do
      id = create(:item).id
      previous_name = Item.last.name
      item_params = { name: 'Teddy Ruxpin' }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item: item_params)
      
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq(item_params[:name])
    end
  end

  describe 'DELETE /books/:id' do
    it "can destroy an item" do
      item = create(:item).id

      expect(Item.count).to eq(1)

      expect{ delete "/api/v1/items/#{item}" }.to change(Item, :count).by(-1)

      expect(response).to be_successful
      expect(Item.count).to eq(0)
      expect(response).to have_http_status(:no_content)
      expect{Item.find(item)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "Item's Merchant Endpoint" do
    it "can fetch the merchant an item belongs to" do
      id = create(:item).id

      get "/api/v1/items/#{id}/merchants"

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