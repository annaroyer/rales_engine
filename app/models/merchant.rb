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

  def revenue(params={})
    invoices.where(params)
    .joins(:invoice_items)
    .joins(:transactions)
    .merge(Transaction.success)
    .sum('unit_price * quantity')
  end

  def revenue_dollars(params={})
    '%.2f' % (revenue(params).to_f / 100)
  end

  def self.most_invoices
    select('merchants.*, count(invoices.id) as count_all')
    .joins(:invoices)
    .joins(:transactions).merge(Transaction.success)
    .order('count_all DESC')
    .group(:id)
    .first
  end
end
