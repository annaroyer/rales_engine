class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
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

  def self.total_revenue(date)
    joins(:invoice_items, :invoices, :transactions)
    .merge(Transaction.unscoped.success)
    .sum("quantity * invoice_items.unit_price")
  end
end
