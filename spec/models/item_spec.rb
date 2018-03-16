require 'rails_helper'

describe Item, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  context 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
  end

  before(:each) do
    @item1 = create(:item)
    @day_one = '2012-03-25 09:54:09 UTC'
    day_two = '2012-03-09 01:54:10 UTC'
    day_one_invoices = create_list(:invoice, 3, created_at: @day_one)
    day_one_invoices.each do |invoice|
      create(:invoice_item, item: @item1, quantity: 3, invoice: invoice)
      create(:transaction, invoice: invoice)
    end
    day_two_invoices = create_list(:invoice, 2, created_at: day_two)
    day_two_invoices.each do |invoice|
      create(:invoice_item, item: @item1, quantity: 1, invoice: invoice)
      create(:transaction, invoice: invoice)
    end
    @item2 = create(:item)
    invoices2 = create_list(:invoice, 3, created_at: @day_one)
    invoices2.each do |invoice|
      create(:invoice_item, item: @item2, quantity: 5, invoice: invoice)
      create(:transaction, invoice: invoice)
    end
    @item3 = create(:item)
    invoices2 = create_list(:invoice, 4, created_at: @day_one)
    invoices2.each do |invoice|
      create(:invoice_item, item: @item3, quantity: 4, invoice: invoice)
      create(:transaction, invoice: invoice)
    end
  end
  context 'instance methods' do
    describe '#best_day' do
      it 'returns the date with the most sales for the given item' do
        expect(@item1.best_day).to eq(@day_one)
      end
    end
  end

  context 'class methods' do
    describe '.most_items' do
      it 'returns the top x item instances ranked by total number sold' do
        expect(Item.most_items(2)).to eq([@item3, @item1])
      end
    end
  end
end
