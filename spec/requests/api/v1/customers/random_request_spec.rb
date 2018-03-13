require 'rails_helper'

describe "Customers Random API" do
  it 'sends a random customer' do
    create_list(:customer, 5)

    get '/api/v1/customers/random'

    customer = JSON.parse(response.body)
    customer_names = Customer.pluck(:last_name)

    expect(response).to be_success
    expect(customer_names).to include(customer["last_name"])
  end
end
