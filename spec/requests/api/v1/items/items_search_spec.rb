require 'rails_helper'

describe 'Items API' do
  describe 'Item find_all Endpoint Happy Path' do
    it 'can find all items matching name search' do
      
      create(:item, name: "Fluffy Pillow")
      create(:item, name: 'Fluffy & Stuffy Pillow')
      create(:item, name: 'Over-Fluffy Pillow')

      get '/api/v1/items/find_all?name=flu'

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(items.count).to eq(3)
      expect(response).to be_successful

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq('item')
        expect(item[:type]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Numeric)
      end 
    end
  end
  
  describe 'Items find_all Endpoint Sad Path' do
    it 'will return a 204 if there are no name matches' do
      create(:item, name: "Fluffy Pillow")
      create(:item, name: 'Fluffy & Stuffy Pillow')
      create(:item, name: 'Over-Fluffy Pillow')

      get '/api/v1/items/find_all?name=xyd'

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end
