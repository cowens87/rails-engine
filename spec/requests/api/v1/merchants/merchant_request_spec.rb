require 'rails_helper'

describe "Merchants API" do
  it "returns all of merchants" do
    create_list(:merchant, 25)

    get '/api/v1/merchants'

    expect(response).to be_successful
   
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "returns a subset of merchants based on pagination (limit)" do
    create_list(:merchant, 23)

    get '/api/v1/merchants', params: {per_page: 20}

    expect(response).to be_successful
   
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "returns a subset of merchants based on limit and offset" do
    create_list(:merchant, 23)

    get '/api/v1/merchants', params: {per_page: 20, page: 2}

    expect(response).to be_successful
   
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "can get one merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

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