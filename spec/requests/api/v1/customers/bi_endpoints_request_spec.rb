require 'rails_helper'

describe 'Customer Business Intelligence API' do
  it 'sends a merchant where the customer has conducted the most successful transactions' do
    customer = create(:customer)
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    invoices1 = create_list(:invoice, 3, customer: customer, merchant: merchant1)
    invoices1.each { |invoice| create(:transaction, invoice: invoice) }
    failed_invoice = create(:invoice, customer: customer, merchant: merchant1)

    create(:transaction, invoice: failed_invoice, result: 'failed')
    invoices2 = create_list(:invoice, 4, customer: customer, merchant: merchant2)
    invoices2.each { |invoice| create(:transaction, invoice: invoice) }

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    favorite_merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(favorite_merchant["id"]).to eq(merchant2.id)
    expect(favorite_merchant["name"]).to eq(merchant2.name)
  end
end
