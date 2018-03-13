require 'rails_helper'

describe Transaction, type: :model do
  context 'relationships' do
    it { should belong_to :invoice }
  end
end
