class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def total_revenue
    invoice_items.sum(:total_revenue)
  end

  def self.best_day
    select('invoices.created_at, count(invoices.created_at) as count_by_date')
    .joins(:transactions).merge(Transaction.success)
    .group(:created_at)
    .order('count_by_date DESC, created_at DESC')
    .first
  end
end
