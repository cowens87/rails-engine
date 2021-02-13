require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before(:each) do
    # Customers:
    @customer1  = create(:customer)
    @customer2  = create(:customer)
    @customer3  = create(:customer)   
    @customer4  = create(:customer)
    @customer5  = create(:customer)
    # Merchants:
    @merchant1  = create(:merchant)
    @merchant2  = create(:merchant)
    # Invoices:
    @invoice1   = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant1.id)
    @invoice2   = create(:invoice, customer_id: @customer2.id, merchant_id: @merchant2.id)
    @invoice3   = create(:invoice, customer_id: @customer3.id, merchant_id: @merchant2.id)
    @invoice4   = create(:invoice, customer_id: @customer4.id, merchant_id: @merchant1.id)
    @invoice5   = create(:invoice, customer_id: @customer5.id, merchant_id: @merchant2.id)
    @invoice6   = create(:invoice, customer_id: @customer2.id, merchant_id: @merchant2.id)
    @invoice7   = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant2.id)
    # Transactions:
    @transax1   = create(:transaction, invoice_id: @invoice2.id)
    @transax2   = create(:transaction, invoice_id: @invoice1.id)
    @transax3   = create(:transaction, invoice_id: @invoice3.id)
    @transax4   = create(:transaction, invoice_id: @invoice4.id)
    @transax5   = create(:transaction, invoice_id: @invoice5.id)
    @transax6   = create(:transaction, invoice_id: @invoice5.id)
    @transax7   = create(:transaction, invoice_id: @invoice6.id)
    @transax8   = create(:transaction, invoice_id: @invoice7.id)
    # Items:
    @item1      = create(:item, merchant_id: @merchant1.id)
    @item2      = create(:item, merchant_id: @merchant2.id)
    @item3      = create(:item, merchant_id: @merchant1.id)
    # InvoiceItems:
    @invitm1    = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id)
    @invitm2    = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id)
    @invitm3    = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item2.id)
  end

  describe 'validations' do
    it { should validate_presence_of :credit_card_number}
    it { should validate_presence_of :credit_card_expiration_date}
  end

  describe 'relationships' do
    it {should belong_to :invoice}
  end
end