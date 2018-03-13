require 'rails_helper'

describe Transaction, type: :model do
  context 'validations' do
    it { should validate_presence_of :credit_card_number }
    it { should validate_presence_of :result }
  end
end
