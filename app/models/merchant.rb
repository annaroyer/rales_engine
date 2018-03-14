class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  validates_presence_of :name

  def total_revenue
    invoices.sum(:total_revenue)
  end

  def self.most_revenue(quantity)
    order(:total_revenue).reverse_order.limit(quantity)
  end
end
