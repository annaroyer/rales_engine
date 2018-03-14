class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.invoices_by_cost
    group(:invoice_id).order("sum(quantity * unit_price)")
  end
end
