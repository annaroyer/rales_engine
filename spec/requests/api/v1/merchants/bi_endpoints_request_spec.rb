require 'rails_helper'

describe "Merchant BI Endpoints" do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    invoice1 = create(:invoice, merchant: @merchant1)
    invoice2 = create(:invoice, merchant: @merchant2)
    invoice3 = create(:invoice, merchant: @merchant3)
    invoice4 = create(:invoice, merchant: @merchant3)
    create(:invoice_item, unit_price: 4000, quantity: 2, invoice: invoice1)
    create(:invoice_item, unit_price: 5000, quantity: 3, invoice: invoice3)
    create(:invoice_item, unit_price: 6000, quantity: 2, invoice: invoice2)
  end

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
end
