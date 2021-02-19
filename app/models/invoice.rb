class Invoice < ApplicationRecord
  validates_presence_of :status
  
  belongs_to :customer
  belongs_to :merchant

  has_many :transactions, dependent: :destroy
  has_many :invoice_items 
  has_many :items, through: :invoice_items

  def self.potential_revenue(qty)
    joins([:invoice_items, :transactions])
      .select('invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS potential_revenue')
      .where('invoices.status != ? AND transactions.result = ?', "shipped", "success")
      .order('potential_revenue desc')
      .limit(qty)
      .group(:id)
  end
end
