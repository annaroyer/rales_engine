# GET /api/v1/customers/:id/invoices returns a collection of associated invoices
# GET /api/v1/customers/:id/transactions returns a collection of associated transactions
require 'rails_helper'

describe "Customers Relationship Endpoints" do
  before :each do
    @id = create(:customer).id
    invoice1 = create(:invoice, customer_id: @id)
    invoice2 = create(:invoice, customer_id: @id)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice1)
  end
  it "returns a collection of associated invoices" do
    get "/api/v1/customers/#{@id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.first["customer_id"]).to eq(1)
    expect(invoices.count).to eq(2)
  end

  it "returns a collection of associated transactions" do
    get "/api/v1/customers/#{@id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.first["invoice_id"]).to eq(3)
    expect(transactions.count).to eq(2)
  end
end
