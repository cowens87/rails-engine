require 'rails_helper'

describe "INDEX - Items API CRUD Endpoints" do
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

    it 'can fetch a large amount of items' do
      create_list(:item, 100)
      
      get '/api/v1/items?per_page=100'
      
      expect(response).to be_successful
    
      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(items.count).to eq(100)
    end
  end 
end