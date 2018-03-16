class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoice_items)
    .order('revenue DESC')
    .group(:id)
    .limit(quantity)
  end

  def best_day
    invoices.best_day.created_at
  end

  def self.most_items(quantity)
    select('items.*, sum(invoice_items.quantity) as items_sold')
    .joins(:invoice_items, invoices: :transactions)
    .merge(Transaction.success)
    .group('items.id')
    .order('items_sold DESC')
    .limit(quantity)
  end
end
