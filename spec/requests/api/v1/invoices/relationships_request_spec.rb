require 'rails_helper'

describe 'Invoices Relationship API' do
  before(:each) do
    @invoice = create(:invoice)
  end
  it 'sends a collection of associated transactions' do
    create_list(:transaction, 3, invoice: @invoice)

    get "/api/v1/invoices/#{@invoice.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions.count).to eq(3)
    transactions.each do |transaction|
      expect(transaction["invoice_id"]).to eq(@invoice.id)
    end
  end

  it 'sends a collection of associated invoice items' do
    create_list(:invoice_item, 3, invoice: @invoice)

    get "/api/v1/invoices/#{@invoice.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items.count).to eq(3)
    invoice_items.each do |invoice_item|
      expect(invoice_item["invoice_id"]).to eq(@invoice.id)
    end
  end

  it 'sends a collection of associated items' do
    item_ids = create_list(:item, 3).pluck(:id)
    item_ids.each do |item_id|
      create(:invoice_item, item_id: item_id, invoice: @invoice)
    end

    get "/api/v1/invoices/#{@invoice.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(3)
    items.each do |item|
      expect(item_ids).to include(item["id"])
    end
  end

  it 'sends the associated customer' do
    get "/api/v1/invoices/#{@invoice.id}/customer"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(@invoice.customer.id)
    expect(customer["last_name"]).to eq(@invoice.customer.last_name)
  end

  it 'sends the associated merchant' do
    get "/api/v1/invoices/#{@invoice.id}/merchant"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(@invoice.merchant.id)
    expect(customer["name"]).to eq(@invoice.merchant.name)
  end
end
