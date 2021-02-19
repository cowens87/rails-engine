require 'rails_helper'

describe "Merchants API" do
  it "can get one merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end
end