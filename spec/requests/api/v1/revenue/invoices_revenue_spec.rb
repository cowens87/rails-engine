require 'rails_helper'

describe 'Revenue potential for unshipped items' do
  before :each do
    @customer1 = create(:customer)
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @item1     = create(:item, merchant: @merchant1, name: 'Hair Brush')
    @item2     = create(:item, merchant: @merchant2, name: 'Hair Spray')
    @item3     = create(:item, merchant: @merchant2, name: 'Hair Clip')
    @invoice1  = create(:invoice, merchant: @merchant1, customer: @customer1 , status: 'shipped')
    @invoice2  = create(:invoice, merchant: @merchant2, customer: @customer1 , status: 'shipped')
    @invoice3  = create(:invoice, merchant: @merchant2, customer: @customer1 , status: 'unshipped')
    @transax1  = create(:transaction, invoice: @invoice1, result: 'success')
    @transax2  = create(:transaction, invoice: @invoice2, result: 'success')
    @transax3  = create(:transaction, invoice: @invoice3, result: 'success')
    6.times { create(:invoice_item, item: @item1, invoice: @invoice3, quantity: 3, unit_price: 7.50)}
    8.times { create(:invoice_item, item: @item3, invoice: @invoice1, quantity: 100, unit_price: 8)}
    5.times { create(:invoice_item, item: @item2, invoice: @invoice2, quantity: 6, unit_price: 13.50)}
  end

  it 'can calculate the potential revenue for unshipped orders' do
    get "/api/v1/revenue/unshipped"

    expect(response).to be_successful

    unshipped = JSON.parse(response.body, symbolize_names: true)[:data]
   
    unshipped.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq('invoice_revenue')

      expect(item).to have_key(:attributes)
      expect(item[:attributes][:potential_revenue]).to be_a(Numeric)
    end
  end

  it 'SAD PATH - unshipped revenue potential no quantity is provided' do
    get "/api/v1/revenue/unshipped?quantity=xyz"

    expect(response).to_not be_successful
  end
end