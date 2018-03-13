require 'rails_helper'

describe "Merchant relationship endpoints" do
  before :each do
    @merchant = create(:merchant)
    @item1 = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
    @invoice1 = create(:invoice, merchant: @merchant)
    @invoice2 = create(:invoice, merchant: @merchant)
    @invoice3 = create(:invoice, merchant: @merchant)
  end

  it "returns a collection of items associated with that merchant" do
    get "/api/v1/merchants/#{@merchant.id}/items"

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result.count).to eq(2)
  end

  it "returns a collection of invoices associated with that merchant" do
    get "/api/v1/merchants/#{@merchant.id}/invoices"

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result.count).to eq(3)
  end
end
# GET /api/v1/merchants/:id/items returns a collection of items associated with that merchant
# GET /api/v1/merchants/:id/invoices returns a collection of invoices associated with that merchant from their known orders
