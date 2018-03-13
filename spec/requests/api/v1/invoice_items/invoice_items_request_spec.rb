require 'rails_helper'

describe "Invoice Items API" do
  before :each do
    @item = create(:item)
    @invoice = create(:invoice)
    create_list(:invoice_item, 3, item: @item, invoice: @invoice)
  end

  it "sends a list of invoice_items" do
    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item.count).to eq(3)
  end

  it "can get one invoice by its id" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["id"]).to eq(id)
  end

  it "can find one invoice item by id params" do
    result = create(:invoice_item, item: @item, invoice: @invoice)

    get "/api/v1/invoice_items/find?id=#{result.id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["id"]).to eq(result.id)
  end

  it "can find one invoice item by quantity" do
    result = create(:invoice_item, item: @item, invoice: @invoice)

    get "/api/v1/invoice_items/find?quantity=#{result.quantity}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["quantity"]).to eq(result.quantity)
  end

  it "can find one invoice item by time updated at" do
    result = create(:invoice_item, item: @item, invoice: @invoice)

    get "/api/v1/invoice_items/find?#{result.updated_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["item_id"]).to eq(result.item_id)
  end

  it "can find all invoice_items by id params" do
    result = create(:invoice_item, item: @item, invoice: @invoice)

    get "/api/v1/invoice_items/find_all?id=#{result.id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item.first["id"]).to eq(result.id)
  end

  it "can find all invoice_items by unit_price params" do
    result = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?unit_price=#{result.unit_price}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item.first["unit_price"]).to eq(result.unit_price)
  end

  it "can find all invoice_items by created at params" do
    result = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?#{result.created_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item.first["quantity"]).to eq(result.quantity)
  end

  it "can find all invoice_items by updated at params" do
    result = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?#{result.updated_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item.first["quantity"]).to eq(result.quantity)
  end

  it "can find a random invoice" do
    get "/api/v1/invoice_items/random"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item).to include("invoice_id")
  end
end
