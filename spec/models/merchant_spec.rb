require 'rails_helper'

describe Merchant, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
  end

  context 'class methods' do
    before :each do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)
      invoice1 = create(:invoice, merchant: @merchant1)
      invoice2 = create(:invoice, merchant: @merchant2)
      invoice3 = create(:invoice, merchant: @merchant3)
      invoice4 = create(:invoice, merchant: @merchant3)
      create(:invoice_item, unit_price: 4000, quantity: 2, invoice: invoice1)
      create(:invoice_item, unit_price: 5000, quantity: 3, invoice: invoice3)
    end

    describe ".most_revenue" do
      it "should return merchants with the most revenue" do

      expect(Merchant.most_revenue(2)).to eq([@merchant3, @merchant1])
      end
    end

    describe ".most_items" do
      it "should return merchants ranked by total items sold" do

      expect(Merchant.most_items(2)).to eq([@merchant3, @merchant1])
      end
    end
  end
end
