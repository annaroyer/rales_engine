require 'rails_helper'

describe "Merchants Random API" do
  it 'sends a random merchant' do
    create_list(:merchant, 5)

    get '/api/v1/merchants/random'

    merchant = JSON.parse(response.body)
    merchant_names = Merchant.pluck(:name)

    expect(response).to be_success
    expect(merchant_names).to include(merchant["name"])
  end
end
