require 'rails_helper'

describe "Transactions Random API" do
  it 'sends a random transaction' do
    create_list(:transaction, 5)

    get '/api/v1/transactions/random'

    transaction = JSON.parse(response.body)
    credit_card_numbers = Transaction.pluck(:credit_card_number)

    expect(response).to be_success
    expect(credit_card_numbers).to include(transaction["credit_card_number"])
  end
end
