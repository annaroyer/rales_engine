require 'rails_helper'

describe "Item BI Endpoints" do
  before :each do
    @item = create(:item)
    create_list(:invoice_item, 10, item: @item, quantity: 3, unit_price: 5000)
    create_list(:invoice_item, 11, item: @item, quantity: 3, unit_price: 5000)
  end

# GET /api/v1/items/most_revenue?quantity=x
  it "returns the top x items ranked by total revenue generated" do
    get "/api/v1/items/most_revenue?quantity=1"

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items.first["id"]).to eq(@item.id)
  end
end
