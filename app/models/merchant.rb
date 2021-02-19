class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :items

  def self.total_revenue
    joins(invoices: [:invoice_items, :transactions])
      .where("transactions.result = 'success' AND invoices.status = 'shipped'")
      .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .group(:id)
      .order('revenue DESC')
  end

  def self.top_by_revenue(qty)
    total_revenue.limit(qty)
  end

  def self.most_items_sold(qty) 
    joins(invoices: [:invoice_items, :transactions])
      .where("transactions.result = 'success' AND invoices.status = 'shipped' OR invoices.status = 'packaged'")
      .select('merchants.*, SUM(invoice_items.quantity) AS count')
      .group(:id)
      .order('count DESC')
      .limit(qty)
  end
end


