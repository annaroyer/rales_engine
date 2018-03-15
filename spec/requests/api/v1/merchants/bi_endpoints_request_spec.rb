require 'rails_helper'

describe "Merchant BI Endpoints" do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    invoice1 = create(:invoice, merchant: @merchant1)
    invoice2 = create(:invoice, merchant: @merchant2)
    @invoice3 = create(:invoice, merchant: @merchant3, created_at: "2012-03-16 09:54:09 UTC,2012-03-25 09:54:09 UTC")
    invoice4 = create(:invoice, merchant: @merchant3)
    create(:transaction, invoice: @invoice3)
    create(:transaction, invoice: invoice1)
    create(:invoice_item, unit_price: 4000, quantity: 2, invoice: invoice1)
    create(:invoice_item, unit_price: 5000, quantity: 3, invoice: @invoice3)
    create(:invoice_item, unit_price: 6000, quantity: 2, invoice: invoice2)
    create(:transaction, result: 'failed', invoice: invoice3)
  end

  # GET /api/v1/merchants/most_revenue?quantity=x
  it "sends the top x merchants ranked by top revenue" do
    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.first["id"]).to eq(@merchant3.id)
    expect(merchants.first["name"]).to eq(@merchant3.name)
    expect(merchants.count).to eq(2)
  end

  it "returns the top x merchants ranked by total number of items sold" do
    get "/api/v1/merchants/most_items?quantity=3"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants.first["id"]).to eq(@merchant3.id)
    expect(merchants.first["name"]).to eq(@merchant3.name)
    expect(merchants.count).to eq(3)
  end

  it "returns a collection of customers which have pending invoices" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction = create(:transaction, result: 'failed', invoice: invoice)

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    expect(response).to be_successful

    result = JSON.parse(response.body)
    expect(result.first["id"]).to eq(customer.id)
  end

  it "returns the customer who has conducted the most total number of successful transactions" do
    merchant = create(:merchant)
    customer = create(:customer)
    success = create(:transaction, result: 'success')
    create_list(:invoice, 5, customer: customer, merchant: merchant, transactions: [success] )

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    expect(response).to be_successful

    customer_result = JSON.parse(response.body)
    expect(customer_result["id"]).to eq(customer.id)
  end

# GET /api/v1/merchants/revenue?date=x
  it "returns the total revenue for date x across all merchants" do
    created_date = "2012-03-16"
    merchant = create(:merchant)
    successful_1 = create(:transaction, result: 'success')
    successful_2 = create(:transaction, result: 'success')
    invoice_1 = create(:invoice, merchant: merchant, transactions: [successful_1], updated_at: created_date)
    invoice_2 = create(:invoice, merchant: merchant, transactions: [successful_2], updated_at: created_date)
    create_list(:invoice_item, 3, unit_price: 5000, quantity: 3, invoice: invoice_1)
    create_list(:invoice_item, 2, unit_price: 6000, quantity: 2, invoice: invoice_2)

    get "/api/v1/merchants/revenue?date=#{created_date}"

    expect(response).to be_successful
    merchant_result = JSON.parse(response.body)
    expect(merchant_result).to eq(Merchant.total_revenue(created_date))

  it "returns the total revenue for a merchant" do
    get "/api/v1/merchants/#{@merchant1.id}/revenue"

    expect(response).to be_successful

    revenue = JSON.parse(response.body)

    expect(revenue).to eq({"revenue"=>"80.00"})
  end

  it "returns the total revenue for a merchant on a date" do
    get "/api/v1/merchants/#{@merchant3.id}/revenue?date=2012-03-16"

    expect(response).to be_successful

    revenue = JSON.parse(response.body)

    expect(revenue).to eq({"revenue"=>"150.00"})
  end
end
