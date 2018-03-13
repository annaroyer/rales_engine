require 'rails_helper'

describe "Items API" do
  before :each do
    @merchant = create(:merchant)
    create_list(:item, 3, merchant: @merchant)
  end

  it "sends a list of items" do
    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end

  # it "can get one item by its id" do
  #   id = create(:item, merchant: @merchant, customer: @customer).id
  #
  #   get "/api/v1/items/#{id}"
  #
  #   item = JSON.parse(response.body)
  #
  #   expect(response).to be_successful
  #   expect(item["id"]).to eq(id)
  # end
  #
  # it "can find one item by id params" do
  #   x = create(:item, merchant: @merchant, customer: @customer)
  #
  #   get "/api/v1/items/find?id=#{x.id}"
  #
  #   expect(response).to be_successful
  #
  #   item = JSON.parse(response.body)
  #
  #   expect(item["id"]).to eq(x.id)
  # end
  #
  # it "can find one item by status" do
  #   x = create(:item, merchant: @merchant, customer: @customer)
  #
  #   get "/api/v1/items/find?status=#{x.status}"
  #
  #   expect(response).to be_successful
  #
  #   item = JSON.parse(response.body)
  #
  #   expect(item["status"]).to eq(x.status)
  # end
  #
  # it "can find one item by time created at" do
  #   x = create(:item, merchant: @merchant, customer: @customer)
  #
  #   get "/api/v1/items/find?#{x.created_at}"
  #
  #   expect(response).to be_successful
  #
  #   item = JSON.parse(response.body)
  #
  #   expect(item["customer_id"]).to eq(x.customer_id)
  # end
  #
  # it "can find one item by time updated at" do
  #   x = create(:item, merchant: @merchant, customer: @customer)
  #
  #   get "/api/v1/items/find?#{x.updated_at}"
  #
  #   expect(response).to be_successful
  #
  #   item = JSON.parse(response.body)
  #
  #   expect(item["customer_id"]).to eq(x.customer_id)
  # end
  #
  # it "can find all items by id params" do
  #   x = create(:item, merchant: @merchant, customer: @customer)
  #
  #   get "/api/v1/items/find_all?id=#{x.id}"
  #
  #   expect(response).to be_successful
  #
  #   item = JSON.parse(response.body)
  #
  #   expect(item.first["id"]).to eq(x.id)
  # end
  #
  # it "can find all items by status params" do
  #   x = create(:item, merchant: @merchant, customer: @customer)
  #
  #   get "/api/v1/items/find_all?status=#{x.status}"
  #
  #   expect(response).to be_successful
  #
  #   item = JSON.parse(response.body)
  #
  #   expect(item.first["customer_id"]).to eq(x.customer_id)
  # end
  #
  # it "can find all items by created at params" do
  #   x = create(:item, merchant: @merchant, customer: @customer)
  #
  #   get "/api/v1/items/find_all?#{x.created_at}"
  #
  #   expect(response).to be_successful
  #
  #   item = JSON.parse(response.body)
  #
  #   expect(item.first["customer_id"]).to eq(x.customer_id)
  # end
  #
  # it "can find all items by updated at params" do
  #   x = create(:item, merchant: @merchant, customer: @customer)
  #
  #   get "/api/v1/items/find_all?#{x.updated_at}"
  #
  #   expect(response).to be_successful
  #
  #   item = JSON.parse(response.body)
  #
  #   expect(item.first["customer_id"]).to eq(x.customer_id)
  # end
  #
  # it "can find a random item" do
  #   get "/api/v1/items/random"
  #
  #   expect(response).to be_successful
  #
  #   item = JSON.parse(response.body)
  #
  #   expect(item).to include("customer_id")
  # end
end
