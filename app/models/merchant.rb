class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  validates_presence_of :name

  def revenue
    invoice_items
    .joins(:transactions)
    .merge(Transaction.success)
    .sum('unit_price * quantity')
  end
end
