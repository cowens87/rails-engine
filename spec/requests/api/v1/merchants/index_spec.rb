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
end