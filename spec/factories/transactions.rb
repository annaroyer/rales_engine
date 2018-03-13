FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number 1
    credit_card_expiration_date "2018-03-12 17:46:09"
    result "MyString"
    created_at "MyString"
    updated_at "MyString"
  end
end
