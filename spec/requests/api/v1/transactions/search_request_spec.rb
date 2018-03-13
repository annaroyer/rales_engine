require 'rails_helper'

describe 'Transactions/Search API' do
  it 'finds a transaction by credit card number' do
    credit_card_number = "4654405418249632"
    create(:transaction, credit_card_number: credit_card_number)

    get "/api/v1/transactions/find?credit_card_number=#{credit_card_number}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["credit_card_number"]).to eq(credit_card_number)
  end

  it 'finds a list of transactions by credit card number' do
    credit_card_number = "4654405418249632"
    create_list(:transaction, 3, credit_card_number: credit_card_number)

    get "/api/v1/transactions/find_all?credit_card_number=#{credit_card_number}"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
    transactions.each do |transaction|
      expect(transaction["credit_card_number"]).to eq(credit_card_number)
    end
  end

  it 'finds a transaction by result' do
    result = "success"
    create(:transaction, result: result)

    get "/api/v1/transactions/find?result=#{result}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["result"]).to eq(result)
  end

  it 'finds a list of transactions by result' do
    result = "failed"
    create_list(:transaction, 3, result: result)

    get "/api/v1/transactions/find_all?result=#{result}"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
    transactions.each do |transaction|
      expect(transaction["result"]).to eq(result)
    end
  end

  it 'finds a transaction by result case-insensitive' do
    result = 'failed'
    create(:transaction, result: result)

    get "/api/v1/transactions/find?result=FaILeD"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["result"]).to eq(result)
  end

  it 'finds a list of transaction by result case-insensitive' do
    result = 'failed'
    create_list(:transaction, 3, result: result)

    get "/api/v1/transactions/find_all?result=FaILeD"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
    transactions.each do |transaction|
      expect(transaction["result"]).to eq(result)
    end
  end

  it 'finds a transaction by invoice_id' do
    invoice_id = create(:transaction).invoice_id

    get "/api/v1/transactions/find?invoice_id=#{invoice_id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["invoice_id"]).to eq(invoice_id)
  end

  it 'finds a transaction by id' do
    id = create(:transaction).id

    get "/api/v1/transactions/find?id=#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(id)
  end

  it 'finds a transaction by date created' do
    created_at = "2012-03-27 14:53:59 UTC"
    create(:transaction, created_at: created_at)

    get "/api/v1/transactions/find?created_at=#{created_at}"

    transaction_id = JSON.parse(response.body)["id"]
    transaction = Transaction.find(transaction_id)

    expect(response).to be_success
    expect(transaction.created_at).to eq(created_at.to_datetime)
  end

  it 'finds a list of transactions by date created' do
    created_at = "2012-03-27 14:53:59 UTC"
    create_list(:transaction, 3, created_at: created_at)

    get "/api/v1/transactions/find_all?created_at=#{created_at}"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
  end

  it 'finds a transaction by date updated' do
    updated_at = "2012-03-27 14:53:59 UTC"
    create(:transaction, updated_at: updated_at)

    get "/api/v1/transactions/find?updated_at=#{updated_at}"

    transaction_id = JSON.parse(response.body)["id"]
    transaction = Transaction.find(transaction_id)

    expect(response).to be_success
    expect(transaction.updated_at).to eq(updated_at.to_datetime)
  end

  it 'finds a list of transactions by date updated' do
    updated_at = "2012-03-27 14:53:59 UTC"
    create_list(:transaction, 3, updated_at: updated_at)

    get "/api/v1/transactions/find_all?updated_at=#{updated_at}"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
  end
end
