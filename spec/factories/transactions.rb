FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number 1
    result "MyString"
    created_at "MyString"
    updated_at "MyString"
  end
end
