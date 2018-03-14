require 'rails_helper'

describe "Transactions Relationship Endpoints" do
  it "returns the associated invoice" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}/invoice"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["customer_id"]).to eq(1)
  end
end
