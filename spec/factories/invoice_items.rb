FactoryBot.define do
  factory :invoice_item do
    quantity   {[*1..10].sample}
    unit_price {Faker::Number.decimal(l_digits: 2)}
    item
    invoice
  end
end