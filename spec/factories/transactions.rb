FactoryBot.define do
  factory :transaction do
    result                      {['failed', 'success'].sample}
    credit_card_number          {"4#{[*1..9].sample(9).shuffle.split(",").join('')}#{[*0..5].sample(6).shuffle.split(",").join('')}"}
    credit_card_expiration_date {"0#{[*1..9].sample}/2#{[*2..9].sample}"}
    invoice
  end
end