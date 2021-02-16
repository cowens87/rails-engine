require 'rails_helper'

describe 'Merchant Non-Restful API Endpoints' do
  before(:each) do
    # Customers:
    @customer1  = create(:customer)
    @customer2  = create(:customer)
    # Merchants:
    @merchant1  = create(:merchant)
    # Invoices:
    @invoice1   = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant1.id)
    @invoice2   = create(:invoice, customer_id: @customer2.id, merchant_id: @merchant1.id)
    # Transactions:
    @transax1   = create(:transaction, invoice_id: @invoice1.id)
    @transax2   = create(:transaction, invoice_id: @invoice2.id)
    # Items:
    @item1      = create(:item, merchant_id: @merchant1.id)
    @item2      = create(:item, merchant_id: @merchant1.id)
    # InvoiceItems:
    @invitm1    = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id)
    @invitm2    = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id)
    @invitm3    = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item1.id)
  end

  it 'can find total revenue for a given merchant' do

    get "/api/v1/revenue/merchants/#{@merchant1.id}"

    revenue = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(response).to be_successful
    expect(revenue).to have_key(:id)
    expect(revenue[:id]).to eq(nil)

    expect(revenue[:attributes]).to have_key(:revenue)
    expect(revenue[:attributes][:revenue]).to eq(@merchant1.total_revenue)
  end

  # it "can return all merchants total revenue by date range" do
  #   merchants = create_list(:merchant, 2, :with_revenue, creation: (DateTime.now - 5.days))
  #   start_date = Date.today - 7
  #   end_date = Date.today - 2
  #   total_revenue_between_dates = merchants.sum(&:revenue).round(2)

  #   get "/api/v1/revenue?start=#{start_date}&end=#{end_date}"

  #   expect(response).to be_successful

  #   revenue = JSON.parse(response.body, symbolize_names: true)[:data]

  #   expect(revenue).to have_key(:id)
  #   expect(revenue[:id]).to eq(nil)

  #   expect(revenue[:attributes]).to have_key(:revenue)
  #   expect(revenue[:attributes][:revenue]).to eq(total_revenue_between_dates)
  # end
end
