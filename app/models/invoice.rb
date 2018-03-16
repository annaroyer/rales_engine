class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.best_day
    select('invoices.created_at, count(invoices.id) * invoice_items.quantity as items_sold')
    .joins(:invoice_items, :transactions)
    .merge(Transaction.success)
    .group('invoices.created_at, invoice_items.quantity')
    .order('items_sold DESC, created_at DESC')
    .first
  end
end
