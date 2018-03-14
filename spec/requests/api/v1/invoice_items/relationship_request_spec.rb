require 'rails_helper'

describe 'Invoice Items API relationships' do
  before(:each) do
    invoice = create(:invoice)
    item = create(:item)
    @invoice_item = create(:invoice_item, invoice: invoice, item: item)
  end

  it 'sends the associated invoice' do
    get "/api/v1/invoice_items/#{@invoice_item.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(@invoice_item.invoice_id)
  end

  it 'sends the associated item' do
    get "/api/v1/invoice_items/#{@invoice_item.id}/item"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(@invoice_item.item_id)
  end
end

# GET /api/v1/invoice_items/:id/invoice returns the associated invoice
# GET /api/v1/invoice_items/:id/item returns the associated item
