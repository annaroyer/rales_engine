require "rails_helper"

describe 'business intelligence Merchant API endpoint' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)

    invoice1 = create(:invoice, merchant: @merchant1)
    invoice2 = create(:invoice, merchant: @merchant2)
    invoice3 = create(:invoice, merchant: @merchant3)

    create(:invoice_item, unit_price: 5000, quantity: 5, invoice: invoice1)
    create(:invoice_item, unit_price: 10000, quantity: 2, invoice: invoice2)
    create(:invoice_item, unit_price: 3000, quantity: 7, invoice: invoice3)
  end
end
