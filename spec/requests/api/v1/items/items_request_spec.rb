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

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end

  it "can find one item by id params" do
    result = create(:item)

    get "/api/v1/items/find?id=#{result.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["id"]).to eq(result.id)
  end

  it "can find one item by name" do
    result = create(:item)

    get "/api/v1/items/find?name=#{result.name}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["name"]).to eq(result.name)
  end

  it "can find one item by description" do
    result = create(:item)

    get "/api/v1/items/find?description=#{result.description}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["description"]).to eq(result.description)
  end

  it "can find one item by unit_price" do
    result = create(:item)

    get "/api/v1/items/find?unit_price=#{result.unit_price}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["unit_price"]).to eq(result.unit_price)
  end

  it "can find one item by time created at" do
    result = create(:item)

    get "/api/v1/items/find?#{result.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["name"]).to eq(result.name)
  end

  it "can find one item by time updated at" do
    result = create(:item)

    get "/api/v1/items/find?#{result.updated_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["name"]).to eq(result.name)
  end

  it "can find all items by id params" do
    result = create(:item)

    get "/api/v1/items/find_all?id=#{result.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item.first["id"]).to eq(result.id)
  end

  it "can find all items by description params" do
    result = create(:item)

    get "/api/v1/items/find_all?description=#{result.description}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item.first["name"]).to eq(result.name)
  end

  it "can find all items by created at params" do
    result = create(:item)

    get "/api/v1/items/find_all?#{result.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item.first["name"]).to eq(result.name)
  end

  it "can find all items by updated at params" do
    result = create(:item)

    get "/api/v1/items/find_all?#{result.updated_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item.first["name"]).to eq(result.name)
  end

  it "can find a random item" do
    get "/api/v1/items/random"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item).to include("name")
  end
end
