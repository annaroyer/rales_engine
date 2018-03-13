require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
  end

  it 'can get one merchant by id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

  it 'finds a merchant by name' do
    name = "Shroeder-Jerde"
    create(:merchant, name: name)

    get "/api/v1/merchants/find?name=#{name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["name"]).to eq(name)
  end

  it 'finds a list of merchants by name' do
    name = "Shroeder-Jerde"
    create_list(:merchant, 3, name: name)

    get "/api/v1/merchants/find_all?name=#{name}"

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
    merchants.each do |merchant|
      expect(merchant["name"]).to eq(name)
    end
  end
end
