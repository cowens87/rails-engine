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
    it 'can find top merchants by revenue' do
      
      get "/api/v1/revenue/merchants?quantity=10"

      merch_rev  = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful

      merch_rev.each do |merch|
        expect(merch).to have_key(:id)
        expect(merch[:id].to_i).to be_a(Numeric)
    
        expect(merch[:attributes]).to have_key(:name)
        expect(merch[:attributes][:name]).to eq(@merchant1.name)

        expect(merch[:attributes]).to have_key(:revenue)
        expect(merch[:attributes][:revenue]).to be_a(Numeric)
      end
    end
  end
end
