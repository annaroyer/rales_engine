FactoryBot.define do
  factory :invoice_item do
    item nil
    invoice nil
    quantity 1
    unit_price 1
    created_at "MyString"
    updated_at "MyString"
  end
end
