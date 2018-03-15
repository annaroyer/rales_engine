class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  validates_presence_of :first_name, :last_name

  def self.with_pending_invoices(id)
    find_by_sql("SELECT customers.* FROM customers
      JOIN invoices ON invoices.customer_id = customers.id
      JOIN transactions ON invoices.id = transactions.invoice_id
      WHERE invoices.merchant_id = '#{id}' AND transactions.result = 'failed'
      EXCEPT SELECT customers.* FROM customers
      JOIN invoices ON invoices.customer_id = customers.id
      JOIN transactions ON invoices.id = transactions.invoice_id
      WHERE invoices.merchant_id = '#{id}' AND transactions.result = 'success'")
  end

  def self.favorite_for_merchant(id)
    joins(:invoices, :transactions)
    .where(invoices: {merchant_id: id}, transactions: {result:'success'})
    .group(:id)
    .order('count (transactions.id)DESC')
    .first
  end
end
