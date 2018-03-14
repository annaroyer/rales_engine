require 'rails_helper'

describe 'Invoice Items API relationships' do
  before(:each) do
    @invoice_item = create(:invoice_item)
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
