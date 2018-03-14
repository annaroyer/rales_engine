require 'rails_helper'

describe 'Items API relationships' do
  before(:each) do
    @item = create(:item)
  end

  it 'sends a list of the associated invoice items' do
    create_list(:invoice_item, 3, item: @item)
    ii_ids = @item.invoice_items.pluck(:id)

    get "/api/v1/items/#{@item.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    invoice_items.each do |invoice_item|
      expect(ii_ids).to include(invoice_item["id"])
    end
  end

  it 'sends the associated merchant' do
    get "/api/v1/items/#{@item.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(@item.merchant_id)
  end
end

# GET /api/v1/items/:id/invoice_items returns a collection of associated invoice items
# GET /api/v1/items/:id/merchant returns the associated merchant
