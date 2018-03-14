require "rails_helper"

describe 'business intelligence Merchant API endpoint' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)

    invoice1 = create(:invoice, merchant: @merchant1)
    invoice2 = create(:invoice, merchant: @merchant2)
    invoice3 = create(:invoice, merchant: @merchant3)

    create(:invoice_item, unit_price: 5000, quantity: 5, invoice: invoice1)
    create(:invoice_item, unit_price: 10000, quantity: 2, invoice: invoice2)
    create(:invoice_item, unit_price: 3000, quantity: 7, invoice: invoice3)
  end

  it 'sends the top x merchants ranked by total revenue' do
    get '/api/v1/merchants/most_revenue?quantity=2'

    top_merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(top_merchants.first["id"]).to eq(@merchant1.id)
    expect(top_merchants.last["id"]).to eq(@merchant3.id)
  end

  it "sends a merchant's total revenue across successful transactions" do
    invoice1 = create(:invoice, merchant: @merchant1)
    invoice2 = create(:invoice, merchant: @merchant1)
    create(:transaction, invoice: invoice2, result: 'failed')
    create_list(:invoice_item, 2, unit_price: 4500, quantity: 2, invoice: invoice1)
    create_list(:invoice_item, 3, unit_price: 6000, quantity: 2, invoice: invoice2)

    get "/api/v1/merchants/#{@merchant1.id}/revenue"

    revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(revenue).to eq("3500.00")
  end
end


 # /api/v1/merchants/:id/revenue returns the total revenue for that merchant across successful transaction
