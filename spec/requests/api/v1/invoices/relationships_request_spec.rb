require 'rails_helper'

describe 'Invoices Relationship API' do
  it 'sends a collection of associated transactions' do
    invoice = create(:invoice).
    create_list(:transaction, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions.count).to eq(3)
    transactions.each do |transaction|
      expect(transaction["invoice_id"]).to eq(invoice.id)
    end
  end
end
# GET /api/v1/invoices/:id/transactions returns a collection of associated transactions
# GET /api/v1/invoices/:id/invoice_items returns a collection of associated invoice items
# GET /api/v1/invoices/:id/items returns a collection of associated items
# GET /api/v1/invoices/:id/customer returns the associated customer
# GET /api/v1/invoices/:id/merchant returns the associated merchant
