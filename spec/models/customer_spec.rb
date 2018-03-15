require 'rails_helper'

describe Customer, type: :model do
  context 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  context 'instance methods' do
    describe '#favorite_merchant' do
      it 'returns a merchant where the customer has conducted the most successful transactions' do
        customer = create(:customer)
        merchant1 = create(:merchant)
        merchant2 = create(:merchant)

        invoices1 = create_list(:invoice, 3, customer: customer, merchant: merchant1)
        invoices1.each { |invoice| create(:transaction, invoice: invoice) }
        failed_invoice = create(:invoice, customer: customer, merchant: merchant1)
        create(:transaction, invoice: failed_invoice, result: 'failed')
        invoices2 = create_list(:invoice, 4, customer: customer, merchant: merchant2)
        invoices2.each { |invoice| create(:transaction, invoice: invoice) }

        expect(customer.favorite_merchant).to eq(merchant2)
      end
    end
  end
end
