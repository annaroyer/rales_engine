require 'csv'

OPTIONS = {headers: true, header_converters: :symbol, converters: :numeric}

namespace :import_csv do
  desc "Seeding Database"
  task load: :environment do
    load_customers
    load_merchants
    load_invoices
    load_items
    load_transactions
    load_invoice_items
  end

  def load_customers
    CSV.foreach('db/csv/customers.csv', OPTIONS) do |row|
      Customer.create!(row.to_hash)
    end
  end

  def load_merchants
    CSV.foreach('db/csv/merchants.csv', OPTIONS) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  def load_invoices
    CSV.foreach('db/csv/invoices.csv', OPTIONS) do |row|
      Invoice.create!(row.to_hash)
    end
  end

  def load_items
    CSV.foreach('db/csv/items.csv', OPTIONS) do |row|
      Item.create!(row.to_hash)
    end
  end

  def load_transactions
    CSV.foreach('db/csv/transactions.csv', OPTIONS) do |row|
      Transaction.create!(row.to_hash)
    end
  end

  def load_invoice_items
    CSV.foreach('db/csv/invoice_items.csv', OPTIONS) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end
end
