FactoryBot.define do
  factory :customer do
    first_name {Faker::Dessert.variety}
    last_name {Faker::Science.element}
  end
end

# in customer_spec.rb can call customer = create(:customer), can overwrite with customer = create!(:customer, first_name: "Geraldo")
# create lists(more than one customer) with customers = create_list(:customers, 3), or customers_1, customers_2, customers_3 = create_list(:customer, 3)
