require 'rails_helper'

describe "Merchant's Items" do
  it "can get all items for one merchant" do
    merchant1 = create(:merchant).id
    item1     = create(:item, merchant_id: merchant1)
    item2     = create(:item, merchant_id: merchant1)
    item3     = create(:item, merchant_id: merchant1)

    get "/api/v1/merchants/#{merchant1}/items"

    merchant_items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(merchant_items.count).to eq(3)

    merchant_items.each do |merchant_item|
      expect(merchant_item[:attributes]).to have_key(:name)
      expect(merchant_item[:attributes][:name]).to be_a(String)

      expect(merchant_item[:attributes]).to have_key(:description)
      expect(merchant_item[:attributes][:description]).to be_a(String)

      expect(merchant_item[:attributes]).to have_key(:unit_price)
      expect(merchant_item[:attributes][:unit_price]).to be_a(Numeric)

      expect(merchant_item[:attributes]).to have_key(:merchant_id)
      expect(merchant_item[:attributes][:merchant_id]).to be_a(Numeric)
    end
  end
end