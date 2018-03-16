require 'rails_helper'

describe "Item BI Endpoints" do
  before :each do
    @item1 = create(:item)

    create_list(:invoice_item, 11, item: @item1, quantity: 3, unit_price: 5000)
    @day_one = '2012-03-25 09:54:09 UTC'
    day_two = '2012-03-09 01:54:10 UTC'
    day_one_invoices = create_list(:invoice, 3, created_at: @day_one)
    day_one_invoices.each do |invoice|
      create_list(:invoice_item, 3, item: @item1, quantity: 3, unit_price: 5000, invoice: invoice)
      create(:transaction, invoice: invoice)
    end
    day_two_invoices = create_list(:invoice, 2, created_at: day_two)
    day_two_invoices.each do |invoice|
      create(:invoice_item, item: @item1, quantity: 1, invoice: invoice)
      create(:transaction, invoice: invoice)
    end
    @item2 = create(:item)
    invoices2 = create_list(:invoice, 3, created_at: @day_one)
    invoices2.each do |invoice|
      create(:invoice_item, item: @item2, quantity: 5, invoice: invoice)
      create(:transaction, invoice: invoice)
    end
    @item3 = create(:item)
    invoices2 = create_list(:invoice, 4, created_at: @day_one)
    invoices2.each do |invoice|
      create(:invoice_item, item: @item3, quantity: 4, invoice: invoice)
      create(:transaction, invoice: invoice)
    end
  end

  it "returns the top x items ranked by total revenue generated" do
    get "/api/v1/items/most_revenue?quantity=1"

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items.first["id"]).to eq(@item1.id)
  end

  it 'sends the top x item instances ranked by total number sold' do
    get '/api/v1/items/most_items?quantity=2'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(@item1.id)
    expect(items.last["id"]).to eq(@item3.id)
  end

  it 'sends the date with the most sales for the given item' do
    get "/api/v1/items/#{@item1.id}/best_day"

    best_day = JSON.parse(response.body)

    expect(response).to be_successful
    expect(best_day["best_day"]).to eq("2012-03-25T09:54:09.000Z")
  end
end
