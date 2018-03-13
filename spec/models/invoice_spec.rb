require 'rails_helper'

describe Invoice, type: :model do
  context "relationships" do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :transactions }
  end
end
