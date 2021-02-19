require 'rails_helper'

describe 'Non-Restful API Revenue Endpoints' do
  before(:each) do
    @customer1  = create(:customer)
    @merchant1  = create(:merchant)
    @invoice1   = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant1.id, status: 'shipped')
    @transax1   = create(:transaction, invoice_id: @invoice1.id, result: 'success')
    @item1      = create(:item, merchant_id: @merchant1.id)
    @item2      = create(:item, merchant_id: @merchant1.id)
    @invitm1    = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id)
    @invitm2    = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id)
  end

  describe 'FOUR - Non-RESTful Endpoints' do
    it 'can find total revenue for a given merchant' do
      
      get "/api/v1/revenue/merchants/#{@merchant1.id}"
      merch_rev = Merchant.total_revenue.find(@merchant1.id)
      revenue = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(response).to be_successful
      expect(revenue).to have_key(:id)
      expect(revenue[:id]).to eq(merch_rev.id.to_s)
  
      expect(revenue[:attributes]).to have_key(:revenue)
      expect(revenue[:attributes][:revenue]).to eq(merch_rev.revenue)
    end
  end
end
