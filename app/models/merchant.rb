class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  validates_presence_of :name

  def self.most_revenue(quantity)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoice_items)
    .order('revenue DESC')
    .group(:id)
    .limit(quantity)
  end

  def self.most_items(quantity)
    select('merchants.*, sum(invoice_items.quantity) as items_sold')
    .joins(:invoice_items)
    .group(:id)
    .order('items_sold DESC')
    .limit(quantity)
  end
  
  def revenue
    invoice_items
    .joins(:transactions)
    .merge(Transaction.success)
    .sum('unit_price * quantity')
  end
end
