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
end
