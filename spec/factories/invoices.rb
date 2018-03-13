FactoryBot.define do
  factory :invoice do
    customer 
    merchant 
    status "MyString"
    created_at "MyString"
    updated_at "MyString"
  end
end
