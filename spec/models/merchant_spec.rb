require 'rails_helper'

RSpec.describe Merchant, type: :model do
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
    @invoice1   = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant1.id, status: 'shipped')
    @invoice2   = create(:invoice, customer_id: @customer2.id, merchant_id: @merchant2.id, status: 'shipped')
    @invoice3   = create(:invoice, customer_id: @customer3.id, merchant_id: @merchant2.id, status: 'shipped')
    @invoice4   = create(:invoice, customer_id: @customer4.id, merchant_id: @merchant1.id, status: 'shipped')
    @invoice5   = create(:invoice, customer_id: @customer5.id, merchant_id: @merchant2.id, status: 'shipped')
    @invoice6   = create(:invoice, customer_id: @customer2.id, merchant_id: @merchant2.id, status: 'shipped')
    @invoice7   = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant2.id, status: 'shipped')
    # Transactions:
    @transax1   = create(:transaction, invoice_id: @invoice2.id, result: 'success')
    @transax2   = create(:transaction, invoice_id: @invoice1.id, result: 'success')
    @transax3   = create(:transaction, invoice_id: @invoice3.id, result: 'success')
    @transax4   = create(:transaction, invoice_id: @invoice4.id, result: 'success')
    @transax5   = create(:transaction, invoice_id: @invoice5.id, result: 'success')
    @transax6   = create(:transaction, invoice_id: @invoice5.id, result: 'success')
    @transax7   = create(:transaction, invoice_id: @invoice6.id, result: 'success')
    @transax8   = create(:transaction, invoice_id: @invoice7.id, result: 'success')
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
    it { should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:invoice_items).through(:items)}
  end

  describe 'class methods' do
    it 'can calculate the total revenue of all merchants' do
      expect(Merchant.total_revenue.first).to eq(@merchant2)
    end

    it 'can find the top merchant by revenue' do
      expect(Merchant.top_by_revenue(1)[0]).to eq(@merchant2)
    end

    it 'can merchants that sold the most items' do
      expect(Merchant.most_items_sold(1)).to eq([@merchant2])
    end
  end
end