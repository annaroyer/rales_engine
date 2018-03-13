require 'rails_helper'
require 'time'

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

  it 'finds a merchant by name case-insensitive' do
    name = "Shroeder-Jerde"
    create(:merchant, name: name)

    get "/api/v1/merchants/find?name=#{name.downcase}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["name"]).to eq(name)
  end

  it 'finds a list of merchant by name case-insensitive' do
    name = "Shroeder-Jerde"
    create_list(:merchant, 3, name: name)

    get "/api/v1/merchants/find_all?name=#{name.downcase}"

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
    merchants.each do |merchant|
      expect(merchant["name"]).to eq(name)
    end
  end

  it 'finds a merchant by id' do
    id = 546
    create(:merchant, id: id)

    get "/api/v1/merchants/find?id=#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

  it 'finds a merchant by date created' do
    created_at = "2012-03-27 14:53:59 UTC"
    create(:merchant, created_at: created_at)

    get "/api/v1/merchants/find?created_at=#{created_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["created_at"].to_datetime).to eq(created_at.to_datetime)
  end

  it 'finds a list of merchants by date created' do
    created_at = "2012-03-27 14:53:59 UTC"
    create_list(:merchant, 3, created_at: created_at)

    get "/api/v1/merchants/find_all?created_at=#{created_at}"

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
    merchants.each do |merchant|
      expect(merchant["created_at"].to_datetime).to eq(created_at.to_datetime)
    end
  end

  it 'finds a merchant by date updated' do
    updated_at = "2012-03-27 14:53:59 UTC"
    create(:merchant, updated_at: updated_at)

    get "/api/v1/merchants/find?updated_at=#{updated_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["updated_at"].to_datetime).to eq(updated_at.to_datetime)
  end

  it 'finds a list of merchants by date updated' do
    updated_at = "2012-03-27 14:53:59 UTC"
    create_list(:merchant, 3, updated_at: updated_at)

    get "/api/v1/merchants/find_all?updated_at=#{updated_at}"

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
    merchants.each do |merchant|
      expect(merchant["updated_at"].to_datetime).to eq(updated_at.to_datetime)
    end
  end
end
