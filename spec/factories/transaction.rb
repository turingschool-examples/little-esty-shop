FactoryBot.define do
  factory :transaction do
    sequence :credit_card_number do |n|
      16.times { numb << n }.join
    end
    credit_card_expiration_date { Date(2021,10,01) }
    result { :success }
    invoice
  end
end
