require 'rails_helper'

describe "Items API" do
  it "returns all of items" do
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

  it "can get one item" do
    merchant1 = create(:merchant).id
    item1     = create(:item, merchant_id: merchant1).id

    get "/api/v1/items/#{item1}"

    item = JSON.parse(response.body, symbolize_names: true)[:data]
# require 'pry'; binding.pry
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

  # it "returns a subset of merchants based on pagination (limit)" do
  #   create_list(:merchant, 23)

  #   get '/api/v1/merchants', params: {per_page: 20}

  #   expect(response).to be_successful
   
  #   merchants = JSON.parse(response.body, symbolize_names: true)[:data]

  #   expect(merchants.count).to eq(20)

  #   merchants.each do |merchant|
  #     expect(merchant[:attributes]).to have_key(:name)
  #     expect(merchant[:attributes][:name]).to be_a(String)
  #   end
  # end
end