require 'rails_helper'

describe 'Merchants API' do
  describe 'Merchant Find Endpoint Happy Path' do
    it 'can find a merchants matching name search' do
      create(:merchant, name: "All Things Fluffy")
      create(:merchant, name: 'Fluffy Tings')
      merchant3 = create(:merchant, name: 'Fluff -n- Stuff')

      get '/api/v1/merchants/find?name=flu'

      merchant = JSON.parse(response.body, symbolize_names: true)
      
      expect(merchant.count).to eq(1)
      expect(response).to be_successful

      found_merchant = merchant[:data]
      
      expect(found_merchant).to have_key(:id)
      expect(found_merchant[:id]).to be_an(String)
      expect(found_merchant[:id]).to_not eq(merchant3.id)

      expect(found_merchant[:attributes]).to have_key(:name)
      expect(found_merchant[:attributes][:name]).to be_a(String)
    end
  end

  describe 'Merchant Find Endpoint Sad Path' do
    it 'will return a 204 if there are no name matches' do
      create(:merchant, name: "All Things Fluffy")
      create(:merchant, name: 'Fluffy Tings')
      create(:merchant, name: 'Fluff -n- Stuff')

      get '/api/v1/merchants/find?name=xyz'

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end

  describe 'Merchant Most Item Endpoint' do
    it 'will merchants who sold the most items' do
       # Customers:
      customer1  = create(:customer)
      # Merchants:
      merchant1  = create(:merchant)
      merchant2  = create(:merchant)
      merchant3  = create(:merchant)
      # Invoices:
      invoice1   = create(:invoice, customer_id: customer1.id, merchant_id: merchant1.id, status: 'shipped')
      invoice2   = create(:invoice, customer_id: customer1.id, merchant_id: merchant2.id, status: 'shipped')
      invoice3   = create(:invoice, customer_id: customer1.id, merchant_id: merchant3.id, status: 'shipped')
      # Transactions:
      transax1   = create(:transaction, invoice_id: invoice2.id, result: 'success')
      transax2   = create(:transaction, invoice_id: invoice1.id, result: 'success')
      transax3   = create(:transaction, invoice_id: invoice3.id, result: 'success')
      # Items:
      item1      = create(:item, merchant_id: merchant1.id)
      item2      = create(:item, merchant_id: merchant2.id)
      item3      = create(:item, merchant_id: merchant1.id)
      item4      = create(:item, merchant_id: merchant3.id)
      item5      = create(:item, merchant_id: merchant1.id)
      # InvoiceItems:
      invitm1    = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id)
      invitm2    = create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id)
      invitm3    = create(:invoice_item, invoice_id: invoice3.id, item_id: item2.id)
      invitm3    = create(:invoice_item, invoice_id: invoice3.id, item_id: item2.id)
      invitm3    = create(:invoice_item, invoice_id: invoice1.id, item_id: item2.id)
      invitm3    = create(:invoice_item, invoice_id: invoice3.id, item_id: item2.id)

      get '/api/v1/merchants/most_items?quantity=3'

      merchants = JSON.parse(response.body, symbolize_names: true)[:data]
   
      expect(merchants.count).to eq(3)
      expect(response).to be_successful

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to eq('merchant_item')

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)

        expect(merchant[:attributes]).to have_key(:count)
        expect(merchant[:attributes][:count]).to be_a(Numeric)
      end
    end
  end
end
