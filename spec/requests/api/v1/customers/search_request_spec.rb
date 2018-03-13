require 'rails_helper'

describe 'Customers/Search API' do
  it 'finds a customer by first name' do
    first_name = "Joan"
    create(:customer, first_name: first_name)

    get "/api/v1/customers/find?first_name=#{first_name}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["first_name"]).to eq(first_name)
  end

  it 'finds a list of customers by first name' do
    first_name = "Joan"
    create_list(:customer, 3, first_name: first_name)

    get "/api/v1/customers/find_all?first_name=#{first_name}"

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(3)
    customers.each do |customer|
      expect(customer["first_name"]).to eq(first_name)
    end
  end

  it 'finds a customer by last name' do
    last_name = "Clarke"
    create(:customer, last_name: last_name)

    get "/api/v1/customers/find?last_name=#{last_name}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["last_name"]).to eq(last_name)
  end

  it 'finds a list of customers by last name' do
    last_name = "Clarke"
    create_list(:customer, 3, last_name: last_name)

    get "/api/v1/customers/find_all?last_name=#{last_name}"

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(3)
    customers.each do |customer|
      expect(customer["last_name"]).to eq(last_name)
    end
  end

  it 'finds a customer by first name case-insensitive' do
    first_name = "Joan"
    create(:customer, first_name: first_name)

    get "/api/v1/customers/find?first_name=#{first_name.downcase}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["first_name"]).to eq(first_name)
  end

  it 'finds a list of customer by first name case-insensitive' do
    first_name = "Joan"
    create_list(:customer, 3, first_name: first_name)

    get "/api/v1/customers/find_all?first_name=#{first_name.downcase}"

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(3)
    customers.each do |customer|
      expect(customer["first_name"]).to eq(first_name)
    end
  end

  it 'finds a customer by last name case-insensitive' do
    last_name = "Clarke"
    create(:customer, last_name: last_name)

    get "/api/v1/customers/find?last_name=#{last_name.downcase}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["last_name"]).to eq(last_name)
  end

  it 'finds a list of customer by last name case-insensitive' do
    last_name = "Clarke"
    create_list(:customer, 3, last_name: last_name)

    get "/api/v1/customers/find_all?last_name=#{last_name.downcase}"

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(3)
    customers.each do |customer|
      expect(customer["last_name"]).to eq(last_name)
    end
  end

  it 'finds a customer by id' do
    id = create(:customer).id

    get "/api/v1/customers/find?id=#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["id"]).to eq(id)
  end

  it 'finds a customer by date created' do
    created_at = "2012-03-27 14:53:59 UTC"
    create(:customer, created_at: created_at)

    get "/api/v1/customers/find?created_at=#{created_at}"

    customer_id = JSON.parse(response.body)["id"]
    customer = Customer.find(customer_id)

    expect(response).to be_success
    expect(customer.created_at).to eq(created_at.to_datetime)
  end

  it 'finds a list of customers by date created' do
    created_at = "2012-03-27 14:53:59 UTC"
    create_list(:customer, 3, created_at: created_at)

    get "/api/v1/customers/find_all?created_at=#{created_at}"

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(3)
  end

  it 'finds a customer by date updated' do
    updated_at = "2012-03-27 14:53:59 UTC"
    create(:customer, updated_at: updated_at)

    get "/api/v1/customers/find?updated_at=#{updated_at}"

    customer_id = JSON.parse(response.body)["id"]
    customer = Customer.find(customer_id)

    expect(response).to be_success
    expect(customer.updated_at).to eq(updated_at.to_datetime)
  end

  it 'finds a list of customers by date updated' do
    updated_at = "2012-03-27 14:53:59 UTC"
    create_list(:customer, 3, updated_at: updated_at)

    get "/api/v1/customers/find_all?updated_at=#{updated_at}"

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(3)
  end
end
