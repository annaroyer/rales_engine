require 'rails_helper'

describe "Invoices API" do
  before :each do
    @merchant = create(:merchant)
    @customer = create(:customer)
    create_list(:invoice, 3, merchant: @merchant, customer: @customer)
  end

  it "sends a list of invoices" do
    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
  end

  it "can get one invoice by its id" do
    id = create(:invoice, merchant: @merchant, customer: @customer).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(id)
  end

  it "can find one invoice by id params" do
    x = create(:invoice, merchant: @merchant, customer: @customer)

    get "/api/v1/invoices/find?id=#{x.id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["id"]).to eq(x.id)
  end

  it "can find one invoice by status" do
    x = create(:invoice, merchant: @merchant, customer: @customer)

    get "/api/v1/invoices/find?status=#{x.status}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["status"]).to eq(x.status)
  end

  it "can find one invoice by time created at" do
    x = create(:invoice, merchant: @merchant, customer: @customer)

    get "/api/v1/invoices/find?#{x.created_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["customer_id"]).to eq(x.customer_id)
  end

  it "can find one invoice by time updated at" do
    x = create(:invoice, merchant: @merchant, customer: @customer)

    get "/api/v1/invoices/find?#{x.updated_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["customer_id"]).to eq(x.customer_id)
  end

  it "can find all invoices by id params" do
    x = create(:invoice, merchant: @merchant, customer: @customer)

    get "/api/v1/invoices/find_all?id=#{x.id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice.first["id"]).to eq(x.id)
  end

  it "can find all invoices by status params" do
    x = create(:invoice, merchant: @merchant, customer: @customer)

    get "/api/v1/invoices/find_all?status=#{x.status}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice.first["customer_id"]).to eq(x.customer_id)
  end

  it "can find all invoices by created at params" do
    x = create(:invoice, merchant: @merchant, customer: @customer)

    get "/api/v1/invoices/find_all?#{x.created_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice.first["customer_id"]).to eq(x.customer_id)
  end

  it "can find all invoices by updated at params" do
    x = create(:invoice, merchant: @merchant, customer: @customer)

    get "/api/v1/invoices/find_all?#{x.updated_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice.first["customer_id"]).to eq(x.customer_id)
  end

  it "can find a random invoice" do
    get "/api/v1/invoices/random"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice).to include("customer_id")
  end
end
